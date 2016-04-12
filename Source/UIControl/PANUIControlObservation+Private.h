//
//  PANUIControlObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANUIControlObservation.h"

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#define PAN_nullable nullable
#else
#define PAN_nullable
#endif

@interface PANUIControlObservation (Private)

- (instancetype)initWithObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initWithControl:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;

// TODO: consider making this private too
//+ (BOOL)removeForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events;

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#endif
#undef PAN_nullable
