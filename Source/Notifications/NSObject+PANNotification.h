//
//  NSObject+PANNotification.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANNotificationObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface NSObject (PANNotification)

#pragma mark - Anonymously observe notifications from object

/**
 *  Receiver observes notifications posted with given name by a given object.
 *
 *  Details about the posted notification that triggered the observation can be found within the `notification`,
 *  and `userInfo` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver or the object is deallocated.
 *
 *  If `object` is the same as the receiver, then instead use `pan_observeOwnNotificationsNamed:withBlock:`.
 *
 *  @param object The object to observe.
 *  @param name   The notification name to observe.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name withBlock:(PANObservationBlock)block;


/**
 *  Receiver observes notifications posted with given name by a given object, calling its block on the given operation
 *  queue.
 *
 *  Variation on `pan_observeForNotifications:named:[initiallyPaused:]withBlock:` that adds an operation queue parameter.
 *  See the description for that method.
 *
 *  @param object The object to observe.
 *  @param name   The notification name to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes notifications posted with given name by a given object, calling its block on the given Grand Central
 *  Dispatch queue.
 *
 *  Variation on `pan_observeForNotifications:named:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param object The object to observe.
 *  @param name   The notification name to observe.
 *  @param queue  The CGD dispatch queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onGCDQueue:(dispatch_queue_t)gcdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeForNotifications:(id)object named:(NSString *)name onGCDQueue:(dispatch_queue_t)gcdQueue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the observed object is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param object The object to stop observing.
 *  @param name   The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by `object`, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForNotifications:(id)object named:(NSString *)name;

/**
 *  Receiver pauses observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param object The object to stop observing.
 *  @param name   The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by `object`, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForNotifications:(id)object named:(NSString *)name;

/**
 *  Receiver resumes observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param object The object to stop observing.
 *  @param name   The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by `object`, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForNotifications:(id)object named:(NSString *)name;


#pragma mark - Anonymously observe notifications from any object

/**
 *  Receiver observes notifications posted with given name by any object.
 *
 *  Details about the posted notification that triggered the observation can be found within the `notification`,
 *  `postedObject`, and `userInfo` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver is deallocated.
 *
 *  @param name   The notification name to observe.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes notifications posted with given name by any observer, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeAllNotificationsNamed:[initiallyPaused:]withBlock:` that adds an operation queue parameter.
 *  See the description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes notifications posted with given name by any observer, calling its block on the given Grand Central
 *  Dispatch queue.
 *
 *  Variation on `pan_observeAllNotificationsNamed:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The CGD dispatch queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver is deallocated. Alternately, can save the observation object returned from `pan_observe..`, and
 *  call its `remove` method.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by any object, `NO` otherwise.
 */
- (BOOL)pan_stopObservingAllNotificationsNamed:(NSString *)name;

/**
 *  Receiver pauses observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by any object, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingAllNotificationsNamed:(NSString *)name;

/**
 *  Receiver resumes observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by any object, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingAllNotificationsNamed:(NSString *)name;


#pragma mark - Anonymously observe notifications from object

/**
 *  Observe notifications posted with given name by the receiver.
 *
 *  Details about the posted notification that triggered the observation can be found within the `notification`,
 *  and `userInfo` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver is deallocated.  The observation is not tied to
 *  any "observer" object.
 *
 *  @param name   The notification name to observe.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe notifications posted with given name by the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeNotificationsNamed:[initiallyPaused:]withBlock:` that adds an operation queue parameter.
 *  See the description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe notifications posted with given name by the receiver, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `pan_observeNotificationsNamed:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The CGD dispatch queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when the key path observation is triggered, is passed the observation (same as the
 *                method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stops observing notifications posted with given name by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver is deallocated. Alternately, can save the observation object returned from `pan_observe..`, and
 *  call its `remove` method.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was previously observing notifications named `name` by the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingNotificationsNamed:(NSString *)name;

/**
 *  Pauses observing notifications posted with given name by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was previously observing notifications named `name` by the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingNotificationsNamed:(NSString *)name;

/**
 *  Resumes observing notifications posted with given name by the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was previously observing notifications named `name` by the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingNotificationsNamed:(NSString *)name;


#pragma mark - Have receiver observe notifications from itself

/**
 *  Receiver observes notifications it posts with given name.
 *
 *  Details about the posted notification that triggered the observation can be found within the `notification`,
 *  and `userInfo` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver is deallocated.
 *
 *  Use instead of `-[self pan_observeNotificationsNamed:withBlock:]` when you want the receiver passed as parameter to
 *  the block, or when you want to make extra clear that the object is intentionally observing itself.
 *
 *  @param name   The notification name to observe.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes notifications it posts with given name, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeOwnNotificationsNamed:[initiallyPaused:]withBlock:` that adds an operation queue parameter.
 *  See the description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The operation queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes notifications it posts with given name, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeOwnNotificationsNamed:[initiallyPaused:]withBlock:` that adds a GCD queue parameter. See the
 *  description for that method.
 *
 *  @param name   The notification name to observe.
 *  @param queue  The CGD dispatch queue on which to call `block`.
 *  @param paused Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block  The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *                a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANNotificationObservation *)pan_observeOwnNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)cgdQueue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing notifications it posts with given name.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver is deallocated. Alternately, can save the observation object returned from `pan_observe..`, and
 *  call its `remove` method.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was receiver previously observing notifications named `name` by itself, `NO` otherwise.
 */
- (BOOL)pan_stopObservingOwnNotificationsNamed:(NSString *)name;

/**
 *  Receiver pauses observing notifications it posts with given name.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was receiver previously observing notifications named `name` by itself, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingOwnNotificationsNamed:(NSString *)name;

/**
 *  Receiver resumes observing notifications it posts with given name.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if was receiver previously observing notifications named `name` by itself, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingOwnNotificationsNamed:(NSString *)name;


#pragma mark - Convenince posting methods

/**
 *  Post notification with a given name by the receiver.
 *
 *  @param name The notification name to post.
 */
- (void)pan_postNotificationNamed:(NSString *)name;

/**
 *  Post notification with a given name by the receiver, with the given user info dictionary.
 *
 *  @param name     The notification name to post.
 *  @param userInfo The user info dictionary to include.
 */
- (void)pan_postNotificationNamed:(NSString *)name userInfo:(PAN_nullable NSDictionary *)userInfo;

@end


PAN_ASSUME_NONNULL_END
