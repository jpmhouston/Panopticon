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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation NSObject (PANAppGroup)

- (nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}


- (nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingAppGroupNotificationsNamed:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:nil name:name retainingState:NO];
}

- (BOOL)pan_stopObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:groupIdentifier name:name retainingState:NO];
}


- (nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}


- (nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:nil name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (nullable PANAppGroupObservation *)pan_observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANCollatedObservationBlock)block
{
    PANAppGroupObservation *observation = [[PANAppGroupObservation alloc] initForReliableDeliveryWithObserver:self groupIdentifier:groupIdentifier name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_pauseObservingReliablyAppGroupNotificationsNamed:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:nil name:name retainingState:YES];
}

- (BOOL)pan_pauseObservingReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [PANAppGroupObservation removeForObserver:self groupIdentifier:groupIdentifier name:name retainingState:YES];
}

@end


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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
