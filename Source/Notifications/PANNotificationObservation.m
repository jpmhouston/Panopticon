//
//  PANNotificationObservation.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-01-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PANNotificationObservation.h"
#import "PANNotificationObservation+Private.h"
#import "PANObservation+Private.h"

PAN_ASSUME_NONNULL_BEGIN


@protocol PANMutableNotification <PANNotification, PANMutableDetectedObservation>
@property (nonatomic, readwrite) NSNotification *notification;
@property (nonatomic, readwrite, PAN_nullable) NSDictionary *userInfo;
@end

@interface PANNotificationObservation () <PANMutableNotification>
@property (nonatomic, readwrite, copy) NSString *name;
@end

@interface PANNotification () <PANMutableNotification>
@end



#pragma mark -

@implementation PANNotificationObservation

@synthesize notification;
@synthesize userInfo;

- (instancetype)initWithObserver:(PAN_nullable id)observer object:(PAN_nullable id)object name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANObservationBlock)block;
{
    if (!(self = [super initWithObserver:observer object:object queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _name = name;
    return self;
}

- (instancetype)initWithObject:(PAN_nullable id)object name:(NSString *)name queue:(PAN_nullable NSOperationQueue *)queue gcdQueue:(PAN_nullable dispatch_queue_t)gcdQueue block:(PANAnonymousObservationBlock)block;
{
    if (!(self = [super initWithObject:object queue:queue gcdQueue:gcdQueue block:block]))
        return nil;
    _name = name;
    return self;
}

- (void)registerInternal
{
    NSAssert1(!self.registered, @"Attempted double-register of %@", self);
    NSAssert1(self.name != nil, @"Nil 'name' property when registering observation for %@", self);
    typeof(self) __weak welf = self;
    
    if (self.queue != nil) {
        [[NSNotificationCenter defaultCenter] addObserverForName:self.name object:self.object queue:self.queue usingBlock:^(NSNotification *nsnotification) {
            [welf triggerSynchronously:YES withSetupBlock:^(id<PANDetectedObservation> obs) {
                if (![obs conformsToProtocol:@protocol(PANMutableNotification)])
                    return;
                id<PANMutableNotification> notif = (id<PANMutableNotification>)obs;
                notif.notification = nsnotification;
                notif.object = nsnotification.object;
                notif.payload = notif.userInfo = nsnotification.userInfo;
            }];
        }];
    }
    else {
        [[NSNotificationCenter defaultCenter] addObserverForName:self.name object:self.object queue:nil usingBlock:^(NSNotification *nsnotification) {
            [welf triggerSynchronously:NO withSetupBlock:^(id<PANDetectedObservation> obs) {
                if (![obs conformsToProtocol:@protocol(PANMutableNotification)])
                    return;
                id<PANMutableNotification> notif = (id<PANMutableNotification>)obs;
                notif.notification = nsnotification;
                notif.object = nsnotification.object;
                notif.payload = notif.userInfo = nsnotification.userInfo;
            }];
        }];
    }
}

- (void)duplicateFrom:(id<PANDetectedObservation>)source
{
    [super duplicateFrom:source];
    if (![source conformsToProtocol:@protocol(PANNotification)])
        return;
    id<PANNotification> notif = (id<PANNotification>)source;
    self.notification = notif.notification;
    self.userInfo = notif.userInfo;
}

- (void)deregisterInternal
{
    NSAssert1(self.registered, @"Attempted double-removal of %@", self);
    NSAssert1(self.name != nil, @"Nil 'name' property when deregistering observation for %@", self);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.name object:self.object];
}

- (PANDetectedObservation *)createDetectedObservation
{
    return [[PANNotification alloc] init];
}

+ (BOOL)removeForObserver:(PAN_nullable id)observer object:(PAN_nullable id)object name:(NSString *)name
{
    NSParameterAssert(observer != nil || object != nil);
    PANObservation *observation = [self findObservationForObserver:observer object:object matchingTest:^BOOL(PANObservation *observation) {
        return [observation isKindOfClass:[PANNotificationObservation class]] && [((PANNotificationObservation *)observation).name isEqualToString:name];
    }];
    if (observation != nil) {
        [observation remove];
        return YES;
    }
    return NO;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: obs=%p, obj=%@ %p, n=%@>", NSStringFromClass([self class]), self, self.observer, NSStringFromClass([self.object class]), self.object, self.name];
}

@end


#pragma mark -

@implementation PANNotification

@synthesize notification;
@synthesize userInfo;

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: %fs ago, obj=%@ %p, notif=%p, userInfo.keys=%@>", NSStringFromClass([self class]), self,
            -[self.timestamp timeIntervalSinceNow], NSStringFromClass([self.object class]), self.object, self.notification, [self.userInfo.allKeys componentsJoinedByString:@","]];
}

@end


PAN_ASSUME_NONNULL_END
