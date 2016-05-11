//
//  PANAppGroupObservation.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-02-23.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANAppGroupObservation.h"
#import "PANAppGroupObservation+Private.h"
#import "PANObservation+Private.h"
#import "PANAppGroupNotificationManager.h"

PAN_ASSUME_NONNULL_BEGIN


@protocol PANMutableAppGroupPost <PANAppGroupPost, PANMutableDetectedObservation>
@property (nonatomic, readwrite) NSString *postedGroupIdentifier;
@end

@interface PANAppGroupObservation () <PANMutableAppGroupPost>
@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite, PAN_nullable) NSString *groupIdentifier;

@property (nonatomic, getter=isReliable) BOOL reliable;
@property (nonatomic) BOOL retainStateOnRemoval;
@end

@interface PANAppGroupPost () <PANMutableAppGroupPost>
@end


#pragma mark -

@implementation PANAppGroupObservation

@synthesize postedGroupIdentifier;

- (instancetype)initWithObserver:(PAN_nullable id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue orGCDQueue:(PAN_nullable dispatch_queue_t)gcdQueue withBlock:(PANObservationBlock)block
{
    if (!(self = [super initWithObserver:observer object:nil queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _name = name.copy;
    _groupIdentifier = identifier.copy;
    _reliable = NO;
    _retainStateOnRemoval = NO;
    return self;
}

- (instancetype)initForReliableDeliveryWithObserver:(PAN_nullable id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block
{
    if (!(self = [super initWithObserver:observer object:nil queue:queue gcdQueue:gcdQueue block:nil]))
        return nil;
    _name = name.copy;
    _groupIdentifier = identifier.copy;
    _reliable = YES;
    _retainStateOnRemoval = YES;
    self.collates = YES;
    return self;
}

- (void)removeStoppingReliableCollection
{
    self.retainStateOnRemoval = NO;
    [super remove];
}

- (void)registerInternal
{
    NSAssert1(!self.registered, @"Attempted double-register of %@", self);
    NSAssert1(self.name != nil, @"Nil 'name' property when registering observation for %@", self);
    NSAssert1(self.name.length > 0, @"Empty 'name' string when registering observation for %@", self);
    
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    NSString *groupIdentifier = self.groupIdentifier;
    if (groupIdentifier == nil) {
        groupIdentifier = appGroupNotificationManager.defaultGroupIdentifier;
        if (groupIdentifier == nil) {
            return;
        }
    }
    
    BOOL ok;
    if (self.reliable)
    {
        ok = [appGroupNotificationManager subscribeToReliableNotificationsForGroupIdentifier:groupIdentifier named:self.name withBlock:^(NSString *identifier, NSString *name, NSArray *postDatesAndPayloads) {
            if (postDatesAndPayloads.count == 0)
                return;
            else if (postDatesAndPayloads.count == 1) {
                // trigger with the single post
                NSArray *postDateAndPayload = postDatesAndPayloads.firstObject;
                
                [self triggerWithSetupBlock:^(id<PANDetectedObservation> obs) {
                    if (![obs conformsToProtocol:@protocol(PANMutableAppGroupPost)])
                        return;
                    id<PANMutableAppGroupPost> post = (id<PANMutableAppGroupPost>)obs;
                    post.timestamp = postDateAndPayload.firstObject;
                    post.payload = (postDateAndPayload.count > 1 ? postDateAndPayload[1] : nil);
                    post.postedGroupIdentifier = groupIdentifier;
                }];
            }
            else {
                // ensure paused then trigger with each post in order
                BOOL wasPaused = self.paused;
                if (!wasPaused)
                    self.paused = YES;
                
                for (NSArray *postDateAndPayload in postDatesAndPayloads) {
                    [self triggerWithSetupBlock:^(id<PANDetectedObservation> obs) {
                        if (![obs conformsToProtocol:@protocol(PANMutableAppGroupPost)])
                            return;
                        id<PANMutableAppGroupPost> post = (id<PANMutableAppGroupPost>)obs;
                        post.timestamp = postDateAndPayload.firstObject;
                        post.payload = (postDateAndPayload.count > 1 ? postDateAndPayload[1] : nil);
                        post.postedGroupIdentifier = groupIdentifier;
                    }];
                }
                
                if (!wasPaused)
                    self.paused = NO;
            }
        }];
    }
    else
    {
        ok = [appGroupNotificationManager subscribeToNotificationsForGroupIdentifier:groupIdentifier named:self.name withBlock:^(NSString *identifier, NSString *name, id payload, NSDate *postDate) {
            [self triggerWithSetupBlock:^(id<PANDetectedObservation> obs) {
                if (![obs conformsToProtocol:@protocol(PANMutableAppGroupPost)])
                    return;
                id<PANMutableAppGroupPost> post = (id<PANMutableAppGroupPost>)obs;
                post.timestamp = postDate;
                post.payload = payload;
                post.postedGroupIdentifier = groupIdentifier;
            }];
        }];
    }
    
    if (!ok) {
        NSLog(@"failed to register observation %@", self);
    }
}

- (void)duplicateFrom:(id<PANDetectedObservation>)source
{
    [super duplicateFrom:source];
    if (![source conformsToProtocol:@protocol(PANAppGroupPost)])
        return;
    id<PANAppGroupPost> post = (id<PANAppGroupPost>)source;
    self.postedGroupIdentifier = post.postedGroupIdentifier;
}

- (PANDetectedObservation *)createDetectedObservation
{
    return [[PANAppGroupPost alloc] init];
}

- (void)deregisterInternal
{
    NSAssert1(self.registered, @"Attempted double-removal of %@", self);
    NSAssert1(self.name != nil, @"Nil 'name' property when deregistering observation for %@", self);
    NSAssert1(self.name.length > 0, @"Empty 'name' string when deregistering observation for %@", self);
    
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    NSString *groupIdentifier = self.groupIdentifier;
    if (groupIdentifier == nil) {
        groupIdentifier = appGroupNotificationManager.defaultGroupIdentifier;
        if (groupIdentifier == nil) {
            return;
        }
    }
    
    BOOL ok;
    if (self.reliable) {
        ok = [appGroupNotificationManager unsubscribeFromReliableNotificationsForGroupIdentifier:groupIdentifier named:self.name allowingReliableResumption:self.retainStateOnRemoval];
    }
    else {
        ok = [appGroupNotificationManager unsubscribeFromNotificationsForGroupIdentifier:groupIdentifier named:self.name];
    }
    
    if (!ok) {
        NSLog(@"failed to deregister observation %@", self);
    }
}

+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name
{
    return [self removeForObserver:observer groupIdentifier:identifier name:name updatingRetainStateMode:nil]; // nil to use the default retaining behavior
}

+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name retainingState:(BOOL)retainState
{
    return [self removeForObserver:observer groupIdentifier:identifier name:name updatingRetainStateMode:&retainState];
}

+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name updatingRetainStateMode:(PAN_nullable BOOL *)inRetainState
{
    PANAppGroupObservation *observation = [self findObservationForObserver:observer groupIdentifier:identifier name:name];
    if (observation != nil) {
        NSAssert([observation isKindOfClass:[PANAppGroupObservation class]], @"");
        if (inRetainState != nil && observation.reliable) {
            observation.retainStateOnRemoval = *inRetainState;
        }
        [observation remove];
        return YES;
    }
    return NO;
}

+ (PAN_nullable PANAppGroupObservation *)findObservationForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name
{
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    NSString *groupIdentifier = appGroupNotificationManager.defaultGroupIdentifier;
    if (groupIdentifier == nil) {
        return nil;
    }
    
    return (PANAppGroupObservation *)[self findObservationForObserver:observer object:nil matchingTest:^BOOL(PANObservation *obs) {
        PANAppGroupObservation *groupObservation = (PANAppGroupObservation *)obs;
        return [obs isKindOfClass:[PANAppGroupObservation class]] && [name isEqualToString:groupObservation.name] && [groupIdentifier isEqualToString:groupObservation.groupIdentifier];
    }];
}

+ (BOOL)postNotificationNamed:(NSString *)name payload:(PAN_nullable id)payload
{
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    NSString *groupIdentifier = appGroupNotificationManager.defaultGroupIdentifier;
    if (groupIdentifier == nil) {
        return NO;
    }
    [appGroupNotificationManager postNotificationForGroupIdentifier:groupIdentifier named:name payload:payload];
    return YES;
}

+ (BOOL)postNotificationForAppGroup:(NSString *)groupIdentifier named:(NSString *)name payload:(PAN_nullable id)payload
{
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    return [appGroupNotificationManager postNotificationForGroupIdentifier:groupIdentifier named:name payload:payload];
}

+ (BOOL)registerAppGroup:(NSString *)groupIdentifier
{
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    if (![appGroupNotificationManager isValidGroupIdentifier:groupIdentifier]) {
        return NO;
    }
    [appGroupNotificationManager addGroupIdentifier:groupIdentifier];
    return YES;
}

+ (void)deregisterAppGroup:(NSString *)groupIdentifier
{
    PANAppGroupNotificationManager *appGroupNotificationManager = [PANAppGroupNotificationManager sharedManager];
    [appGroupNotificationManager removeGroupIdentifier:groupIdentifier];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: obs=%p, n=%@>", NSStringFromClass([self class]), self, self.observer, self.name];
}

@end


#pragma mark -

@implementation PANAppGroupPost

@synthesize postedGroupIdentifier;

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: %fs ago, payload=%@ %p, groupid=%@>", NSStringFromClass([self class]), self,
            -[self.timestamp timeIntervalSinceNow], NSStringFromClass([self.payload class]), self.payload, self.postedGroupIdentifier];
}

@end


PAN_ASSUME_NONNULL_END
