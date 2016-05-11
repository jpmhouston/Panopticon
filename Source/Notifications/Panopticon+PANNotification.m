//
//  Panopticon+PANNotification.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "Panopticon+PANNotification.h"
#import "PanopticonClass+Private.h"
#import "PANNotificationObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation Panopticon (PANNotification)

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAllNotificationsNamed:name onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingAllNotificationsNamed:(NSString *)name
{
    return [[self sharedPanopticonObject] pan_stopObservingAllNotificationsNamed:name];
}


+ (void)postNotificationNamed:(NSString *)name
{
    [[self sharedPanopticonObject] pan_postNotificationNamed:name];
}

+ (void)postNotificationNamed:(NSString *)name userInfo:(PAN_nullable NSDictionary *)userInfo
{
    [[self sharedPanopticonObject] pan_postNotificationNamed:name userInfo:userInfo];
}

@end


PAN_ASSUME_NONNULL_END
