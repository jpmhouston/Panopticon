//
//  PANUIControlObservation+Private.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-03-16.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANUIControlObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@interface PANUIControlObservation (Private)

- (instancetype)initWithObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
- (instancetype)initWithControl:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;

// TODO: consider making this private too
//+ (BOOL)removeForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events;

+ (PAN_nullable PANUIControlObservation *)findObservationForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events;

@end


PAN_ASSUME_NONNULL_END
