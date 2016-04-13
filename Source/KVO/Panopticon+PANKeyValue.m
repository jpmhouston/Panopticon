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

#if __has_feature(nullability)
NS_ASSUME_NONNULL_BEGIN
#else
#define nullable
#endif

@implementation Panopticon (PANKeyValue)

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPath:(NSString *)keyPath options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPath:keyPath options:options onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingForChanges:(id)object toKeyPath:(NSString *)keyPath
{
    return [[self sharedPanopticonObject] pan_stopObservingForChanges:object toKeyPath:keyPath];
}


+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onQueue:(NSOperationQueue *)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}

+ (nullable PANKeyValueObservation *)observeForChanges:(id)object toKeyPaths:(NSArray *)keyPaths options:(int)options onGCDQueue:(dispatch_queue_t)queue withBlock:(PANAnonymousObservationBlock)block
{
    return [[self sharedPanopticonObject] pan_observeForChanges:object toKeyPaths:keyPaths options:options onGCDQueue:queue withBlock:^(id obj, PANObservation *observation) {
        block(observation);
    }];
}


+ (BOOL)stopObservingForChanges:(id)object toKeyPaths:(NSArray *)keyPaths
{
    return [[self sharedPanopticonObject] pan_stopObservingForChanges:object toKeyPaths:keyPaths];
}

@end

#if __has_feature(nullability)
NS_ASSUME_NONNULL_END
#else
#undef nullable
#endif
