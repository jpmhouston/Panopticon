//
//  Panopticon+PANAppGroup.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//
//  TODO: add methods for anonymous app group observations
//        would use a private Panopticon singleton as the unspecified observing object
//

#import "PanopticonClass.h"
#import "PANAppGroupObservation.h"
#import "NSObject+PANAppGroup.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

@interface Panopticon (PANAppGroup)

#pragma mark - Registering app groups

/**
 *  Register an app group to observe. Currently this is require to be called before creating any observations.
 *  (Future versions of Panopticon may locate all app group identifiers in the entitlements for your app,
 *  or maybe that's impossible, I haven't checked)
 *
 *  @param groupIdentifier The identifier string for your app group.
 *
 *  @return `YES` if app has been setup in its entitlements as member of the app group, `NO` if the entitilements
 *          cannot be found.
 */
+ (BOOL)registerAppGroup:(NSString *)groupIdentifier;

/**
 *  Deegister an app group to observe. Calling this effectively disables all observations on that app group.
 *  (Currently the observations aren't fully removed, even though the observation block will never get called)
 *
 *  It's not necessary to call this method when the app is shutting down.
 *
 *  @param groupIdentifier The identifier string for your app group.
 */
+ (void)deregisterAppGroup:(NSString *)groupIdentifier;


#pragma mark - Post app group notifications

/**
 *  Post a notification to all apps observing on the given name within the default app group. You may use this
 *  class method instead of a category method `postWithinAppGroupNotificationNamed` on the payload object.
 *  But if your payload is `nil` then you must use this method (or the similar one in `PANAppGroupObservation`).
 *
 *  Currently, you cannot use CFNotificationCenterPostNotification directly, if you do, the notification will not
 *  end up invoking the observation blocks in the observing objects.
 *
 *  The default app group is the last app group that was registered.
 *
 *  @param name    The notification name to post.
 *  @param payload The payload object to pass within the notification, or `nil` if none.
 *
 *  @return `YES` if no default app group is registered, the payload was written to the shared directory, and the
 *          darwin notification was succesfully posted, `NO` otherwise.
 */
+ (BOOL)postNotificationToAppGroupNamed:(NSString *)name payload:(PAN_nullable id)payload;

/**
 *  Post a notification to all apps observing on the given name within the given default app group. You may use
 *  this class method instead of a category method `postWithinAppGroupNotificationNamed` on the payload object.
 *  But if your payload is `nil` then you must use this method (or the similar one in `PANAppGroupObservation`).
 *
 *  Currently, you cannot use CFNotificationCenterPostNotification directly, if you do, the notification will not
 *  end up invoking the observation blocks in the observing objects.
 *
 *  The default app group is the last app group that was registered.
 *
 *  @param groupIdentifier The identifier string for your app group.
 *  @param name            The notification name to post.
 *  @param payload         The payload object to pass within the notification, or `nil` if none.
 *
 *  @return `YES` if the app group is not registered, the payload was written to the shared directory, and the
 *          darwin notification was succesfully posted, `NO` otherwise.
 */
+ (BOOL)postNotificationForAppGroup:(NSString *)groupIdentifier named:(NSString *)name payload:(PAN_nullable id)payload;


#pragma mark - Anonymously observe default app group

/**
 *  Anonymously observe notifications on a given name within the default app group.
 *
 *  As notifications may be received sometime after they were posts, a timestamp when the notification was posted can be
 *  found within the `postedDate` property of the observation when the block is called.
 *
 *  Will fail and return `nil` if a default app group has not first been setup using
 *  `+[PANAppGroupObservation registerAppGroup:]`.
 *
 *  It is an error to observe the same name multiple times within the same app, this method will fail and return `nil`
 *  in that case as well.
 *
 *  @param name  The notification name to observe.
 *  @param block The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  operation queue.
 *
 *  Variation on `observeAppGroupNotificationsNamed:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  GCD dispatch queue.
 *
 *  Variation on `observeAppGroupNotificationsNamed:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Anonymously observe notifications on a given name within the default app group, such that all posts sent are recevied
 *  in order. If the app is unavailable for a time or if notifications are posted too quickly such that the observer
 *  would normally miss some posts, instead it will catch up and receive several all at once later.
 *
 *  As notifications may be received sometime after they were posts, a timestamp when the notification was posted can be
 *  found within the `postedDate` property of the observation when the block is called.
 *
 *  Will fail and return `nil` if a default app group has not first been setup using
 *  `+[PANAppGroupObservation registerAppGroup:]`.
 *
 *  It is an error to observe the same name multiple times within the same app, this method will fail and return `nil`
 *  in that case as well.
 *
 *  @param name  The notification name to observe.
 *  @param block The block to call when observation is triggered, is passed an array of the observations (unlike callback
 *               blocks for other observation methods, this array will contain different observation instances.
 *               Calling remove on one will however remove the original observation, the result from this method).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name withBlock:(PANAnonymousCollatedObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  operation queue.
 *
 *  Variation on `observeReliablyAppGroupNotificationsNamed:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousCollatedObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  GCD dispatch queue.
 *
 *  Variation on `observeReliablyAppGroupNotificationsNamed:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The GCD dispatch queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyAppGroupNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousCollatedObservationBlock)block;


/**
 *  Stop anonymously observed notifications on a given name within the default app group.
 *
 *  Call on the same object on which you called one of the `observe..` methods. Alternately, can save the observation
 *  object returned from `observe..`, and call either its `remove` or `removeStoppingReliableCollection` methods.
 *
 *  For unreliable observations this is equivalent to calling `remove` on the observation. For reliable observations,
 *  this is equivalent to calling `removeStoppingReliableCollection`.
 *
 *  (Unreliable observations are ones started with a `observe...` method, reliable observations are ones started
 *  with a `observeReliably...` method.)
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if a default app group was registered and was previously observing notification on this name, `NO`
 *          otherwise.
 */
+ (BOOL)stopObservingAppGroupNotificationsNamed:(NSString *)name;

/**
 *  Stop anonymously observed notifications on a given name within the default app group. When observing again using a
 *  `observeReliably...` method, it will receive all the posts missed during the interval it was paused. If instead
 *  you were to call `stopObserving...`, then when starting to observe again, some of the intervening posts will not
 *  have been saved.
 *
 *  Call on the same object on which you called one of the `observe..` methods. Alternately, can save the observation
 *  object returned from `observe..`, and call its `remove` method.
 *
 *  If called on a unreliable observation then this will have the same effect as `stopObserving...`.
 *
 *  (Unreliable observations are ones started with a `observe...` method, reliable observations are ones started
 *  with a `observeReliably...` method.)
 *
 *  @param name The notification name to pause observing.
 *
 *  @return `YES` if a default app group was registered and was previously observing notification on this name, `NO`
 *          otherwise.
 */
+ (BOOL)pauseObservingReliablyAppGroupNotificationsNamed:(NSString *)name;


#pragma mark - Anonymously observe specific app group

/**
 *  Anonymously observe notifications on a given name within the given app group.
 *
 *  As notifications may be received sometime after they were posts, a timestamp when the notification was posted can be
 *  found within the `postedDate` property of the observation when the block is called.
 *
 *  Will fail and return `nil` if the given app group has not first been setup using
 *  `+[PANAppGroupObservation registerAppGroup:]`.
 *
 *  It is an error to observe the same name multiple times within the same app, this method will fail and return `nil`
 *  in that case as well.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param block           The block to call when observation is triggered, is passed the receiver (which can be used
 *                         the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  operation queue.
 *
 *  Variation on `observeNotificationsForAppGroup:named:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param queue           The operation queue on which to call `block`.
 *  @param block           The block to call when observation is triggered, is passed the receiver (which can be used
 *                         the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  GCD dispatch queue.
 *
 *  Variation on `observeNotificationsForAppGroup:named:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param queue           The GCD dispatch queue on which to call `block`.
 *  @param block           The block to call when observation is triggered, is passed the receiver (which can be used
 *                         the observation (same as method result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Anonymously observe notifications on a given name within the given app group, such that all posts sent are recevied
 *  in order. If the app is unavailable for a time or if notifications are posted too quickly such that the observer
 *  would normally miss some posts, instead it will catch up and receive several all at once later.
 *
 *  As notifications may be received sometime after they were posts, a timestamp when the notification was posted can be
 *  found within the `postedDate` property of the observation when the block is called.
 *
 *  The observation will automatically be stopped when the receiver is deallocated.
 *
 *  Will fail and return `nil` if the given app group has not first been setup using
 *  `+[PANAppGroupObservation registerAppGroup:]`.
 *
 *  It is an error to observe the same name multiple times within the same app, this method will fail and return `nil`
 *  in that case as well.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param block           The block to call when observation is triggered, is passed an array of the observations
 *                         (unlike callback blocks for other observation methods, this array will contain different
 *                         observation instances. Calling remove on one will however remove the original observation,
 *                         the result from this method).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name withBlock:(PANAnonymousCollatedObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  operation queue.
 *
 *  Variation on `observeReliablyNotificationsForAppGroup:named:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param queue           The operation queue on which to call `block`.
 *  @param block           The block to call when observation is triggered, is passed the observation (same as method
 *                         result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousCollatedObservationBlock)block;

/**
 *  Anonymously observe notifications on a given name within the default app group, calling its block on the given
 *  GCD dispatch queue.
 *
 *  Variation on `observeReliablyNotificationsForAppGroup:named:withBlock:` that adds an operation queue parameter. See the
 *  description for that method.
 *
 *  @param groupIdentifier The app group identifier in which to observe.
 *  @param name            The notification name to observe.
 *  @param queue           The GCD dispatch queue on which to call `block`.
 *  @param block           The block to call when observation is triggered, is passed the observation (same as method
 *                         result).
 *
 *  @return An observation object if registration successful, `nil` otherwise. You often don't need to keep this result.
 */
+ (PAN_nullable PANAppGroupObservation *)observeReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousCollatedObservationBlock)block;


/**
 *  Stop anonymously observed notifications on a given name within the given app group.
 *
 *  Call on the same object on which you called one of the `observe..` methods. Alternately, can save the observation
 *  object returned from `observe..`, and call either its `remove` or `removeStoppingReliableCollection` methods.
 *
 *  For unreliable observations this is equivalent to calling `remove` on the observation. For reliable observations,
 *  this is equivalent to calling its `removeStoppingReliableCollection` method.
 *
 *  (Unreliable observations are ones started with a `observe...` method, reliable observations are ones started
 *  with a `observeReliably...` method.)
 *
 *  @param groupIdentifier The app group identifier in which `name` was being observed.
 *  @param name            The notification name to stop observing.
 *
 *  @return `YES` if the given app group was registered and was previously observing notification on this name, `NO`
 *          otherwise.
 */
+ (BOOL)stopObservingNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name;

/**
 *  Stop anonymously observed notifications on a given name within the given app group. When observing again using a
 *  `observeReliably...` method, it will receive all the posts missed during the interval it was paused. If instead
 *  you were to call `stopObserving...`, then when starting to observe again, some of the intervening posts will not
 *  have been saved.
 *
 *  Call on the same object on which you called one of the `observe..` methods. Alternately, can save the observation
 *  object returned from `observe..`, and call its `remove` method.
 *
 *  If called on a unreliable observation then this will have the same effect as `stopObserving...`.
 *
 *  (Unreliable observations are ones started with a `observe...` method, reliable observations are ones started
 *  with a `observeReliably...` method.)
 *
 *  @param name The notification name to pause observing.
 *
 *  @return `YES` if a default app group was registered and was previously observing notification on this name, `NO`
 *          otherwise.
 */
+ (BOOL)pauseObservingReliablyNotificationsForAppGroup:(NSString *)groupIdentifier named:(NSString *)name;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
