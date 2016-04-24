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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation NSObject (PANNotification)

- (nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:object name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:nil name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObserver:self object:self name:name queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANNotificationObservation *observation = [[PANNotificationObservation alloc] initWithObject:self name:name queue:nil gcdQueue:queue block:block];
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

- (void)pan_postNotificationNamed:(NSString *)name userInfo:(nullable NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:userInfo];
}

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
