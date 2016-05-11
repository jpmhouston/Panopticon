//
//  NSObject+PANAppGroup.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-02-23.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "NSObject+PANAppGroup.h"
#import "PANAppGroupObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation NSObject (PANAppGroup)

#pragma mark - default app group

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingAppGroupNotificationsNamed:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:nil name:name retainingState:NO];
}

- (BOOL)pan_suspendObservingReliablyAppGroupNotificationsNamed:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:nil name:name retainingState:YES];
}

- (BOOL)pan_pauseObservingAppGroupNotificationsNamed:(NSString *)name
{
    PANAppGroupObservation *observation = [PANAppGroupObservation findObservationForObserver:self groupIdentifier:nil name:name];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingAppGroupNotificationsNamed:(NSString *)name
{
    PANAppGroupObservation *observation = [PANAppGroupObservation findObservationForObserver:self groupIdentifier:nil name:name];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - specific app group

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:groupIdentifier name:name retainingState:NO];
}

- (BOOL)pan_suspendObservingReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:groupIdentifier name:name retainingState:YES];
}

- (BOOL)pan_pauseObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    PANAppGroupObservation *observation = [PANAppGroupObservation findObservationForObserver:self groupIdentifier:groupIdentifier name:name];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    PANAppGroupObservation *observation = [PANAppGroupObservation findObservationForObserver:self groupIdentifier:groupIdentifier name:name];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}

@end


#pragma mark -

@implementation NSData (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end

@implementation NSString (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end

@implementation NSArray (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end

@implementation NSDictionary (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end

@implementation NSDate (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end

@implementation NSNumber (PANAppGroup)

- (BOOL)pan_postWithinAppGroupNotificationNamed:(NSString *)name
{
    return [PANAppGroupObservation postNotificationNamed:name payload:self];
}

- (BOOL)pan_postWithinNotificationToAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:self];
}

@end


PAN_ASSUME_NONNULL_END
