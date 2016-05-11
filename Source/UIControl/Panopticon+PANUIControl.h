//
//  Panopticon+PANUIControl.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PanopticonClass.h"
#import "PANUIControlObservation.h"
#import "NSObject+PANUIControl.h"

PAN_ASSUME_NONNULL_BEGIN


@interface Panopticon (PANUIControl)

#pragma mark - Anonymously observe touch-up-inside events

/**
 *  Anonymously observe touch-up-inside events by a given control.
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe touch-up-inside events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `observeControlForPress:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe touch-up-inside events by a given control, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `observeControlForPress:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Receiver stops observing touch-up-inside events by a given control.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from `observe..`, and call
 *  its `remove` method.
 *
 *  @param control The control to stop observing
 *
 *  @return `YES` if was previously observing touch-up-inside events from the given control, `NO` otherwise.
 */
+ (BOOL)stopObservingControlForPress:(UIControl *)control;


#pragma mark - Anonymously observe value-changed events

/**
 *  Anonymously observe value-changed inside events by a given control
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe value-changed inside events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `observeControlForValue:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe value-changed inside events by a given control, calling its block on the given Grand Central
 *  Dispatch queue.
 *
 *  Variation on `observeControlForValue:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Receiver stops observing value-changed events by a given control.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from`observe..`, and call
 *  its `remove` method.
 *
 *  @param control The control to stop observing
 *
 *  @return `YES` if was previously observing value-changed events from the given control, `NO` otherwise.
 */
+ (BOOL)stopObservingControlForValue:(UIControl *)control;


#pragma mark - Anonymously observe any events

/**
 *  Anonymously observe artbitrary events by a given control.
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe artbitrary events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `observeControl:forEvents:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe artbitrary events by a given control, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `observeControl:forEvents:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANUIControlObservation *)observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Receiver stops observing artbitrary events by a given control.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from `observe..`, and call
 *  its `remove` method.
 *
 *  @param control The control to stop observing.
 *  @param events  A bitmask of the events to stop observing. Must be equal to the bitmask passed to the corresponding
 *                 `observe..` method.
 *
 *  @return `YES` if was previously observing the given events from the given control, `NO` otherwise.
 */
+ (BOOL)stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events;

@end


PAN_ASSUME_NONNULL_END
