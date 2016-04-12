//
//  TestShorthand.m
//  Panopticon Example
//
//  Created by Pierre Houston on 2015-11-07.
//  Copyright © 2015 Pierre Houston. All rights reserved.
//

@import XCTest;
#import <Panopticon/PanopticonShorthand.h>
#import "ModelObject.h"

@interface TestShorthand : XCTestCase
@end

@implementation TestShorthand

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [PANObservation setupShorthandMethods];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShorthandMethodsWithHeaderImport {
    ModelObject *modelObject = [[ModelObject alloc] init];
    BOOL __block observed = NO;
    [self observeForNotifications:modelObject named:NameChangedNotification withBlock:^(typeof(self) obj, PANObservation *obs) {
        observed = YES;
    }];
    modelObject.name = @""; // should trigger notification, see -[ModelObject setName]
    XCTAssertTrue(observed);
}

@end
