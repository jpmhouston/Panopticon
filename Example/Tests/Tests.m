//
//  Tests.m
//  Panopticon Example
//
//  Created by Pierre Houston on 10/14/2015.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//

@import XCTest;
#import <Panopticon/Panopticon.h>
#import "ModelObject.h"

@interface Tests : XCTestCase
@property (nonatomic, strong) ModelObject *modelObject;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) BOOL observed;
@property (nonatomic, assign) BOOL flag;
@end

@interface PANObservation (PrivateMethodsExposedForTesting)
+ (NSSet *)associatedObservationsForObserver:(id)observer;
+ (NSSet *)associatedObservationsForObservee:(id)object;
+ (NSSet *)associatedObservationsForObserver:(nullable id)observer observee:(nullable id)observee;
@end


@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.modelObject = [[ModelObject alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    self.observed = NO;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjectNotification
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testObjectNotificationUsingBlocksObjectParam
{
    [self pan_observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(typeof(self) obj, PANObservation *obs) {
        obj.observed = YES;
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
}

- (void)testObjectNotificationOnQueue
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    id __block samequeue = nil;
    PANObservation *observation = [self pan_observeForNotifications:self.modelObject named:NameChangedNotification onQueue:self.queue withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
        samequeue = [NSOperationQueue currentQueue];
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
    XCTAssertEqual(samequeue, self.queue);
}

- (void)testObjectNotificationWithNoObserver
{
    typeof(self) __weak welf = self;
    id __block sameobs = nil;
    PANObservation *observation = [self.modelObject pan_observeNotificationsNamed:NameChangedNotification withBlock:^(PANObservation *obs) {
        welf.observed = YES;
        sameobs = obs;
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobs, observation);
}

- (void)testObjectNotificationWithNoObserverOnQueue
{
    typeof(self) __weak welf = self;
    id __block sameobs = nil;
    id __block samequeue = nil;
    PANObservation *observation = [self.modelObject pan_observeNotificationsNamed:NameChangedNotification onQueue:self.queue withBlock:^(PANObservation *obs) {
        welf.observed = YES;
        sameobs = obs;
        samequeue = [NSOperationQueue currentQueue];
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobs, observation);
    XCTAssertEqual(samequeue, self.queue);
}

- (void)testSelfNotification
{
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeForNotifications:self named:@"blah" withBlock:^(typeof(self) obj, PANObservation *obs) {
        obj.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blah" object:self]; // should trigger notification
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testSelfNotification2
{
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeOwnNotificationsNamed:@"blah" withBlock:^(typeof(self) obj, PANObservation *obs) {
        obj.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blah" object:self]; // should trigger notification
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testAnyNotification
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeAllNotificationsNamed:NameChangedNotification withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testAnyNotificationOnQueue
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    id __block samequeue = nil;
    PANObservation *observation = [self pan_observeAllNotificationsNamed:NameChangedNotification onQueue:self.queue withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
        samequeue = [NSOperationQueue currentQueue];
    }];
    self.modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
    XCTAssertEqual(samequeue, self.queue);
}


#if 0 // these tests are disabled because addObserver:forKeyPath:.. seems to crash when run in a text case, no workaround found yet
- (void)testKVO
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeForChanges:self.modelObject toKeyPath:@"flag" withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    self.modelObject.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testKVOOnQueue
{
    typeof(self) __weak welf = self;
    id __block sameobj = nil;
    id __block sameobs = nil;
    id __block samequeue = nil;
    PANObservation *observation = [self pan_observeForChanges:self.modelObject toKeyPath:@"flag" onQueue:self.queue withBlock:^(id obj, PANObservation *obs) {
        welf.observed = YES;
        sameobj = obj;
        sameobs = obs;
        samequeue = [NSOperationQueue currentQueue];
    }];
    self.modelObject.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
    XCTAssertEqual(samequeue, self.queue);
}

- (void)testKVOSelf
{
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeForChanges:self toKeyPath:@"flag" withBlock:^(typeof(self) obj, PANObservation *obs) {
        obj.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    self.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testKVOSelf2
{
    id __block sameobj = nil;
    id __block sameobs = nil;
    PANObservation *observation = [self pan_observeForOwnChangesToKeyPath:@"flag" withBlock:^(typeof(self) obj, PANObservation *obs) {
        obj.observed = YES;
        sameobj = obj;
        sameobs = obs;
    }];
    self.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobj, self);
    XCTAssertEqual(sameobs, observation);
}

- (void)testKVOWithNoObserver
{
    typeof(self) __weak welf = self;
    id __block sameobs = nil;
    PANObservation *observation = [self.modelObject pan_observeChangesToKeyPath:@"flag" withBlock:^(PANObservation *obs) {
        welf.observed = YES;
        sameobs = obs;
    }];
    self.modelObject.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobs, observation);
}

- (void)testKVOWithNoObserverOnQueue
{
    typeof(self) __weak welf = self;
    id __block sameobs = nil;
    id __block samequeue = nil;
    PANObservation *observation = [self.modelObject pan_observeChangesToKeyPath:@"flag" onQueue:self.queue withBlock:^(PANObservation *obs) {
        welf.observed = YES;
        sameobs = obs;
        samequeue = [NSOperationQueue currentQueue];
    }];
    self.modelObject.flag = YES;
    XCTAssertTrue(self.observed);
    XCTAssertEqual(sameobs, observation);
    XCTAssertEqual(samequeue, self.queue);
}
#endif // disabled because addObserver:forKeyPath:.. seems to crash when run in a text case

- (void)testExplicitRemoval
{
    PANObservation *observation1 = [self pan_observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
    PANObservation *observation2 = [self pan_observeAllNotificationsNamed:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
    
    NSSet *observationsBeforeRemoval = [PANObservation associatedObservationsForObserver:self];
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation1]);
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation2]);
    
    [observation1 remove];
    
    NSSet *observationsAfterRemoval = [PANObservation associatedObservationsForObserver:self];
    XCTAssertFalse([observationsAfterRemoval containsObject:observation1]);
    XCTAssertTrue([observationsAfterRemoval containsObject:observation2]);
}

- (void)testIndirectRemoval
{
    PANObservation *observation1 = [self pan_observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
    PANObservation *observation2 = [self pan_observeAllNotificationsNamed:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
    
    NSSet *observationsBeforeRemoval = [PANObservation associatedObservationsForObserver:self];
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation1]);
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation2]);
    
    BOOL found = [self pan_stopObservingForNotifications:self.modelObject named:NameChangedNotification];
    XCTAssertTrue(found);
    
    NSSet *observationsAfterRemoval = [PANObservation associatedObservationsForObserver:self];
    XCTAssertFalse([observationsAfterRemoval containsObject:observation1]);
    XCTAssertTrue([observationsAfterRemoval containsObject:observation2]);
}

- (void)testImplicitRemoval
{
    PANObservation *observation1, *observation2;
    @autoreleasepool {
        observation1 = [self pan_observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
        observation2 = [self pan_observeAllNotificationsNamed:NameChangedNotification withBlock:^(id obj, PANObservation *obs) { }];
    }
    
    NSSet *observationsBeforeRemoval = [PANObservation associatedObservationsForObserver:self observee:nil];
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation1]);
    XCTAssertTrue([observationsBeforeRemoval containsObject:observation2]);
    
    self.modelObject = nil;
    // something in 'pan_observeForNotifications' is doing a retain+autorelease that ARC isn't optimizing away
    // without use of @autoreleasepool above, the property would have a strong retain by the main autorelease pool until after this method exited
    // so modelObject's dealloc wouldn't run until then, which would mean observation1 would not be removed here and the first assertion below would fail
    
    NSSet *observationsAfterRemoval = [PANObservation associatedObservationsForObserver:self observee:nil];
    XCTAssertFalse([observationsAfterRemoval containsObject:observation1]);
    XCTAssertTrue([observationsAfterRemoval containsObject:observation2]);
}

@end
