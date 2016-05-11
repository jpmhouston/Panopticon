//
//  PANKeyValueObservation.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANKeyValueObservation.h"
#import "PANKeyValueObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@protocol PANMutableKeyValueChange <PANKeyValueChange, PANMutableDetectedObservation>
@property (nonatomic, readwrite, copy) NSString *keyPath;
@property (nonatomic, readwrite) NSDictionary *changeDict;
@property (nonatomic, readwrite) NSUInteger kind;
@property (nonatomic, readwrite, getter=isPrior) BOOL prior;
@property (nonatomic, readwrite, PAN_nullable) id changedValue;
@property (nonatomic, readwrite, PAN_nullable) id oldValue;
@property (nonatomic, readwrite, PAN_nullable) NSIndexSet *indexes;
@end

@interface PANKeyValueObservation () <PANMutableKeyValueChange>
@property (nonatomic, readwrite) NSArray *keyPaths;
@property (nonatomic, readwrite) NSKeyValueObservingOptions options;
@end

@interface PANKeyValueChange () <PANMutableKeyValueChange>
@end

static const int PANKeyValueObservationContextVar;
static void *PANKeyValueObservationContext = (void *)&PANKeyValueObservationContextVar;


#pragma mark -

@implementation PANKeyValueObservation

@synthesize keyPath;
@synthesize changeDict;
@synthesize kind;
@synthesize prior;
@synthesize changedValue;
@synthesize oldValue;
@synthesize indexes;

- (instancetype)initWithObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block
{
    if (!(self = [super initWithObserver:observer object:object queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _keyPaths = keyPaths;
    _options = options;
    return self;
}

- (instancetype)initWithObject:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block
{
    if (!(self = [super initWithObject:object queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _keyPaths = keyPaths;
    _options = options;
    return self;
}

- (void)registerInternal
{
    NSAssert1(!self.registered, @"Attempted double-register of %@", self);
    NSAssert1(self.keyPaths != nil, @"Nil 'keyPaths' property when registering observation for %@", self);
    NSAssert1(self.keyPaths.count > 0, @"Empty 'keyPaths' property when registering observation for %@", self);
    for (NSString *kp in self.keyPaths) {
        [self.object addObserver:self forKeyPath:kp options:self.options context:PANKeyValueObservationContext];
    }
}

- (void)observeValueForKeyPath:(PAN_nullable NSString *)observedKeyPath ofObject:(PAN_nullable id)object change:(PAN_nullable NSDictionary *)changedict context:(PAN_nullable void *)context
{
    if (context == PANKeyValueObservationContext) {
        NSAssert2([self.keyPaths containsObject:observedKeyPath], @"Invoked with unexpected keypath '%@' %@", observedKeyPath, self);
        [self triggerWithSetupBlock:^(id<PANDetectedObservation> obs) {
            if (![obs conformsToProtocol:@protocol(PANMutableKeyValueChange)])
                return;
            id<PANMutableKeyValueChange> change = (id<PANMutableKeyValueChange>)obs;
            change.keyPath = observedKeyPath;
            change.payload = change.changeDict = changedict;
            change.kind = [(NSNumber *)changedict[NSKeyValueChangeKindKey] unsignedIntegerValue];
            change.prior = [(NSNumber *)changedict[NSKeyValueChangeNotificationIsPriorKey] unsignedIntegerValue];
            change.changedValue = changedict[NSKeyValueChangeNewKey];
            change.oldValue = changedict[NSKeyValueChangeOldKey];
            change.indexes = changedict[NSKeyValueChangeIndexesKey];
        }];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:changedict context:context];
    }
}

- (void)duplicateFrom:(id<PANDetectedObservation>)source
{
    [super duplicateFrom:source];
    if (![source conformsToProtocol:@protocol(PANKeyValueChange)])
        return;
    id<PANKeyValueChange> change = (id<PANKeyValueChange>)source;
    self.keyPath = change.keyPath;
    self.changeDict = change.changeDict;
    self.kind = change.kind;
    self.prior = change.prior;
    self.changedValue = change.changedValue;
    self.oldValue = change.oldValue;
    self.indexes = change.indexes;
}

- (void)deregisterInternal
{
    NSAssert1(self.registered, @"Attempted double-removal of %@", self);
    NSAssert1(self.keyPaths != nil, @"Nil 'keyPaths' property when deregistering observation for %@", self);
    NSAssert1(self.keyPaths.count > 0, @"Empty 'keyPaths' property when deregistering observation for %@", self);
    for (NSString *kp in self.keyPaths) {
        [self.object removeObserver:self forKeyPath:kp context:NULL];
    }
}

- (PANDetectedObservation *)createDetectedObservation
{
    return [[PANKeyValueChange alloc] init];
}

+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [self findObservationForObserver:observer object:object keyPaths:keyPaths];
    if (observation != nil) {
        [observation remove];
        return YES;
    }
    return NO;
}

+ (PAN_nullable PANKeyValueObservation *)findObservationForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths
{
    return (PANKeyValueObservation *)[self findObservationForObserver:observer object:object matchingTest:^BOOL(PANObservation *obs) {
        return [obs isKindOfClass:[PANKeyValueObservation class]] && [((PANKeyValueObservation *)obs).keyPaths isEqualToArray:keyPaths];
    }];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: obs=%p, obj=%@ %p, kp=%@>", NSStringFromClass([self class]), self,
            self.observer, NSStringFromClass([self.object class]), self.object, [self.keyPaths componentsJoinedByString:@","]];
}

@end


#pragma mark -

@implementation PANKeyValueChange

@synthesize keyPath;
@synthesize changeDict;
@synthesize kind;
@synthesize prior;
@synthesize changedValue;
@synthesize oldValue;
@synthesize indexes;

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: %fs ago, obj=%@ %p, kp=%@>", NSStringFromClass([self class]), self,
            -[self.timestamp timeIntervalSinceNow], NSStringFromClass([self.object class]), self.object, self.keyPath];
}

@end

PAN_ASSUME_NONNULL_END
