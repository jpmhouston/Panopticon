//
//  Panopticon+PANKeyValue.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PanopticonClass.h"
#import "PANKeyValueObservation.h"
#import "NSObject+PANKeyValue.h"

PAN_ASSUME_NONNULL_BEGIN


@interface Panopticon (PANKeyValue)

#pragma mark - Anonymously observe a key path

/**
 *  Anonymously observe a KVO key path on the given object.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`, and
 *  `oldValue` properties of the observation when the block is called.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object, calling its block on the given operation queue.
 *
 *  Variation on `observeForChanges:toKeyPath:[options:][initiallyPaused:]withBlock:` that adds an operation queue
 *  parameter. See the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The operation queue on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `observeForChanges:toKeyPath:[options:][initiallyPaused:]withBlock:` that adds an GCD queue parameter.
 *  See the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue   The GCD queue. on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop anonymous observation of a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and call its `remove` method.
 *
 *  @param object  The object to stop observing.
 *  @param keyPath The key path string to stop observing on `object`.
 *
 *  @return `YES` if was previously observing this KVO key path on `object`, `NO` otherwise.
 */
+ (BOOL)stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;

/**
 *  Pause anonymous observation of a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param object  The object to pause observing.
 *  @param keyPath The key path string to pause observing on `object`.
 *
 *  @return `YES` if was previously observing this KVO key path on `object`, `NO` otherwise.
 */
+ (BOOL)pauseObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;

/**
 *  Resume anonymous observation of a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param object  The object to resume observing.
 *  @param keyPath The key path string to resume observing on `object`.
 *
 *  @return `YES` if was previously observing this KVO key path on `object`, `NO` otherwise.
 */
+ (BOOL)resumeObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;


#pragma mark - Anonymously observe multiple key paths

/**
 *  Anonymously observe multiple KVO key paths on the given object.
 *
 *  Details about the what triggered the observation can be found within the `changeDict`, `kind`, `changedValue`, and
 *  `oldValue` properties of the observation when the block is called. Also, which specific key path is triggered can be
 *  found within its `keyPath` property.
 *
 *  The observations will automatically be stopped when either the object is deallocated.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object, calling its block on the given operation queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:[options:][initiallyPaused:]withBlock:` that adds an operation queue
 *  parameter. See the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The operation queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object, calling its block on the given Grand Central Dispatch
 *  queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:[options:][initiallyPaused:]withBlock:` that adds a GCD queue parameter.
 *  See the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options. Default is `0` if parameter is omitted.
 *  @param queue    The GCD queue on which to call `block`.
 *  @param paused   Observation is created with calls to the block paused, if `YES` then `collated` flag is also initially
 *                  set to `YES`. Default is `NO` if parameter is omitted.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block;

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop anonymous observation of the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and call its `remove` method.
 *
 *  @param object   The object to stop observing.
 *  @param keyPaths The array of KVO key path strings to stop observing on `object`. Must be equal to the array passed
 *                  to the corresponding `observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
+ (BOOL)stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

/**
 *  Pause anonymous observation of the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and change its `paused` property from `NO` to `YES`.
 *
 *  If `collates` is set to `YES` on the observation, any observations that are triggered after being paused will be
 *  stored, otherwise they will be dropped.
 *
 *  @param object   The object to pause observing.
 *  @param keyPaths The array of KVO key path strings to pause observing on `object`. Must be equal to the array passed
 *                  to the corresponding `observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
+ (BOOL)pauseObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

/**
 *  Resume anonymous observation of the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the
 *  observation object returned from `observe..`, and change its `paused` property from `YES` to `NO`.
 *
 *  If `collates` is set to `YES` on the observation, and observations had been triggered during the time it was paused,
 *  then the observation's block will be invoked during this call.
 *
 *  @param object   The object to resume observing.
 *  @param keyPaths The array of KVO key path strings to resume observing on `object`. Must be equal to the array passed
 *                  to the corresponding `observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
+ (BOOL)resumeObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

@end


PAN_ASSUME_NONNULL_END
