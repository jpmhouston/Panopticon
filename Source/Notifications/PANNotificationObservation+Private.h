//
//  PANNotificationObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANNotificationObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

@interface PANNotificationObservation (Private)

- (instancetype)initWithObserver:(PAN_nullable id)observer object:(PAN_nullable id)object name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initWithObject:(PAN_nullable id)object name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;

// TODO: consider making this private too
//+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(PAN_nullable id)object name:(NSString *)name;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
