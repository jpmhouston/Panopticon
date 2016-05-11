//
//  NSObject+PANNotification.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "NSObject+PANNotification.h"
#import "PANNotificationObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation NSObject (PANNotification)

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:cgdQueue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:cgdQueue block:block];
    [observation register];
    return observation;
}


- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:cgdQueue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:cgdQueue block:block];
    [observation register];
    return observation;
}


- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:cgdQueue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:cgdQueue block:block];
    [observation register];
    return observation;
}


- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:cgdQueue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:cgdQueue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForNotifications:(id)object named:(NSString *)name
{
    return [PANNotificationObservation removeForObserver:self object:object name:name];
}

- (BOOL)pan_stopObservingAllNotificationsNamed:(NSString *)name
{
    return [PANNotificationObservation removeForObserver:self object:nil name:name];
}

- (BOOL)pan_stopObservingOwnNotificationsNamed:(NSString *)name
{
    return [PANNotificationObservation removeForObserver:self object:self name:name];
}

- (BOOL)pan_stopObservingNotificationsNamed:(NSString *)name
{
    return [PANNotificationObservation removeForObserver:nil object:self name:name];
}


- (void)pan_postNotificationNamed:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:nil];
}

- (void)pan_postNotificationNamed:(NSString *)name userInfo:(PAN_nullable NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:userInfo];
}

@end


PAN_ASSUME_NONNULL_END
