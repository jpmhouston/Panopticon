//
//  PanopticonClass+PANAppGroup.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "Panopticon+PANAppGroup.h"
#import "PanopticonClass+Private.h"
#import "PANAppGroupObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation Panopticon (PANAppGroup)

+ (BOOL)registerAppGroup:(NSString *)groupIdentifier
{
    return [PANAppGroupObservation registerAppGroup:groupIdentifier];
}

+ (void)deregisterAppGroup:(NSString *)groupIdentifier
{
    [PANAppGroupObservation deregisterAppGroup:groupIdentifier];
}


+ (BOOL)postNotificationToAppGroupNamed:(NSString *)name payload:(PAN_nullable id)payload
{
    return [PANAppGroupObservation postNotificationNamed:name payload:payload];
}

+ (BOOL)postNotificationForAppGroup:(NSString *)groupIdentifier named:(NSString *)name payload:(PAN_nullable id)payload
{
    return [PANAppGroupObservation postNotificationForAppGroup:groupIdentifier named:name payload:payload];
}


+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeAppGroupNotificationsNamed:name onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyAppGroupNotificationsNamed:name onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingAppGroupNotificationsNamed:(NSString *)name
{
    return [[self sharedPanopticonObject] pan_stopObservingAppGroupNotificationsNamed:name];
}

+ (BOOL)pauseObservingReliablyAppGroupNotificationsNamed:(NSString *)name
{
    return [[self sharedPanopticonObject] pan_pauseObservingReliablyAppGroupNotificationsNamed:name];
}


+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeNotificationsForAppGroup:groupIdentifier named:name onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeReliablyNotificationsForAppGroup:groupIdentifier named:name onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [[self sharedPanopticonObject] pan_stopObservingNotificationsForAppGroup:groupIdentifier named:name];
}

+ (BOOL)pauseObservingReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name
{
    return [[self sharedPanopticonObject] pan_pauseObservingReliablyNotificationsForAppGroup:groupIdentifier named:name];
}

@end


PAN_ASSUME_NONNULL_END
