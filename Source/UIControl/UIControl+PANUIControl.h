//
//  UIControl+PANUIControl.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PANUIControlObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

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
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressWithBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observePressWithBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `pan_observePressWithBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observePressOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing touch-up-inside events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `pan_observe..`
 *  method, and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForPress;


#pragma mark - Observe value-changed events

/**
 *  Observe value-changed events by the receiver.
 *
 *  Details about the event that triggered the observation can be found within the `event` properties of the
 *  observation when the block is called.
 *
 *  The observation will automatically be stopped when either the control is deallocated.
 *
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueWithBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeValueWithBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueOnQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `pan_observeValueWithBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeValueOnGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing value-changed events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `pan_observe..`
 *  method, and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForValue;


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
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeEvents:withBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `pan_observeEvents:withBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANUIControlObservation *)pan_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing artbitrary events by the receiver.
 *
 *  Call on the same control on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `pan_observe..`
 *  method, and call its `remove` method.
 *
 *  @param events A bitmask of the events to stop observing. Must be equal to the bitmask passed to the corresponding
 *                `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForEvents:(UIControlEvents)events;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
