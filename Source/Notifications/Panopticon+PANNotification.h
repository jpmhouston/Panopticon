//
//  Panopticon+PANNotification.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PanopticonClass.h"
#import "PANNotificationObservation.h"
#import "NSObject+PANNotification.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

@interface Panopticon (PANNotification)

#pragma mark - Anonymously observe notifications from any object

/**
 *  Anonymously observe notifications posted with given name by any object.
 *
 *  Details about the posted notification that triggered the observation can be found within the `notification`,
 *  `postedObject`, and `userInfo` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver is deallocated.
 *
 *  @param name  The notification name to observe.
 *  @param block The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *               a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications posted with given name by any observer, calling its block on the given operation queue.
 *
 *  Variation on `observeAllNotificationsNamed:withBlock:` that adds an operation queue parameter. See the description
 *  for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The operation queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *               a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe notifications posted with given name by any observer, calling its block on the given GCD dispatch
 *  queue.
 *
 *  Variation on `observeAllNotificationsNamed:withBlock:` that adds a GCD dispatch queue parameter. See the description
 *  for that method.
 *
 *  @param name  The notification name to observe.
 *  @param queue The CGD dispatch queue on which to call `block`.
 *  @param block The block to call when observation is triggered, is passed the receiver (which can be used in place of
 *               a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANNotificationObservation *)observeAllNotificationsNamed:(NSString *)name onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop anonymously observing notifications posted with given name by a given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Use to stop observing sometime
 *  before the receiver is deallocated. Alternately, can save the observation object returned from `observe..`, and
 *  call its `remove` method.
 *
 *  @param name The notification name to stop observing.
 *
 *  @return `YES` if the receiver was previously observing notifications named `name` by any object, `NO` otherwise.
 */
+ (BOOL)stopObservingAllNotificationsNamed:(NSString *)name;


#pragma mark - Convenince posting methods

/**
 *  Post notification with a given name from the no particular sender.
 *
 *  @param name The notification name to post.
 */
+ (void)postNotificationNamed:(NSString *)name;

/**
 *  Post notification with a given name from the no particular sender, with the given user info dictionary.
 *
 *  @param name     The notification name to post.
 *  @param userInfo The user info dictionary to include.
 */
+ (void)postNotificationNamed:(NSString *)name userInfo:(PAN_nullable NSDictionary *)userInfo;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
