//
//  PanopticonClass.m
//  Panopticon
//
//  Created by Pierre Houston on 2016-04-12.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

#import "PanopticonClass.h"

static Panopticon *sharedInstance;

@implementation Panopticon

+ (instancetype)sharedPanopticonObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

- (instancetype)init
{
    self = [super init];
    [NSException raise:NSInternalInconsistencyException format:@"Panopticon class must not be instantiated"];
    return nil;
}

@end
