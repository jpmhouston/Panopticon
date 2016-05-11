//
//  PANObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2015-10-23.
//  Copyright © 2015 Pierre Houston. All rights reserved.
//

#import "PANObservation.h"

PAN_ASSUME_NONNULL_BEGIN


/**
 *  Derive a protocol from PANDetectedObservation having readwrite properties. Have the PANDetectedObservation class
 *  and the privately conform to this mutable protocol as well.
 */
@protocol PANMutableDetectedObservation <PANDetectedObservation>
@property (nonatomic, readwrite, weak, PAN_nullable) id object;
@property (nonatomic, readwrite, PAN_nullable) id payload;
@property (nonatomic, readwrite) NSDate *timestamp;
@end

@interface PANDetectedObservation (Private) <PANMutableDetectedObservation>
@end


@interface PANObservation (PrivateForSubclassesToUse) <PANMutableDetectedObservation>

/**
 *  Normally subclasses don't need set this property.
 */
@property (nonatomic, readwrite) BOOL registered;

/**
 *  Normally subclasses don't need set this property.
 */
@property (nonatomic, readwrite, PAN_nullable) PAN_ARRAY(PANDetectedObservation) *collated;

/**
 *  Don't know if we need to expose this. Should be set on all existing observations when app is made inactive.
 *  Perhaps this needs to be done another way.
 */
@property (nonatomic) BOOL inactive;

/**
 *  Initializes and returns a newly allocated observation object with an observer. A designated initializer, don't
 *  call plain `init`.
 *
 *  Only one of `queue` and `cgdQueue` should be non-`nil`, which takes precidence if both are set is undefined.
 *
 *  @param observer The observer object, this will be passed as the first parameter to `block`. By default, when
 *                  this object is deallocated, the observation to be removed automatically.
 *  @param observee The object being observed, how its used is up to subclasses. By default, when this object is
 *                  deallocated, the observation to be removed automatically.
 *  @param queue    An operation queue on which to call the observer block, or `nil` to use no specific operation queue.
 *  @param cgdQueue A GCD queue on which to call the observer block, or `nil` to use no specific operation queue.
 *  @param block    The observation block to be called when the observation is triggered. Normally `nil` not permitted
 *                  and a subclass should itself enforce this (only ok if the subclass adds another type of block
 *                  property).
 *
 *  @return An initialized PANObservation object.
 */
- (instancetype)initWithObserver:(PAN_nullable id)observer object:(PAN_nullable id)observee queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)cgdQueue block:(PAN_nullable PANObservationBlock)block;

/**
 *  Initializes and returns a newly allocated observation object with no observer. A designated initializer, don't
 *  call plain `init`.
 *
 *  Only one of `queue` and `cgdQueue` should be non-`nil`, which takes precidence if both are set is undefined.
 *
 *  @param observee The object being observed, how its used is up to subclasses. By default, calls to its `dealloc`
 *                  method will be observed and cause the observation to be removed automatically.
 *  @param queue    An operation queue on which to call the observer block, or `nil` to use no specific operation queue.
 *  @param cgdQueue A GCD queue on which to call the observer block, or `nil` to use no specific operation queue.
 *  @param block    The observation block to be called when the observation is triggered. Normally `nil` not permitted
 *                  and a subclass should itself enforce this (only ok if the subclass adds another type of block
 *                  property).
 *
 *  @return An initialized PANObservation object.
 */
- (instancetype)initWithObject:(PAN_nullable id)observee queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)cgdQueue block:(PAN_nullable PANAnonymousObservationBlock)block;


/**
 *  Method to be called when this observation has been triggered.
 *
 *  @param synchronously If observation not paused, then if this is `YES` then `queue` & `gcdQueue` are ignored and
 *                       the block will be invoked synchronously. Useful if calling when known to already be running
 *                       on the correct queue. If observation is paused, then this is ignored.
 *  @param setup         A block called to setup an object conforming to PANDetectedObservation, either self or an
 *                       object created using `createDetectedObservation`.
 */
- (void)triggerSynchronously:(BOOL)synchronously withSetupBlock:(void(^)(id<PANDetectedObservation> obs))setup;

/**
 *  Shortcut for `triggerSynchronously:setup:` with `synchronously` = `NO`.
 *
 *  @param setup See `triggerSynchronously:setup:`.
 */
- (void)triggerWithSetupBlock:(void(^)(id<PANDetectedObservation> obs))setup;


/**
 *  Look-up an observation based on the same parameters used in its creation.
 *
 *  @param observer  The observer object, or `nil` if not applicable.
 *  @param observee  The object being observed, if applicable.
 *  @param testBlock A block to be called to compare additional properties of the observation, will only be called
 *                   with observations whose observer and observee values match.
 *
 *  @return The first matching observation object.
 */
+ (PANObservation *)findObservationForObserver:(PAN_nullable id)observer object:(PAN_nullable id)observee matchingTest:(BOOL(^)(PANObservation *observation))testBlock;

@end


@interface PANObservation (PrivateForSubclassesToOverride)
/**
 *  Perform the specific mechanism to register the observation and cause `invoke` or `invokeOnQueueAfter` to be
 *  called when the specified event is triggered.
 *
 *  This method is called within the call to `register` that a subclass should itself do during initialization.
 *  It should not wait to perform the registration until this method is called and not within its own init
 *  or factory method because... reasons. (Future versions of the base class may have a mechanism whereby
 *  registration is delayed, for one)
 */
- (void)registerInternal;

/**
 *  Perform the specific mechanism to cancel the observation's registeration. This gets called
 */
- (void)deregisterInternal;

/**
 *  Create an object conforming to the protocol PANDetectedObservation for adding to `collated` array when the
 *  observation is paused.
 *
 *  @return Object conforming to protocol PANDetectedObservation.
 */
- (PANDetectedObservation *)createDetectedObservation;

/**
 *  Copy values from a `PANDetectedObservation` to the receiver. Subclass should copy only the properties it
 *  defines and then call super.
 *
 *  @param source The `PANDetectedObservation` object to copy values from.
 */
- (void)duplicateFrom:(id<PANDetectedObservation>)source;

@end


@interface PANObservation (PrivateForCallersToUse)
/**
 *  Stores the observation as assocaiate objects in the observer & observee objects, calls the `registerInternal`
 *  method, sets up automatic removal, and sets the `registered` property to `YES`.
 *
 *  This should be called during the observation object's initialization, or at least sometime soon after.
 *  In any event, it must be called automatically since, currently, there's no public interface for this that
 *  the caller call use to perform delayed registration.
 */
- (void)register;
@end


@interface PANObservation (PrivateForTesting)
+ (NSSet *)associatedObservationsForObserver:(id)observer;
+ (NSSet *)associatedObservationsForObservee:(id)observee;
+ (NSSet *)associatedObservationsForObserver:(PAN_nullable id)observer observee:(PAN_nullable id)observee;
@end


PAN_ASSUME_NONNULL_END
