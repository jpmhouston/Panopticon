//
//  PANKeyValueObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANKeyValueObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

@interface PANKeyValueObservation (Private)

- (instancetype)initWithObserver:(nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(nullable NSOperationQueue *)queue gcdQueue:(nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initWithObject:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(nullable NSOperationQueue *)queue gcdQueue:(nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;

// TODO: consider making this private too
//+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
