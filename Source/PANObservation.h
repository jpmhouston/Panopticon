//
//  PANObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2015-10-15.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//
//  TODO:
//  - consider adding a "refcon" property to the observation, something the caller can set to anything it wants
//    and then have access to within the observation block. or perhaps that's too old-school?

#import <Foundation/Foundation.h>
#import "PANDefines.h"

PAN_ASSUME_NONNULL_BEGIN


@class PANObservation;

/**
 *  A block called when an observation is triggered, if that observation has a observing object.
 *
 *  @param obj         The observing object. Often this can be used in place of a weak `self` capture.
 *  @param observation The triggered observation object. Details about the observation that was triggered,
 *                     plus any payload or associated metadata will be properties of this object.
 */
typedef void (^PANObservationBlock)(id obj, PANObservation *observation);

/**
 *  A block called when an observation is triggered, if that observation has no observing object.
 *
 *  @param observation The triggered observation object. Details about what triggered the observation and
 *                     any payload or associated metadata will be properties of this object.
 */
typedef void (^PANAnonymousObservationBlock)(PANObservation *observation);


#pragma mark -

/**
 *  A protocol for providing the data generated from a triggered observation. `PANObservation` conforms to
 *  this protocol and so has all these properties.
 */
@protocol PANDetectedObservation <NSObject>

/**
 *  The object that triggered the observation, when appropriate.
 */
@property (nonatomic, readonly, weak, PAN_nullable) id object;

/**
 *  Separate payload of a triggered observation, if any. Often the posting object itself is the only payload
 *  in which case this will be nil.
 *
 *  If this observation has collated results then this is equal to the payload of the most recent trigger.
 */
@property (nonatomic, readonly, PAN_nullable) id payload;

/**
 *  Date when this triggered observation occurred. Usually not useful except for when `collated` not nil,
 *  in which case the block has been called after the observation has been unpaused, and this is the
 *  timestamp of the most recent trigger.
 */
@property (nonatomic, readonly) NSDate *timestamp;

@end


/**
 *  An object conforming to the PANDetectedObservation protocol. `PANObservation` property `collated` is
 *  an array of these (or a subclass).
 */
@interface PANDetectedObservation : NSObject <PANDetectedObservation>
@end


#pragma mark -

/**
 *  A base class for observation objects.
 *
 *  A subclass of this is returned from each `pan_observe...` method. This result can be saved for explcitly calling
 *  the `remove` method later, but that often isn't necessary since the `pan_stopObserving...` methods can be used
 *  instead which look-up the matching observation.
 *
 *  The observation object is more often used when it's passed as a parameter to the observation block, subclasses
 *  define properties which provide details about what observation was triggered, plus any payload or associated
 *  metadata.
 *
 *  When passed as a parameter to the observation block, values of the properties defined in the protocol
 *  `PANDetectedObservation` (and, for subclasses, its derivatives) will be have the appropriate values. If this
 *  block is being called after this observation is unpaused, `collated` may be non-nil and will contain an array
 *  of objects also conforming to `PANDetectedObservation` (or a derivative). In this case, these properties
 *  in the `PANObservation` will be those for the more recent trigger of this observation, match the last element of
 *  `collated`.
 */
@interface PANObservation : NSObject <PANDetectedObservation>

/**
 *  The object doing the observing which was provided when the observation was created, when applicable.
 *  Can be nil if observation setup with an anonymous block. (read-only)
 *
 *  If `removeAutomatically` property is not `NO` and `observer` is not `nil`, then when that object is deallocated,
 *  this observation will automatically be removed and released.
 */
@property (nonatomic, readonly, weak, PAN_nullable) id observer;

/**
 *  Object being observed which was provided when the observation was created, when applicable. Can be nil if the
 *  specific observation method lacks an observation object. (read-only)
 *
 *  If `removeAutomatically` property is not `NO` and `object` is not `nil`, then when that object is deallocated,
 *  this observation will automatically be removed and released.
 *
 *  Never is both this and `observer` allowed to be nil.
 */
@property (nonatomic, readonly, weak, PAN_nullable) id observee;

/**
 *  The `NSOperationQueue` that was provided when the observation was created, on which the block will be executed
 *  when observation is triggered. Can be `nil` if a GCD queue is to be used instead. (read-only)
 *
 *  If both this and `gcdQueue` are `nil`, then the queue and thread the block is executed on is undefined.
 */
@property (nonatomic, readonly, PAN_nullable) NSOperationQueue *queue;

/**
 *  The GCD queue that was provided when the observation was created, on which the block will be executed when the
 *  observation is triggered. Can be `nil` if an observation queue is to be used instead. (read-only)
 *
 *  If both this and `queue` are nil, then the queue and thread the block is executed on is undefined.
 */
@property (nonatomic, readonly, PAN_nullable) dispatch_queue_t gcdQueue;

/**
 *  The block provided when the observation was created, which will be executed when the observation is triggered.
 *  Can be `nil` if the observation was created with no observer, and thus uses the other block property. (read-only)
 *
 *  What events trigger an observation is left up to subclasses.
 *
 *  Between this and `block`, one will always be nil, the other not.
 */
@property (nonatomic, readonly, copy, PAN_nullable) PANObservationBlock objectBlock;

/**
 *  The anonymous block provided when the observation was created, which will be executed when the observation is
 *  triggered. Can be `nil` if an observation was created with an observer object, and thus uses the other block
 *  property. (read-only)
 *
 *  What events trigger an observation is left up to subclasses.
 *
 *  Between this and `objectBlock`, one will always be nil, the other not.
 */
@property (nonatomic, readonly, copy, PAN_nullable) PANAnonymousObservationBlock anonymousBlock;

/**
 *  Whether the observation is still active. (read-only)
 *
 *  Will be `YES` after the observation has been created and before `remove` has been called, `NO` after `remove`
 *  has been called either manually or automatically.
 */
@property (nonatomic, readonly) BOOL registered;

/**
 *  Whether the observation should be removed automatically upon either the observer or observee being deallocated.
 *  Set to `NO` to prevent automatic removal. (default is `YES`)
 *
 *  If not being removed automatically, then the caller is taking responsibility for calling the `remove` method
 *  when objects are deallocated and the observation becomes invalid. The impact of not doing so may or may not
 *  be harmful depending on the particular observation subclass, but will at least result in the observation object
 *  not being released.
 *
 *  NB: there's no opportunity for the caller to set this property before `dealloc` methods are swizzled on observer
 *  and observee objects. If hoping to set this property  to `NO` to avoid swizzling being used on your objects,
 *  there's no way at the moment.
 */
@property (nonatomic) BOOL removeAutomatically;


/**
 *  Whether this observation collates results while paused. Default is `YES`. Set to `NO` to avoid collecting
 *  any trigger instance data while the observation is paused.
 */
@property (nonatomic) BOOL collates;

/**
 *  Whether this observation is paused. On unpause, if `collates` is YES, then the block will be called with the
 *  multiple collated dates and payloads. `collated.count` will equal the number of triggered observations in that
 *  period.
 */
@property (nonatomic) BOOL paused;


/**
 *  Collected observation data from instances of the observation being triggered while it is paused and
 *  `collates` is `YES`. If this observation has been triggered and its block is being called immediately, then
 *  this will be `nil`.
 *
 *  Each element of the array is an `PANDetectedObservation`, ordered from the oldest triggered observation to
 *  the newest.
 */
@property (nonatomic, readonly, PAN_nullable) PAN_ARRAY(PANDetectedObservation) *collated;


/**
 *  Explicitly remove, or deregister, the observation.
 *
 *  After calling this method, the observation will never trigger and execute its block property. Also, the internal
 *  strong reference to the observation will be cleared and if no other strong reference to it exists, it will be
 *  deallocated.
 */
- (void)remove;

@end


PAN_ASSUME_NONNULL_END
