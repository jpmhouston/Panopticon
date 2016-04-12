//
//  ViewController.m
//  Panopticon Example
//
//  Created by Pierre Houston on 10/14/2015.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//

#import "ViewController.h"
#import <Panopticon/PanopticonShorthand.h>

@interface PANObservation (PrivateObservationMethods)
+ (NSMutableDictionary *)sharedObservations;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ViewController __weak *welf = self;
    
    __unused PANObservation *o1 = [self observeForChanges:self.modelObject toKeyPath:@"name" withBlock:^(ViewController *obj, PANObservation *obs) {
        [obj addLineToTextView:@"observed model.name property"];
    }];
    
    __unused PANObservation *o2 = [self observeForChanges:self.modelObject toKeyPath:@"flag" withBlock:^(typeof(self) obj, PANObservation *obs) {
        [obj addLineToTextView:@"observed model.flag property (1)"];
    }];
    
    __unused PANObservation *o3 = [self.modelObject observeChangesToKeyPath:@"flag" withBlock:^(PANObservation *obs) {
        [welf addLineToTextView:@"observed model.flag property (2)"];
    }];
    
    __unused PANObservation *o4 = [self.modelObject observeChangesToKeyPaths:@[@"name", @"flag"] withBlock:^(PANObservation *obs) {
        [welf addLineToTextView:@"observed model.name or flag property"];
    }];
    
    __unused PANObservation *o5 = [self observeForNotifications:self.modelObject named:NameChangedNotification withBlock:^(typeof(self) obj, PANObservation *obs) {
        [obj addLineToTextView:@"observed NameChangedNotification (1)"];
    }];
    
    __unused PANObservation *o6 = [self observeNotificationsNamed:NameChangedNotification withBlock:^(PANObservation *obs) {
        [welf addLineToTextView:@"observed NameChangedNotification (2)"];
    }];
    
    __unused PANObservation *o7 = [self observeControlForPress:self.button1 withBlock:^(typeof(self) obj, PANObservation *obs) {
        [obj addLineToTextView:@"observed Button 1, setting model.name"];
        obj.modelObject.name = @"x";
    }];
    
    __unused PANObservation *o8 = [self.button2 observePressWithBlock:^(PANObservation *obs) {
        [welf addLineToTextView:@"observed Button 2, setting model.flag"];
        welf.modelObject.flag = YES;
    }];
    
//    NSLog(@"%@", [PANObservation sharedObservations]);
}

- (void)addLineToTextView:(NSString *)string
{
    NSString *lineString = [string stringByAppendingString:@"\n"];
    NSAttributedString *lineAttributedString = [[NSAttributedString alloc] initWithString:lineString];
    [self.textView.textStorage appendAttributedString:lineAttributedString];
    
    NSUInteger length = self.textView.textStorage.length;
    if (length > 1)
        [self.textView scrollRangeToVisible:NSMakeRange(length - 2, 0)];
}

@end
