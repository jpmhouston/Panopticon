//
//  NSObject+PANUIControl.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "NSObject+PANUIControl.h"
#import "PANUIControlObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation NSObject (PANUIControl)

#pragma mark - touch-up-inside events

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingControlForPress:(UIControl *)control
{
    return [PANUIControlObservation removeForObserver:self control:control events:UIControlEventTouchUpInside];
}

- (BOOL)pan_pauseObservingControlForPress:(UIControl *)control
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:UIControlEventTouchUpInside];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingControlForPress:(UIControl *)control
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:UIControlEventTouchUpInside];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - value-changed events

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingControlForValue:(UIControl *)control
{
    return [PANUIControlObservation removeForObserver:self control:control events:UIControlEventValueChanged];
}

- (BOOL)pan_pauseObservingControlForValue:(UIControl *)control
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:UIControlEventValueChanged];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingControlForValue:(UIControl *)control
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:UIControlEventValueChanged];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - any events

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [PANUIControlObservation removeForObserver:self control:control events:events];
}

- (BOOL)pan_pauseObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:events];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    PANUIControlObservation *observation = [PANUIControlObservation findObservationForObserver:self control:control events:events];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}

@end


PAN_ASSUME_NONNULL_END
