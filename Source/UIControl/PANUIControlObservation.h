//
//  PANUIControlObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PANObservation.h"

PAN_ASSUME_NONNULL_BEGIN


/**
 *  A protocol for providing the data generated from an app grounp notification. `PANNotificationObservation`
 *  confirms to this protocol and so has all these properties.
 */
@protocol PANUIControlEvent <PANDetectedObservation>

/**
 *  Value of sender argument passed to internal action methods when observation triggered. Value undefined except
 *  within call to an observation block.
 *
 *  Usually equal to `control`. (TBD: Perhaps always equal to `control`? If so, can probably remove this property)
 */
@property (nonatomic, readonly) id sender;

/**
 *  Value of event that triggered an observation. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly) UIEvent *event;

@end


/**
 *  An object conforming to the PANDetectedObservation protocol. `PANNotificationObservation` property `collated`
 *  is an array of these.
 */
@interface PANUIControlEvent : PANDetectedObservation <PANUIControlEvent>
@end


#pragma mark -

/**
 *  A base class for UIControlEvent observation objects.
 *
 *  An object of this class is returned from each `PANUIControl` `pan_observe...` method. This result can
 *  be saved for explcitly calling the `remove` method later (see base class `PANObservation`), but that often isn't
 *  necessary since the `pan_stopObserving...` methods can be used instead which look-up the matching observation.
 *
 *  The observation object is passed as a parameter to the observation block, and has properties defined by
 *   `PANUIControlEvent` for accessing the sender, and event object.
 */
@interface PANUIControlObservation : PANObservation <PANUIControlEvent>

/**
 *  The control being observed. A synonym for the `observee` property.
 */
@property (nonatomic, readonly) UIControl *control;

/**
 *  A bitmask of the events being observed.
 */
@property (nonatomic, readonly) UIControlEvents events;


/**
 *  Remove an observer with matching parameters. Can use this class method to look-up a previously registered
 *  observation and remove it, although usually more convenient to use the 'pan_stopObserving' methods, or save the
 *  observation object and call `remove` on it. (see base class `PANObservation`)
 *
 *  On finding the first matching observation, its `remove` method is called before returning. (see base class
 *  `PANObservation`)
 *
 *  @param observer The observer object, or `nil` if not applicable.
 *  @param control  The control being observed.
 *  @param events   The event options used when creating the observation.
 *
 *  @return `YES` if matching observation was found, `NO` if it was not found.
 */
+ (BOOL)removeForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events;

@end


PAN_ASSUME_NONNULL_END
