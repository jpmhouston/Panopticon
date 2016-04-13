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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

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
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object with options.
 *
 *  Variation on `observeForChanges:toKeyPath:withBlock:` that adds a KVO options parameter. See the description for
 *  that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object, calling its block on the given operation queue.
 *
 *  Variation on `observeForChanges:toKeyPath:withBlock:` that adds an operation queue parameter. See the description
 *  for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param queue   The operation queue on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object with options, calling its block on the given operation queue.
 *
 *  Variation on `observeForChanges:toKeyPath:withBlock:` that adds operation queue and KVO options parameters. See
 *  the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options.
 *  @param queue   The operation queue on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `observeForChanges:toKeyPath:withBlock:` that adds an operation queue parameter. See the description
 *  for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param queue   The GCD dispatch queue. on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe a KVO key path on the given object with options, calling its block on the given GCD dispatch queue.
 *
 *  Variation on `observeForChanges:toKeyPath:withBlock:` that adds operation queue and KVO options parameters. See
 *  the description for that method.
 *
 *  @param object  The object to observe.
 *  @param keyPath The key path string to observe on `object`.
 *  @param options The KVO observation options.
 *  @param queue   The GCD dispatch queue on which to call `block`.
 *  @param block   The block to call when the observation is triggered, is passed the observation (same as method
 *                 result).
 *
 *  @return An observation object. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop anonymously observing a KVO key path on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the observation
 *  object returned from `observe..`, and call its `remove` method.
 *
 *  @param object  The object to stop observing.
 *  @param keyPath The key path string to stop observing on `object`.
 *
 *  @return `YES` if was previously observing this KVO key path on `object`, `NO` otherwise.
 */
+ (BOOL)stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath;


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
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object with options.
 *
 *  Variation on `observeForChanges:toKeyPaths:withBlock:` that adds a KVO options parameter. See the description for
 *  that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object, calling its block on the given operation queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:withBlock:` that adds an operation queue parameter. See the description
 *  for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param queue    The operation queue on which to call `block`.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object with options, calling its block on the given
 *  operation queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:withBlock:` that adds operation queue and KVO options parameters. See
 *  the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options.
 *  @param queue    The operation queue on which to call `block`.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object, calling its block on the given CGD dispatch queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:withBlock:` that adds a GCD dispatch queue parameter. See the description
 *  for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param queue    The CGD dispatch queue on which to call `block`.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;

/**
 *  Anonymously observe multiple KVO key paths on the given object with options, calling its block on the given CGD
 *  dispatch queue.
 *
 *  Variation on `observeForChanges:toKeyPaths:withBlock:` that adds operation queue and GCD dispatch parameters. See
 *  the description for that method.
 *
 *  @param object   The object to observe.
 *  @param keyPaths Array of key path strings to observe on `object`.
 *  @param options  The KVO observation options.
 *  @param queue    The CGD dispatch queue on which to call `block`.
 *  @param block    The block to call when any of the key path observations are triggered, is passed the observation
 *                  (same as method result).
 *
 *  @return An object representing observations of all key paths combined. You often don't need to keep this result.
 */
+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block;


/**
 *  Stop anonymously observing the KVO key paths on the given object.
 *
 *  Call on the same object on which you called one of the `observe..` methods above. Alternately, can save the observation
 *  object returned from `observe..`, and call its `remove` method.
 *
 *  @param object   The object to stop observing.
 *  @param keyPaths The array of KVO key path strings to stop observing on `object`. Must be equal to the array passed to
 *                  the corresponding `observe..` method.
 *
 *  @return `YES` if was previously observing these KVO key paths on `object`, `NO` otherwise.
 */
+ (BOOL)stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
