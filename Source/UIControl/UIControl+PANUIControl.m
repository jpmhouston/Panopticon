//
//  UIControl+PANUIControl.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "UIControl+PANUIControl.h"
#import "PANUIControlObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation UIControl (PANUIControl)

#pragma mark - touch-up-inside events

- (PAN_nullable PANUIControlObservation *)pan_observePressInitiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observePressWithBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForPress
{
    return [PANUIControlObservation removeForObserver:nil control:self events:UIControlEventTouchUpInside];
}

- (BOOL)pan_pauseObservingForPress
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:UIControlEventTouchUpInside];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingForPress
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:UIControlEventTouchUpInside];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - value-changed events

- (PAN_nullable PANUIControlObservation *)pan_observeValueInitiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeValueWithBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForValue
{
    return [PANUIControlObservation removeForObserver:nil control:self events:UIControlEventValueChanged];
}

- (BOOL)pan_pauseObservingForValue
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:UIControlEventValueChanged];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingForValue
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:UIControlEventValueChanged];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - any events

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForEvents:(UIControlEvents)events
{
    return [PANUIControlObservation removeForObserver:nil control:self events:events];
}

- (BOOL)pan_pauseObservingForEvents:(UIControlEvents)events
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:events];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingForEvents:(UIControlEvents)events
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:nil control:self events:events];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}

@end


PAN_ASSUME_NONNULL_END
