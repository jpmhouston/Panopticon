//
//  PANAppGroupObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANAppGroupObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface PANAppGroupObservation (Private)

- (instancetype)initWithObserver:(PAN_nullable id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initForReliableDeliveryWithObserver:(PAN_nullable id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;

// TODO: consider making these private too
//+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name;
//+ (BOOL)removeForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name retainingState:(BOOL)retainState;

+ (PAN_nullable PANAppGroupObservation *)findObservationForObserver:(id)observer groupIdentifier:(PAN_nullable NSString *)identifier name:(NSString *)name;

@end


PAN_ASSUME_NONNULL_END
