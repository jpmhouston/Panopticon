//
//  PANKeyValueObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANKeyValueObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface PANKeyValueObservation (Private)

- (instancetype)initWithObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initWithObject:(id)object keyPaths:(NSArray *)keyPaths options:(int)options queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;

// TODO: consider making this private too
//+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths;

+ (PAN_nullable PANKeyValueObservation *)findObservationForObserver:(PAN_nullable id)observer object:(id)object keyPaths:(NSArray *)keyPaths;

@end


PAN_ASSUME_NONNULL_END
