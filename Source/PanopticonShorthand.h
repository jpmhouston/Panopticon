//
//  PanopticonShorthand.h
//  Panopticon
//
//  Created by Pierre Houston on 2015-11-04.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//
//  To use shorthand method names that omit the "to_" prefix:
//  - in your podfile use: pod 'Panopticon/Shorthand' instead of just pod 'Panopticon'
//  - either: use module import directive as normal: @import Panopticon;
//    or: import <Panopticon/PanopticonShorthand.h> instead of the normal umbrealla header
//  - then call [TOObservation setupShorthandMethods] somewhere, such as your app delegate's
//    application:didFinishLaunching..
//    or: **if you can setup your project to access this pod's private headers** then in
//    at least one .m file, instead include <Panopticon/ShorthandAutosetup.h>
//

#import "TOObservation.h"
#import "PANObservation+Shorthand.h"
#import "TOKVOObservation.h"
#import "NSObject+PANKeyValue.h"
#import "NSObject+PANKeyValueShorthand.h"
#import "TONotificationObservation.h"
#import "NSObject+PANNotification.h"
#import "NSObject+PANNotificationShorthand.h"
#import "TOAppGroupObservation.h"
#import "NSObject+PANAppGroup.h"
#import "NSObject+PANAppGroupShorthand.h"
#if TARGET_OS_IPHONE
#import "TOUIControlObservation.h"
#import "NSObject+PANUIControl.h"
#import "NSObject+PANUIControlShorthand.h"
#import "UIControl+PANUIControl.h"
#import "UIControl+PANUIControlShorthand.h"
#endif

#define TO_IMPORTED_SHORTHAND_UMBRELLA_HEADER 1
