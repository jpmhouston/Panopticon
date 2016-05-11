//
//  NSObject+PANUIControl.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PANUIControlObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface NSObject (PANUIControl)

#pragma mark - Observe touch-up-inside events

/**
 *  Receiver observes touch-up-inside events by a given control.
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver or the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes touch-up-inside events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeControlForPress:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes touch-up-inside events by a given control, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `pan_observeControlForPress:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForPress:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing touch-up-inside events by a given control.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the control is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param control The control to stop observing
 *
 *  @return `YES` if the receiver was previously observing touch-up-inside events from the given control, `NO` otherwise.
 */
- (BOOL)pan_stopObservingControlForPress:(UIControl *)control;


#pragma mark - Observe value-changed events

/**
 *  Receiver observes value-changed inside events by a given control
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver or the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes value-changed inside events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeControlForValue:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes value-changed inside events by a given control, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `pan_observeControlForValue:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControlForValue:(UIControl *)control onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing value-changed events by a given control.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the control is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param control The control to stop observing
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the given control, `NO` otherwise.
 */
- (BOOL)pan_stopObservingControlForValue:(UIControl *)control;


#pragma mark - Observe any events

/**
 *  Receiver observes artbitrary events by a given control.
 *
 *  Details about the event that triggered the observation can be found within the `sender` and `event` properties of
 *  the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver or the control is deallocated.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes artbitrary events by a given control, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeControl:forEvents:[initiallyPaused:]withBlock:` that adds an operation queue parameter. See
 *  the description for that method.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes artbitrary events by a given control, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeControl:forEvents:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param control The control to observe.
 *  @param events  A bitmask of the events to observe.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                 a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANUIControlObservation *)pan_observeControl:(UIControl *)control forEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing artbitrary events by a given control.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the control is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param control The control to stop observing.
 *  @param events  A bitmask of the events to stop observing. Must be equal to the bitmask passed to the corresponding
 *                 `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing the given events from the given control, `NO` otherwise.
 */
- (BOOL)pan_stopObservingControl:(UIControl *)control forEvents:(UIControlEvents)events;

@end


PAN_ASSUME_NONNULL_END
