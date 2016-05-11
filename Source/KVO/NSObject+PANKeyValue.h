//
//  NSObject+PANKeyValue.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PANKeyValueObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface NSObject (PANKeyValue)

#pragma mark - Observe a key path on an object

/**
 *  Receiver observes a KVO key path on the given object.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`, and
 *  `oldValue` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when either the receiver or the object is deallocated.
 *
 *  If `object` is the same as the receiver, then instead use `pan_observeOwnChangesToKeyPath:withBlock:`.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used
 *                 in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes a KVO key path on the given object, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeForChanges:toKeyPath:[options:][initiallyPaused:]withBlock:` that adds an operation
 *  queue parameter. See the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used
 *                 in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes a KVO key path on the given object, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `pan_observeForChanges:toKeyPath:[options:][initiallyPaused:]withBlock:` that adds a GCD queue
 *  parameter. See the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The GCD queue. on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used
 *                 in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the observed object is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param object  The object to stop observing.
 *  @param keyPath The key path string to stop observing on `object`.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on `object`, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;

/**
 *  Receiver pauses observing a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param object  The object to pause observing.
 *  @param keyPath The key path string to pause observing on `object`.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on `object`, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;

/**
 *  Receiver resumes observing a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param object  The object to resume observing.
 *  @param keyPath The key path string to resume observing on `object`.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on `object`, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;


#pragma mark - Observe multiple key paths on an object

/**
 *  Receiver observes multiple KVO key paths on the given object.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`,
 *  and `oldValue` properties of the observation when the block is called. Also, which specific key path is triggered
 *  can be found within its `keyPath` property.
 *
 *  The observations will automatically be stopped when either the receiver or the object is deallocated.
 *
 *  If `object` is the same as the receiver, then instead use `pan_observeOwnChangesToKeyPaths:withBlock:`.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes multiple KVO key paths on the given object, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeForChanges:toKeyPaths:[options:][initiallyPaused:]withBlock:` that adds an operation
 *  queue parameter. See the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The operation queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes multiple KVO key paths on the given object, calling its block on the given Grand Central
 *  Dispatch queue.
 *
 *  Variation on `pan_observeForChanges:toKeyPaths:[options:][initiallyPaused:]withBlock:` that adds a GCD queue
 *  parameter. See the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The GCD queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Use to stop observing sometime
 *  before the receiver or the observed object is deallocated. Alternately, can save the observation object returned from
 *  `pan_observe..`, and call its `remove` method.
 *
 *  @param object   The object to stop observing.
 *  @param keyPaths The array of KVO key path strings to stop observing on `object`. Must be equal to the array passed to
 *                  the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
- (BOOL)pan_stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

/**
 *  Receiver pauses observing the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param object   The object to pause observing.
 *  @param keyPaths The array of KVO key path strings to pause observing on `object`. Must be equal to the array passed to
 *                  the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

/**
 *  Receiver stops observing the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param object   The object to resume observing.
 *  @param keyPaths The array of KVO key path strings to resume observing on `object`. Must be equal to the array passed
 *                  to the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;


#pragma mark - Anonymously observe a key path on the receiver

/**
 *  Observe a KVO key path on the receiver.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`,
 *  and `oldValue` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when the receiver is deallocated. The observation is not tied to any
 *  "observer" object.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the key path observation is triggered, is passed the observation (same as the
 *                 method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe a KVO key path on the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeChangesToKeyPath:[options:][initiallyPaused:]withBlock:` that adds a operation queue
 *  parameter. See the description for that method.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the key path observation is triggered, is passed the observation (same as the
 *                 method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe a KVO key path on the receiver, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeChangesToKeyPath:[options:][initiallyPaused:]withBlock:` that adds a GCD queue parameter.
 *  See the description for that method.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the key path observation is triggered, is passed the observation (same as the
 *                 method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing a KVO key path on the receiver.
 *
 *  Call on the same observed object on which you called one of the `pan_observe..` methods above. Use to stop observing
 *  sometime before the object is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @param keyPath The key path string to stop observing the receiver.
 *
 *  @return `YES` if was previously observing this KVO key path on the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingChangesToKeyPath:(NSString *)keyPath;

/**
 *  Pause observing a KVO key path on the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param keyPath The key path string to pause observing the receiver.
 *
 *  @return `YES` if was previously observing this KVO key path on the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingChangesToKeyPath:(NSString *)keyPath;

/**
 *  Stop observing a KVO key path on the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param keyPath The key path string to resume observing the receiver.
 *
 *  @return `YES` if was previously observing this KVO key path on the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingChangesToKeyPath:(NSString *)keyPath;


#pragma mark - Anonymously observe multiple key paths on the receiver

/**
 *  Observe multiple KVO key paths on the receiver.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`,
 *  and `oldValue` properties of the observation when the block is called. Also, which specific key path is triggered
 *  can be found within its `keyPath` property.
 *
 *  The observation will automatically be stopped when the receiver is deallocated. The observation is not tied to any
 *  "observer" object.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as the method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe multiple KVO key paths on the receiver, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeChangesToKeyPaths:[options:][initiallyPaused:]withBlock:` that adds an operation queue
 *  parameter. See the description for that method.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The operation queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation (same
 *                  as the method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Observe multiple KVO key paths on the receiver, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeChangesToKeyPaths:[options:][initiallyPaused:]withBlock:` that adds a GCD queue parameter.
 *  See the description for that method.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The GCD queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation (same
 *                  as the method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop observing the KVO key paths on the receiver.
 *
 *  Call on the same observed object on which you called one of the `pan_observe..` methods above. Use to stop observing
 *  sometime before the object is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @param keyPaths The array of KVO key path strings to stop observing on `object`. Must be equal to the array passed to the
 *                  corresponding `pan_observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on the receiver, `NO` otherwise.
 */
- (BOOL)pan_stopObservingChangesToKeyPaths:(NSArray *)keyPaths;

/**
 *  Pause observing the KVO key paths on the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param keyPaths The array of KVO key path strings to pause observing on `object`. Must be equal to the array passed to
 *                  the corresponding `pan_observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on the receiver, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingChangesToKeyPaths:(NSArray *)keyPaths;

/**
 *  Resume observing the KVO key paths on the receiver.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param keyPaths The array of KVO key path strings to resume observing on `object`. Must be equal to the array passed to
 *                  the corresponding `pan_observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on the receiver, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingChangesToKeyPaths:(NSArray *)keyPaths;


#pragma mark - Have receiver observe a key path on itself

/**
 *  Receiver observes a KVO key path on itself.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`,
 *  and `oldValue` properties of the observation when the block is called.
 *
 *  The observation will automatically be stopped when the receiver is deallocated. The observation is not tied to any
 *  "observer" object.
 *
 *  Use instead of `-[self pan_observeChangesToKeyPath:withBlock:]` when you want the receiver passed as parameter to the
 *  block, or when you want to make extra clear that the object is intentionally observing itself.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used in place
 *                 of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes a KVO key path on itself, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeOwnChangesToKeyPath:[options:][initiallyPaused:]withBlock:` that adds an operation queue
 *  parameter. See the description for that method.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The operation queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used in place
 *                 of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes a KVO key path on itself, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeOwnChangesToKeyPath:[options:][initiallyPaused:]withBlock:` that adds a GCD queue parameter.
 *  See the description for that method.
 *
 *  @param keyPath The key path string to observe on the receiver.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The GCD queue on which to call `block`.
 *  @param paused  Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                 set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the receiver (which can be used in place
 *                 of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing a KVO key path on itself.
 *
 *  Call on the same observed object on which you called one of the `pan_observe..` methods above. Use to stop observing
 *  sometime before the object is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @param keyPath The key path string to stop observing on the receiver.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on itself, `NO` otherwise.
 */
- (BOOL)pan_stopObservingOwnChangesToKeyPath:(NSString *)keyPath;

/**
 *  Receiver pauses observing a KVO key path on itself.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param keyPath The key path string to pause observing on the receiver.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on itself, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingOwnChangesToKeyPath:(NSString *)keyPath;

/**
 *  Receiver resumes observing a KVO key path on itself.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param keyPath The key path string to resume observing on the receiver.
 *
 *  @return `YES` if the receiver was previously observing this KVO key path on itself, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingOwnChangesToKeyPath:(NSString *)keyPath;


#pragma mark - Have receiver observe multiple key paths on itself

/**
 *  Receiver observes multiple KVO key paths on itself.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`,
 *  and `oldValue` properties of the observation when the block is called. Also, which specific key path is triggered
 *  can be found within its `keyPath` property.
 *
 *  The observation will automatically be stopped when the receiver is deallocated. The observation is not tied to any
 *  "observer" object.
 *
 *  Use instead of `-[self pan_observeChangesToKeyPaths:withBlock:]` when you want the receiver passed as parameter to the
 *  block, or when you want to make extra clear that the object is intentionally observing itself.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes multiple KVO key paths on itself, calling its block on the given operation queue.
 *
 *  Variation on `pan_observeOwnChangesToKeyPaths:[options:][initiallyPaused:]withBlock:` that adds an operation queue
 *  parameter. See the description for that method.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The operation queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block;

/**
 *  Receiver observes multiple KVO key paths on itself, calling its block on the given Grand Central Dispatch queue.
 *
 *  Variation on `pan_observeOwnChangesToKeyPaths:[options:][initiallyPaused:]withBlock:` that adds a GCD queue parameter.
 *  See the description for that method.
 *
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The GCD queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the receiver
 *                  (which can be used in place of a weakly captured self), and the observation (same as method result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block;

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block;


/**
 *  Receiver stops observing multiple KVO key paths on itself.
 *
 *  Call on the same observed object on which you called one of the `pan_observe..` methods above. Use to stop observing
 *  sometime before the object is deallocated. Alternately, can save the observation object returned from `pan_observe..`,
 *  and call its `remove` method.
 *
 *  @param keyPaths The array of KVO key path strings to stop observing on the receiver. Must be equal to the array passed
 *                  to the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on itself, `NO` otherwise.
 */
- (BOOL)pan_stopObservingOwnChangesToKeyPaths:(NSArray *)keyPaths;

/**
 *  Receiver pauses observing multiple KVO key paths on itself.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param keyPaths The array of KVO key path strings to pause observing on the receiver. Must be equal to the array passed
 *                  to the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on itself, `NO` otherwise.
 */
- (BOOL)pan_pauseObservingOwnChangesToKeyPaths:(NSArray *)keyPaths;

/**
 *  Receiver resumes observing multiple KVO key paths on itself.
 *
 *  Call on the same object on which you called one of the `pan_observe..` methods above. Alternately, can save the
 *  observation object returned from `pan_observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param keyPaths The array of KVO key path strings to resume observing on the receiver. Must be equal to the array passed
 *                  to the corresponding `pan_observe..` method.
 *
 *  @return `YES` if the receiver was previously observing these KVO key paths on itself, `NO` otherwise.
 */
- (BOOL)pan_resumeObservingOwnChangesToKeyPaths:(NSArray *)keyPaths;

@end


PAN_ASSUME_NONNULL_END
