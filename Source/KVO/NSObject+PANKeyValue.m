//
//  NSObject+PANKeyValue.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "NSObject+PANKeyValue.h"
#import "PANKeyValueObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation NSObject (PANKeyValue)


#pragma mark - observer = self, observee = object

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath
{
    return [PANKeyValueObservation removeForObserver:self object:object keyPaths:@[keyPath]];
}

- (BOOL)pan_pauseObservingForChanges:(id)object toKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:object keyPaths:@[keyPath]];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingForChanges:(id)object toKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:object keyPaths:@[keyPath]];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:object keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths
{
    return [PANKeyValueObservation removeForObserver:self object:object keyPaths:keyPaths];
}

- (BOOL)pan_pauseObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:object keyPaths:keyPaths];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:object keyPaths:keyPaths];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - observer = nil, observee = object

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingChangesToKeyPath:(NSString *)keyPath
{
    return [PANKeyValueObservation removeForObserver:nil object:self keyPaths:@[keyPath]];
}

- (BOOL)pan_pauseObservingChangesToKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:nil object:self keyPaths:@[keyPath]];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingChangesToKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:nil object:self keyPaths:@[keyPath]];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObject:self keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (BOOL)pan_stopObservingChangesToKeyPaths:(NSArray *)keyPaths
{
    return [PANKeyValueObservation removeForObserver:nil object:self keyPaths:keyPaths];
}

- (BOOL)pan_pauseObservingChangesToKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:nil object:self keyPaths:keyPaths];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingChangesToKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:nil object:self keyPaths:keyPaths];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


#pragma mark - observer = self, observee = self

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:@[keyPath] options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingOwnChangesToKeyPath:(NSString *)keyPath
{
    return [PANKeyValueObservation removeForObserver:self object:self keyPaths:@[keyPath]];
}

- (BOOL)pan_pauseObservingOwnChangesToKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:self keyPaths:@[keyPath]];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingOwnChangesToKeyPath:(NSString *)keyPath
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:self keyPaths:@[keyPath]];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}


- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:nil gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:queue gcdQueue:nil block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:options queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    if (paused)
        observation.paused = observation.collates = YES;
    [observation register];
    return observation;
}

- (PAN_nullable PANKeyValueObservation *)pan_observeOwnChangesToKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANObservationBlock)block
{
    PANKeyValueObservation *observation = [[PANKeyValueObservation alloc] initWithObserver:self object:self keyPaths:keyPaths options:0 queue:nil gcdQueue:queue block:block];
    [observation register];
    return observation;
}


- (BOOL)pan_stopObservingOwnChangesToKeyPaths:(NSArray *)keyPaths
{
    return [PANKeyValueObservation removeForObserver:self object:self keyPaths:keyPaths];
}

- (BOOL)pan_pauseObservingOwnChangesToKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:self keyPaths:keyPaths];
    if (observation != nil) {
        if (!observation.paused)
            observation.paused = YES;
        return YES;
    }
    return NO;
}

- (BOOL)pan_resumeObservingOwnChangesToKeyPaths:(NSArray *)keyPaths
{
    PANKeyValueObservation *observation = [PANKeyValueObservation findObservationForObserver:self object:self keyPaths:keyPaths];
    if (observation != nil) {
        if (observation.paused)
            observation.paused = NO;
        return YES;
    }
    return NO;
}

@end


PAN_ASSUME_NONNULL_END
