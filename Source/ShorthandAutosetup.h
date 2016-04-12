//
//  ShorthandAutsetup.h
//  Panopticon
//
//  Created by Pierre Houston on 2015-11-04.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//
//  If you can setup your project to access this pod's private headers, then you can use
//  shorthand method names that omit the "pan_" prefix without adding any lines of code (other
//  than import directives):
//  - in your podfile use: pod 'Panopticon/Shorthand' instead of just pod 'Panopticon'
//  - either: use module import directive as normal: @import Panopticon;
//    or: import <Panopticon/PanopticonShorthand.h> instead of the normal umbrealla header
//  - but in at least one .m file, instead import <Panopticon/ShorthandAutsetup.h>
//
//  There won't be a conflict, and not much of an overhead if imported multiple times, but
//  don't import from a very common header, definitely not in your prefix header.
//
//  Can't think of a way to do this in a Swift-only project, you'll have to make the call to
//  setupShorthandMethods yourself.

#ifndef PANOPTICON_IMPORTED_SHORTHAND_UMBRELLA_HEADER
#import <Panopticon/PanopticonShorthand.h>
#endif

// by declaring at least one of these autosetup classes, setupShorthandMethods will get
// called during launch
// assume its safe to call multiple times otherwise we have to require that this header
// is explcitly included from exactly one .m file, which may be impractical

#define PAN_CATENATE(x, y) x ## y
#define PAN_AUTOSETUP_CLASS PAN_CATENATE(PANObservationAutosetup_, __COUNTER__)
@interface PAN_AUTOSETUP_CLASS : NSObject
@end
@implementation PAN_AUTOSETUP_CLASS
+ (void)load { [PANObservation setupShorthandMethods]; }
@end
