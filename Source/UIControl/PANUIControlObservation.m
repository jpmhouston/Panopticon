//
//  PANUIControlObservation.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANUIControlObservation.h"
#import "PANUIControlObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@protocol PANMutableUIControlEvent <PANUIControlEvent, PANMutableDetectedObservation>
@property (nonatomic, readwrite) id sender;
@property (nonatomic, readwrite) UIEvent *event;
@end

@interface PANUIControlObservation () <PANMutableUIControlEvent>
@property (nonatomic, readwrite) UIControlEvents events;
@end

@interface PANUIControlEvent () <PANMutableUIControlEvent>
@end


#pragma mark -

@implementation PANUIControlObservation

@synthesize sender;
@synthesize event;
@dynamic control;

- (instancetype)initWithObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
{
    if (!(self = [super initWithObserver:observer object:control queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _events = events;
    return self;
}

- (instancetype)initWithControl:(UIControl *)control events:(UIControlEvents)events queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block
{
    if (!(self = [super initWithObject:control queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _events = events;
    return self;
}

- (UIControl *)control
{
    return (UIControl *)self.object;
}

- (void)registerInternal
{
    NSAssert1(!self.registered, @"Attempted double-register of %@", self);
    NSAssert1(self.object != nil, @"Nil 'object' property when registering observation for %@", self);
    [(UIControl *)self.object addTarget:self action:@selector(action:forEvent:) forControlEvents:self.events];
}

- (void)action:(id)senderobj forEvent:(UIEvent *)uievent
{
    //NSAssert3(senderobj == self.object, @"Action called with sender %@ doesn't match control %@ for %@", senderobj, self.object, self); -- i think this is ok to happen. if not, probably can remove the sender property
    [self triggerWithSetupBlock:^(id<PANDetectedObservation> obs) {
        if (![obs conformsToProtocol:@protocol(PANMutableUIControlEvent)])
            return;
        id<PANMutableUIControlEvent> ev = (id<PANMutableUIControlEvent>)obs;
        ev.sender = senderobj;
        ev.event = uievent;
    }];
}

- (void)duplicateFrom:(id<PANDetectedObservation>)source
{
    [super duplicateFrom:source];
    if (![source conformsToProtocol:@protocol(PANUIControlEvent)])
        return;
    id<PANUIControlEvent> ev = (id<PANUIControlEvent>)source;
    self.sender = ev.sender;
    self.event = ev.event;
}

- (void)deregisterInternal
{
    NSAssert1(self.registered, @"Attempted double-removal of %@", self);
    NSAssert1(self.object != nil, @"Nil 'object' property when deregistering observation for %@", self);
    [(UIControl *)self.object removeTarget:self action:@selector(action:forEvent:) forControlEvents:self.events];
}

+ (BOOL)removeForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events
{
    PANUIControlObservation *observation = [self findObservationForObserver:observer control:control events:events];
    if (observation != nil) {
        [observation remove];
        return YES;
    }
    return NO;
}

+ (PAN_nullable PANUIControlObservation *)findObservationForObserver:(PAN_nullable id)observer control:(UIControl *)control events:(UIControlEvents)events
{
    return (PANUIControlObservation *)[self findObservationForObserver:observer object:control matchingTest:^BOOL(PANObservation *obs) {
        return [obs isKindOfClass:[PANUIControlObservation class]] && ((PANUIControlObservation *)obs).events == events;
    }];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: obs=%p, obj=%@ %p, e=%ud>", NSStringFromClass([self class]), self, self.observer, NSStringFromClass([self.object class]), self.object, (unsigned int)self.events];
}

@end


#pragma mark -

@implementation PANUIControlEvent

@synthesize sender;
@synthesize event;

@end


PAN_ASSUME_NONNULL_END
