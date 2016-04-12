//
//  PANNotificationObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//
//  TODO:
//  - consider renaming `postedObject` property to `payload` for more consistency with the terminology of other
//    observation subclasses and also some of our documentation

#import "PANObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

/**
 *  A base class for NSNotification observation objects.
 *
 *  An object of this class is returned from each `PANNotification` `pan_observe...` method. This result
 *  can be saved for explcitly calling the `remove` method later (see base class `PANObservation`), but that often
 *  isn't necessary since the `pan_stopObserving...` methods can be used instead which look-up the matching observation.
 *
 *  The observation object is passed as a parameter to the observation block, and defines properties for accessing
 *  the name, notification object, or its specific values directly, the posted object and user info dictionary.
 */
@interface PANNotificationObservation : PANObservation

/**
 *  The notification name being observed.
 */
@property (nonatomic, readonly, copy) NSString *name;


/**
 *  A notification that triggered an observation. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly) NSNotification *notification;

/**
 *  The object that posted the notification. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly, PAN_nullable) id postedObject;

/**
 *  The user info dictionary within a posted notification. Value undefined except within call to an observation
 *  block. A shortcut for `notification.userInfo`.
 */
@property (nonatomic, readonly, PAN_nullable) NSDictionary *userInfo;


/**
 *  Remove an observer with matching parameters. Can use this class method to look-up a previously registered
 *  observation and remove it, although usually more convenient to use the 'pan_stopObserving' methods, or save the
 *  observation object and call `remove` on it. (see base class `PANObservation`)
 *
 *  Must not call with both `observer` and `object` equal to `nil`.
 *
 *  On finding the first matching observation, its `remove` method is called before returning. (see base class
 *  `PANObservation`)
 *
 *  @param observer The observer object, or `nil` if not applicable.
 *  @param object   The object being observed, or `nil` if not applicable.
 *  @param name     The notification name used when creating the observation.
 *
 *  @return `YES` if matching observation was found, `NO` if it was not found.
 */
+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(PAN_nullable id)object name:(NSString *)name;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
