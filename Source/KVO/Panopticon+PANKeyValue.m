//
//  Panopticon+PANKeyValue.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "Panopticon+PANKeyValue.h"
#import "PanopticonClass+Private.h"
#import "PANKeyValueObservation.h"

PAN_ASSUME_NONNULL_BEGIN


@implementation Panopticon (PANKeyValue)

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath
{
    return [[self sharedPanopticonObject] pan_stopObservingForChanges:object toKeyPath:keyPath];
}


+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue initiallyPaused:(BOOL)paused withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onGCDQueue:queue initiallyPaused:paused withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (PAN_nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths
{
    return [[self sharedPanopticonObject] pan_stopObservingForChanges:object toKeyPaths:keyPaths];
}

@end


PAN_ASSUME_NONNULL_END
