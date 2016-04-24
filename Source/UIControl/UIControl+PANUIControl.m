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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation UIControl (PANUIControl)

- (nullable PANUIControlObservation *)pan_observePressWithBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventTouchUpInside queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANUIControlObservation *)pan_observeValueWithBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:UIControlEventValueChanged queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANUIControlObservation *observation = [[PANUIControlObservation alloc] initWithControl:self events:events queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForPress
{
    return [PANUIControlObservation removeForObserver:nil control:self events:UIControlEventTouchUpInside];
}

- (BOOL)pan_stopObservingForValue
{
    return [PANUIControlObservation removeForObserver:nil control:self events:UIControlEventValueChanged];
}

- (BOOL)pan_stopObservingForEvents:(UIControlEvents)events
{
    return [PANUIControlObservation removeForObserver:nil control:self events:events];
}

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
