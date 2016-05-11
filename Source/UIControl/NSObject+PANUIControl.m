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


- (BOOL)pan_stopObservingControlForPress:(UIControl *)control
{
    return [PANUIControlObservation removeForObserver:self control:control events:UIControlEventTouchUpInside];
}

- (BOOL)pan_stopObservingControlForValue:(UIControl *)control
{
    return [PANUIControlObservation removeForObserver:self control:control events:UIControlEventValueChanged];
}

- (BOOL)pan_stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [PANUIControlObservation removeForObserver:self control:control events:events];
}

@end


PAN_ASSUME_NONNULL_END
