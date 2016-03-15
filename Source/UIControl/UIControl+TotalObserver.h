//
//  UIControl+TotalObserver.h
//  TotalObserver
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOUIControlObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define TO_nullable nullable
#else
#define TO_nullable
#endif

@interface UIControl (TotalObserver)

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
- (TO_nullable TOUIControlObservation *)to_observePressWithBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `to_observePressWithBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observePressOnQueue:(NSOperationQueue *)queue withBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe touch-up-inside events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `to_observePressWithBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observePressOnGCDQueue:(dispatch_queue_t)queue withBlock:(TOAnonymousObservationBlock)block;


/**
 *  Stop observing touch-up-inside events by the receiver.
 *
 *  Call on the same control on which you called one of the `to_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `to_observe..`
 *  method, and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)to_stopObservingForPress;


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
- (TO_nullable TOUIControlObservation *)to_observeValueWithBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `to_observeValueWithBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observeValueOnQueue:(NSOperationQueue *)queue withBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe value-changed events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `to_observeValueWithBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observeValueOnGCDQueue:(dispatch_queue_t)queue withBlock:(TOAnonymousObservationBlock)block;


/**
 *  Stop observing value-changed events by the receiver.
 *
 *  Call on the same control on which you called one of the `to_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `to_observe..`
 *  method, and call its `remove` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)to_stopObservingForValue;


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
- (TO_nullable TOUIControlObservation *)to_observeEvents:(UIControlEvents)events withBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `to_observeEvents:withBlock:` that adds an operation queue parameter. See the description for that
 *  method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observeEvents:(UIControlEvents)events onQueue:(NSOperationQueue *)queue withBlock:(TOAnonymousObservationBlock)block;

/**
 *  Observe any events by the receiver, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `to_observeEvents:withBlock:` that adds a GCD dispatch queue parameter. See the description for that
 *  method.
 *
 *  @param events A bitmask of the events to observe.
 *  @param queue  The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when the key path observation is triggered, is passed the observation (same as the
 *               method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (TO_nullable TOUIControlObservation *)to_observeEvents:(UIControlEvents)events onGCDQueue:(dispatch_queue_t)queue withBlock:(TOAnonymousObservationBlock)block;


/**
 *  Stop observing artbitrary events by the receiver.
 *
 *  Call on the same control on which you called one of the `to_observe..` methods above. Use to stop observing sometime
 *  before the control is deallocated. Alternately, can save the observation object returned from the `to_observe..`
 *  method, and call its `remove` method.
 *
 *  @param events A bitmask of the events to stop observing. Must be equal to the bitmask passed to the corresponding
 *                `to_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing value-changed events from the receiver, `NO` otherwise.
 */
- (BOOL)to_stopObservingForEvents:(UIControlEvents)events;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef TO_nullable
