//
//  PANObservation.m
//  Panopticon
//
//  Created by Pierre Houston on 2015-10-15.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//
//  TODO:
//  - consider using a global GCD queue when queue and cgdQueue both nil, either a private one or always
//    the main queue, this is to avoid a triggered observation interrupting its own currenly-running
//    observation block from changing its properties. possible?
//  - alternately make observation object copyable and pass a copy the observation block instead of the
//    original, this prevents that block from being able to compare observation instance pointers,
//    which is probably of limited use anyhow

#import "PANObservation.h"
#import "PANObservation+Private.h"
#import <objc/runtime.h>
#import <objc/message.h>

PAN_ASSUME_NONNULL_BEGIN


@interface PANObservation () <PANMutableDetectedObservation>
@property (nonatomic, readwrite, weak, PAN_nullable) id observer;
@property (nonatomic, readwrite, weak, PAN_nullable) id observee;

@property (nonatomic, readwrite, PAN_nullable) NSOperationQueue *queue;
@property (nonatomic, readwrite, PAN_nullable) dispatch_queue_t gcdQueue;

@property (nonatomic, readwrite, copy, PAN_nullable) PANAnonymousObservationBlock anonymousBlock; // code enforces one of these will be nonnull
@property (nonatomic, readwrite, copy, PAN_nullable) PANObservationBlock objectBlock;

@property (nonatomic, readwrite) BOOL registered;

@property (nonatomic) BOOL inactive; // perhaps will be made public
@end


static const int PANObservationSetKeyVar;
static void *PANObservationSetKey = (void *)&PANObservationSetKeyVar;

static NSMutableSet *classesSwizzledSet = nil;


#pragma mark -

@implementation PANObservation

@synthesize object;
@synthesize payload;
@synthesize timestamp;

- (instancetype)init
{
    self = [super init];
    // had this to prevent this from being used,
    //[NSException raise:NSInternalInconsistencyException format:@"PANObservation base class must not be initialized"];
    // but now this *is* legitamitely used specifically when temporarily completing init of an observation
    // before discarding it and returning nil, which subclass can do using 'if (fail-condition) return [super init];'
    if (self != nil) self = nil;
    return nil;
}

- (instancetype)initWithObserver:(PAN_nullable id)observer object:(PAN_nullable id)observee queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)cgdQueue block:(PAN_nullable PANObservationBlock)block
{
    if (!(self = [super init]))
        return nil;
    _observer = observer;
    _observee = observee;
    _queue = queue;
    _gcdQueue = cgdQueue;
    _objectBlock = block;
    _removeAutomatically = YES;
    return self;
}

- (instancetype)initWithObject:(PAN_nullable id)observee queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)cgdQueue block:(PAN_nullable PANAnonymousObservationBlock)block
{
    if (!(self = [super init]))
        return nil;
    _observee = observee;
    _queue = queue;
    _gcdQueue = cgdQueue;
    _anonymousBlock = block;
    _removeAutomatically = YES;
    return self;
}

- (void)register
{
    if (self.registered)
        [NSException raise:NSGenericException format:@"Observation already registered, cannot register again"];
    
    [self registerInternal];
    [self storeAssociatedObservation];
    [self adoptAutomaticRemoval];
    self.registered = YES;
}

- (void)remove
{
    if (!self.registered)
        return;
    
    [self deregisterInternal];
    [self removeAssociatedObservation];
    self.registered = NO;
}

- (void)setPaused:(BOOL)paused
{
    if (paused && !self.inactive) {
        [self pause];
    }
    else if (!paused && !self.inactive) {
        [self unpause];
    }
    _paused = paused;
}

- (void)setInactive:(BOOL)inactive
{
    if (inactive && !self.paused) {
        [self pause];
    }
    else if (!inactive && !self.paused) {
        [self unpause];
    }
    _inactive = inactive;
}

- (void)pause
{
    if (self.collates) {
        self.collated = [NSArray array];
    }
    else {
        self.collated = nil;
    }
}

- (void)unpause
{
    if (self.collated.count > 0) {
        [self invokeSynchronously:NO afterSetup:^{
            [self duplicateFrom:self.collated.lastObject];
        }];
    }
    self.collated = nil;
}

- (void)triggerWithSetupBlock:(void(^)(id<PANDetectedObservation>))setup
{
    [self triggerSynchronously:NO withSetupBlock:setup];
}

- (void)triggerSynchronously:(BOOL)synchronously withSetupBlock:(void(^)(id<PANDetectedObservation>))setup
{
    if (self.collated != nil) {
        PANDetectedObservation *detectedObservation = [self createDetectedObservation];
        detectedObservation.object = self.observee;
        detectedObservation.timestamp = [NSDate date];
        setup(detectedObservation);
        
        self.collated = [self.collated arrayByAddingObject:detectedObservation];
    }
    else if (!self.paused && !self.inactive) {
        [self invokeSynchronously:synchronously afterSetup:^{
            self.object = self.observee;
            self.timestamp = [NSDate date];
            setup(self);
        }];
    }
    // if paused or inactive, ignore the triggered observation
}

- (void)invokeSynchronously:(BOOL)synchronously afterSetup:(void(^)(void))setup
{
    if (self.anonymousBlock != nil) {
        [self invokeSynchronously:synchronously afterSetup:setup using:^{
            self.anonymousBlock(self);
        }];
    }
    else if (self.objectBlock != nil) {
        [self invokeSynchronously:synchronously afterSetup:setup using:^{
            self.objectBlock(self.observer, self);
        }];
    }
    else
        [NSException raise:NSInternalInconsistencyException format:@"Nil 'block' & 'objectBlock' properties when invoking observation %@", self];
}

- (void)invokeSynchronously:(BOOL)synchronously afterSetup:(void(^)(void))setup using:(void(^)(void))invoke
{
    if (!synchronously && self.queue != nil) {
        [self.queue addOperationWithBlock:^{
            setup();
            invoke();
        }];
    }
    else if (!synchronously && self.gcdQueue != nil) {
        dispatch_async(self.gcdQueue, ^{
            setup();
            invoke();
        });
    }
    else {
        setup();
        invoke();
    }
}


- (void)duplicateFrom:(id<PANDetectedObservation>)source
{
    self.object = source.object;
    self.timestamp = source.timestamp;
    self.payload = source.payload;
}

- (PANDetectedObservation *)createDetectedObservation
{
    [NSException raise:NSInternalInconsistencyException format:@"PANObservation createDetectedObservation should not be called"];
    return [PANDetectedObservation new];
}

- (void)registerInternal
{
    [NSException raise:NSInternalInconsistencyException format:@"PANObservation registerInternal should not be called"];
}

- (void)deregisterInternal
{
    [NSException raise:NSInternalInconsistencyException format:@"PANObservation registerInternal should not be called"];
}


#pragma mark -

- (void)storeAssociatedObservation
{
    NSAssert1(self.observer != nil || self.observee != nil, @"Nil 'observer' & 'observee' properties when storing observation %@", self);
    // store into *both* observer & observee, although that may not be obvious
    // of course we want to remove the observation if the observer goes away, but also if the observee does too
    if (self.observer != nil)
        [[self class] storeAssociatedObservation:self intoObject:self.observer];
    if (self.observee != nil && self.observee != self.observer)
        [[self class] storeAssociatedObservation:self intoObject:self.observee];
}

- (void)removeAssociatedObservation
{
    NSAssert1(self.observer != nil || self.observee != nil, @"Nil 'observer' & 'observee' properties when removing observation %@", self);
    if (self.observer != nil)
        [[self class] removeAssociatedObservation:self fromObject:self.observer];
    if (self.observee != nil && self.observee != self.observer)
        [[self class] removeAssociatedObservation:self fromObject:self.observee];
}

+ (void)storeAssociatedObservation:(PANObservation *)observation intoObject:(id)associationTarget
{
    NSMutableSet *observationSet = nil;
    @synchronized(associationTarget) {
        
        observationSet = objc_getAssociatedObject(associationTarget, &PANObservationSetKey);
        if (observationSet == nil) {
            observationSet = [NSMutableSet set];
            objc_setAssociatedObject(associationTarget, &PANObservationSetKey, observationSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
    }
    @synchronized(observationSet) {
        
        [observationSet addObject:observation];
        
    }
}

+ (void)removeAssociatedObservation:(PANObservation *)observation fromObject:(id)associationTarget
{
    NSMutableSet *observationSet = nil;
    @synchronized(associationTarget) {
        
        observationSet = objc_getAssociatedObject(associationTarget, &PANObservationSetKey);
        
    }
    if (observationSet != nil) {
        @synchronized(observationSet) {
            
            [observationSet removeObject:observation];
            // don't bother removing the set when its empty, would have to use another @synchronized(associationTarget) block
            
        }
    }
}

+ (NSSet *)associatedObservationsForObserver:(id)observer
{
    return [self associatedObservationsForObject:observer];
}

+ (NSSet *)associatedObservationsForObservee:(id)observee
{
    return [self associatedObservationsForObject:observee];
}

+ (NSSet *)associatedObservationsForObserver:(PAN_nullable id)observer observee:(PAN_nullable id)observee
{
    NSParameterAssert(observer != nil || observee != nil);
    return [self associatedObservationsForObject:observer != nil ? observer : observee]; // observer if its not nil, otherwise observee
}

+ (NSSet *)associatedObservationsForObject:(id)associationTarget
{
    NSMutableSet *observationSet = nil;
    @synchronized(associationTarget) {
        
        observationSet = objc_getAssociatedObject(associationTarget, &PANObservationSetKey);
        
    }
    if (observationSet != nil) {
        @synchronized(observationSet) {
            
            observationSet = [observationSet copy];
            
        }
    }
    return observationSet;
}

+ (PANObservation *)findObservationForObserver:(PAN_nullable id)observer object:(PAN_nullable id)observee matchingTest:(BOOL(^)(PANObservation *observation))testBlock
{
    PANObservation *foundObservation = nil;
    NSSet *observationSet = [self associatedObservationsForObserver:observer observee:observee];
    
    for (PANObservation *observation in observationSet) {
        // note, self here is class of subclass whose class method called this superclass class method
        // eg. if PANNotificationObservation class method called this, then self is PANNotificationObservation instead of PANObservation
        if ([observation isKindOfClass:self] && observer == observation.observer && observee == observation.observee && testBlock(observation)) {
            foundObservation = observation;
            break;
        }
    }
    return foundObservation;
}


#pragma mark -

- (void)adoptAutomaticRemoval
{
    NSAssert1(self.observer != nil || self.observee != nil, @"Nil 'observer' & 'observee' properties when adopting auto-removal for observation %@", self);
    if (self.observer != nil)
        [[self class] swizzleDeallocIfNeededForClass:[self.observer class]];
    if (self.observee != nil && self.observee != self.observer)
        [[self class] swizzleDeallocIfNeededForClass:[self.observee class]];
}

+ (void)swizzleDeallocIfNeededForClass:(Class)class
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classesSwizzledSet = [NSMutableSet set];
    });
    
    // taken directly from _swizzleObjectClassIfNeeded in https://github.com/mikeash/MAKVONotificationCenter/blob/master/MAKVONotificationCenter.m
    
    @synchronized(classesSwizzledSet) {
        
        if (![classesSwizzledSet containsObject:class]) {
            // here be dragons
            SEL deallocSel = NSSelectorFromString(@"dealloc");
            Method dealloc = class_getInstanceMethod(class, deallocSel);
            IMP origImpl = method_getImplementation(dealloc);
            IMP newImpl = imp_implementationWithBlock(^(void *obj) { // MAKVONotificationCenter casts its block to (__bridge void *), but that's giving error here :(
                @autoreleasepool {
                    [PANObservation performAutomaticRemovalForObject:(__bridge id)obj];
                }
                ((void (*)(void *, SEL))origImpl)(obj, deallocSel);
            });
            
            class_replaceMethod(class, deallocSel, newImpl, method_getTypeEncoding(dealloc));
            
            [classesSwizzledSet addObject:class];
        }
        
    }
}

+ (void)performAutomaticRemovalForObject:(id)objectBeingDeallocated
{
    NSSet *observationSet = [self associatedObservationsForObject:objectBeingDeallocated]; // observations both by the object & on the object
    for (PANObservation *observation in observationSet) {
        if (observation.removeAutomatically)
            [observation remove];
    }
}

@end


#pragma mark -

@implementation PANDetectedObservation

@synthesize object;
@synthesize payload;
@synthesize timestamp;

@end


PAN_ASSUME_NONNULL_END
