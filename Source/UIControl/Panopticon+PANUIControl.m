//
//  Panopticon+PANUIControl.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "Panopticon+PANUIControl.h"
#import "PanopticonClass+Private.h"
#import "PANUIControlObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation Panopticon (PANUIControl)

+ (nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControlForPress:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_stopObservingControlForPress:control];
}


+ (nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControlForValue:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_stopObservingControlForValue:control];
}


+ (nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [[self sharedPanopticonObject] pan_stopObservingControl:control forEvents:events];
}

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#else
#undef nullable
#endif
