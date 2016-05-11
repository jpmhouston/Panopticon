//
//  PANNotificationObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANObservation.h"

PAN_ASSUME_NONNULL_BEGIN


/**
 *  A protocol for providing the data generated from a notification. `PANNotificationObservation` confirms to
 *  this protocol and so has all these properties, plus notably `object` and `timestamp` from the parent
 *  protocol.
 */
@protocol PANNotification <PANDetectedObservation>

/**
 *  A notification that triggered an observation. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly) NSNotification *notification;

/**
 *  The user info dictionary within a posted notification. Value undefined except within call to an observation
 *  block. A shortcut for `notification.userInfo`. A synonym for the `payload` property.
 */
@property (nonatomic, readonly, PAN_nullable) NSDictionary *userInfo;

@end


/**
 *  An object conforming to the PANNotification protocol. The method `createDetectedObservation` returns an
 *  instance of this.
 */
@interface PANNotification : PANDetectedObservation <PANNotification>
@end


#pragma mark -

/**
 *  A base class for NSNotification observation objects.
 *
 *  An object of this class is returned from each `PANNotification` `pan_observe...` method. This result
 *  can be saved for explcitly calling the `remove` method later (see base class `PANObservation`), but that often
 *  isn't necessary since the `pan_stopObserving...` methods can be used instead which look-up the matching observation.
 *
 *  The observation object is passed as a parameter to the observation block, and has properties defined by
 *  `PANNotification` for accessing the name, notification object, or its specific values directly, the posted object
 *  and user info dictionary.
 */
@interface PANNotificationObservation : PANObservation <PANNotification>

/**
 *  The notification name being observed.
 */
@property (nonatomic, readonly, copy) NSString *name;

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


PAN_ASSUME_NONNULL_END
