//
//  PANKeyValueObservation.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

/**
 *  A base class for KVO observation objects.
 *
 *  An object of this class is returned from each `PANKeyValue` `pan_observe...` method. This result can be saved
 *  for explcitly calling the `remove` method later (see base class `PANObservation`), but that often isn't necessary
 *  since the `pan_stopObserving...` methods can be used instead which look-up the matching observation.
 *
 *  The observation object is passed as a parameter to the observation block, and defines properties for accessing
 *  the key path, change kind, the change dictionary, or its specific values directly such as old and changed values.
 */
@interface PANKeyValueObservation : PANObservation

/**
 *  An array of the key paths being observed.
 */
@property (nonatomic, readonly) NSArray *keyPaths;

/**
 *  The KVO options of an observation.
 */
@property (nonatomic, readonly) NSKeyValueObservingOptions options;


/**
 *  Key path that triggered a KVO observation. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly, copy) NSString *keyPath;

/**
 *  Change dictionary for a KVO observation. Value undefined except within call to an observation block.
 */
@property (nonatomic, readonly) NSDictionary *changeDict;

/**
 *  The kind of a KVO observation. Value undefined except within call to an observation block. A shortcut for
 *  `changeDict[NSKeyValueChangeKindKey]`.
 */
@property (nonatomic, readonly) NSUInteger kind;

/**
 *  The "prior" flag of a KVO observation. Value undefined except within call to an observation block. A shortcut
 *  for `changeDict[NSKeyValueChangeNotificationIsPriorKey]`.
 */
@property (nonatomic, readonly, getter=isPrior) BOOL prior;

/**
 *  The changed value of a KVO observation. Value undefined except within call to an observation block. A shortcut
 *  for `changeDict[NSKeyValueChangeNewKey]`.
 */
@property (nonatomic, readonly, PAN_nullable) id changedValue;

/**
 *  The old value of a KVO observation. Value undefined except within call to an observation block. A shortcut
 *  for `changeDict[NSKeyValueChangeOldKey]`.
 */
@property (nonatomic, readonly, PAN_nullable) id oldValue;

/**
 *  The indexes of a KVO observation. Value undefined except within call to an observation block. A shortcut
 *  for `changeDict[NSKeyValueChangeIndexesKey]`.
 */
@property (nonatomic, readonly, PAN_nullable) NSIndexSet *indexes;


/**
 *  Remove an observer with matching parameters. Can use this class method to look-up a previously registered
 *  observation and remove it, although usually more convenient to use the 'pan_stopObserving' methods, or save the
 *  observation object and call `remove` on it. (see base class `PANObservation`)
 *
 *  On finding the first matching observation, its `remove` method is called before returning. (see base class
 *  `PANObservation`)
 *
 *  @param observer The observer object, or `nil` if not applicable.
 *  @param object   The object being observed.
 *  @param keyPaths The key path used when creating the observation.
 *
 *  @return `YES` if matching observation was found, `NO` if it was not found.
 */
+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
