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

PAN_ASSUME_NONNULL_BEGIN


@implementation Panopticon (PANUIControl)

#pragma mark - touch-up-inside events

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForPress:control onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControlForPress:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_stopObservingControlForPress:control];
}

+ (BOOL)pauseObservingControlForPress:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_pauseObservingControlForPress:control];
}

+ (BOOL)resumeObservingControlForPress:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_resumeObservingControlForPress:control];
}


#pragma mark - value-changed events

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControlForValue:control onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControlForValue:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_stopObservingControlForValue:control];
}

+ (BOOL)pauseObservingControlForValue:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_pauseObservingControlForValue:control];
}

+ (BOOL)resumeObservingControlForValue:(UIControl *)control
{
    return [[self sharedPanopticonObject] pan_resumeObservingControlForValue:control];
}


#pragma mark - any events

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeControl:control forEvents:events onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [[self sharedPanopticonObject] pan_stopObservingControl:control forEvents:events];
}

+ (BOOL)pauseObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [[self sharedPanopticonObject] pan_pauseObservingControl:control forEvents:events];
}

+ (BOOL)resumeObservingControl:(UIControl *)control forEvents:(UIControlEvents)events
{
    return [[self sharedPanopticonObject] pan_resumeObservingControl:control forEvents:events];
}

@end


PAN_ASSUME_NONNULL_END
