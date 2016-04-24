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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation NSObject (PANUIControl)

- (nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithObserver:self control:control events:events queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
