//
//  UIControl+PANUIControl.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PANUIControlObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface UIControl (PANUIControl)

#pragma mark - Observe touch-up-inside events

/**
 *  Observe touch-up-inside events by the receiver.
 *
 *  Details about the event that triggered the observation can be found within the `event` properties of the
 *  observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressInitiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observePressWithBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observePress[InitiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observePress[InitiallyPaused:]withBlock:` that adds a GCD queue parameter. See the description for
 *  that method.
 *
 *  @param queue  The GCD queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing touch-up-inside events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing touch-up-inside events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForPress;

/**
 *  Pause observing touch-up-inside events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing touch-up-inside events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForPress;

/**
 *  Resume observing touch-up-inside events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing touch-up-inside events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForPress;


#pragma mark - Observe value-changed events

/**
 *  Observe value-changed events by the receiver.
 *
 *  Details about the event that triggered the observation can be found within the `event` properties of the
 *  observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueInitiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeValueWithBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeValue[InitiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeValue[InitiallyPaused:]withBlock:` that adds a GCD queue parameter. See the description
 *  for that method.
 *
 *  @param queue  The GCD queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing value-changed events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForValue;

/**
 *  Pause observing value-changed events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForValue;

/**
 *  Resume observing value-changed events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForValue;


#pragma mark - Observe any events

/**
 *  Observe any events by the receiver
 *
 *  Details about the event that triggered the observation can be found within the `event` properties of the
 *  observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param events A bitmask of the events to observe.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeEvents:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeEvents:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the description
 *  for that method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The GCD queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing artbitrary events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @param events A bitmask of the events to stop observing. Must be equal to the bitmask passed to the corresponding
 *                `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing the given events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForEvents:(UIControlEvents)events;

/**
 *  Pause observing artbitrary events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing the given events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForEvents:(UIControlEvents)events;

/**
 *  Resume observing artbitrary events by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  @return `YES` if the receiver was previously observing the given events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForEvents:(UIControlEvents)events;

@end


PAN_ASSUME_NONNULL_END
