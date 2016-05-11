//
//  PANAppGroupObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-02-23.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANObservation.h"

PAN_ASSUME_NONNULL_BEGIN


/**
 *  A protocol for providing the data generated from an app grounp notification. `PANNotificationObservation`
 *  confirms to this protocol and so has these properties, plus notably `payload` and `timestamp` from the
 *  parent protocol.
 */
@protocol PANAppGroupPost <PANDetectedObservation>

/**
 *  Group identifier from a posted app group notification. Useful in cases where the observation's
 *  `groupIdentifier` is `nil`.
 */
@property (nonatomic, readonly) NSString *postedGroupIdentifier;

@end


/**
 *  An object conforming to the PANDetectedObservation protocol. `PANNotificationObservation` property `collated`
 *  is an array of these.
 */
@interface PANAppGroupPost : PANDetectedObservation <PANAppGroupPost>
@end


#pragma mark -

/**
 *  A base class for App Group Notification observation objects.
 *
 *  An object of this class is returned from each `PANAppGroup` `pan_observe...` method. This result can be
 *  saved for explcitly calling the `remove` method later (see base class `PANObservation`), but that often isn't
 *  necessary since the `pan_stopObserving...` methods can be used instead which look-up the matching observation.
 *
 *  The observation object is passed as a parameter to the observation block, and has properties defined by
 *  `PANAppGroupPost` for accessing the payload, and a timestamp when the notification was posted.
 */
@interface PANAppGroupObservation : PANObservation <PANAppGroupPost>

/**
 *  The notification name being observed.
 */
@property (nonatomic, readonly) NSString *name;

/**
 *  Group identifier being observed.
 */
@property (nonatomic, readonly, PAN_nullable) NSString *groupIdentifier;

/**
 *  Whether this is a reliable observation, which by default will retain all missed posts not only while the
 *  observation is paused, but also while the app is inactive and even between app termination and relaunch.
 */
@property (nonatomic, readonly, getter=isReliable) BOOL reliable;


/**
 *  Remove the receiver observation, and if its is a reliable observation then stop collecting posts. The next
 *  reliable observation will not receive posts made inbetween.
 *
 *  This is compared to calling `remove` on a reliable observation which will leave state behind so that
 *  starting a reliable observation again later will receive all the posts missed during the interval inbetween.
 *
 *  For unreliable observations, this has the same behavior as `remove`.
 */
- (void)removeStoppingReliableCollection;


/**
 *  Register an app group to observe. Currently this is require to be called before creating any observations.
 *  (Future versions of Panopticon may locate all app group identifiers in the entitlements for your app,
 *  or maybe that's impossible, I haven't checked)
 *
 *  There is a class method on `Panopticon` that forwards call to this method.
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
 *  There is a class method on `Panopticon` that forwards call to this method.
 *
 *  @param groupIdentifier The identifier string for your app group.
 */
+ (void)deregisterAppGroup:(NSString *)groupIdentifier;


/**
 *  Post a notification to all apps observing on the given name within the default app group. You may use this
 *  class method instead of a category method `pan_postWithinAppGroupNotificationNamed` on the payload object.
 *  But if your payload is `nil` then you must use this method.
 *
 *  Currently, you cannot use CFNotificationCenterPostNotification directly, if you do, the notification will not
 *  end up invoking the observation blocks in the observing objects.
 *
 *  The default app group is the last app group that was registered.
 *
 *  There is a class method on `Panopticon` that forwards call to this method.
 *
 *  @param name    The notification name to post.
 *  @param payload The payload object to pass within the notification, or `nil` if none.
 *
 *  @return `YES` if no default app group is registered, the payload was written to the shared directory, and the
 *          darwin notification was succesfully posted, `NO` otherwise.
 */
+ (BOOL)postNotificationNamed:(NSString *)name payload:(PAN_nullable id)payload;

/**
 *  Post a notification to all apps observing on the given name within the given default app group. You may use
 *  this class method instead of a category method `pan_postWithinAppGroupNotificationNamed` on the payload object.
 *  But if your payload is `nil` then you must use this method.
 *
 *  Currently, you cannot use CFNotificationCenterPostNotification directly, if you do, the notification will not
 *  end up invoking the observation blocks in the observing objects.
 *
 *  The default app group is the last app group that was registered.
 *
 *  There is a class method on `Panopticon` that forwards call to this method.
 *
 *  @param groupIdentifier The identifier string for your app group.
 *  @param name            The notification name to post.
 *  @param payload         The payload object to pass within the notification, or `nil` if none.
 *
 *  @return `YES` if the app group is not registered, the payload was written to the shared directory, and the
 *          darwin notification was succesfully posted, `NO` otherwise.
 */
+ (BOOL)postNotificationForAppGroup:(NSString *)groupIdentifier named:(NSString *)name payload:(PAN_nullable id)payload;


/**
 *  Remove an observer with matching parameters. Can use this class method to look-up a previously registered
 *  observation and remove it, although usually more convenient to use the 'pan_stopObserving' methods, or save the
 *  observation object and call `remove` on it. (see base class `PANObservation`)
 *
 *  Calling this, or the `remove` method directly, on a reliable observation will leave state behind so that
 *  starting a reliable observation again later will receive all the posts missed during the interval inbetween.
 *
 *  On finding the first matching observation, its `remove` method is called before returning. (see base class
 *  `PANObservation`)
 *
 *  @param observer   The observer object.
 *  @param identifier The app group identifier used when creating the observation, if `nil` then default app group
 *                    will be used, which is the last app group that was registered.
 *  @param name       The notification name used when creating the observation.
 *
 *  @return `YES` if matching observation was found, `NO` if it was not found.
 */
+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name;

/**
 *  Remove an observer with matching parameters. Can use this class method to look-up a previously registered
 *  observation and remove it, although usually more convenient to use the 'pan_stopObserving' methods, or save the
 *  observation object and call either `remove` or `removeStoppingReliableCollection` on it. (see base class
 *  `PANObservation`)
 *
 *  Calling this on a reliable observation you can choose whether you want to stop collecting posts, or to leave
 *  state behind so that starting a reliable observation again later will receive all the posts missed during the
 *  interval inbetween. Calling this with `retainState = YES` is equivalent to calling `remove` on the observation
 *  object. Calling this with `retainState = NO` is equivalent to calling `removeStoppingReliableCollection` on
 *  the observation object.
 *
 *  On finding the first matching observation, its `remove` method is called before returning. (see base class
 *  `PANObservation`)
 *
 *  @param observer    The observer object.
 *  @param identifier  The app group identifier used when creating the observation, if `nil` then default app group
 *                     will be used, which is the last app group that was registered.
 *  @param name        The notification name used when creating the observation.
 *  @param retainState Whether to leave state behind and accumulate posts until starting the next reliable
 *                     observation. Unused if this isn't a reliable observation.
 *
 *  @return `YES` if matching observation was found, `NO` if it was not found.
 */
+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name retainingState:(BOOL)retainState;

@end


PAN_ASSUME_NONNULL_END
