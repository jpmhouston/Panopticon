//
//  TOObservation+Shorthand.m
//  TotalObserver
//
//  Created by Pierre Houston on 2015-11-04.
//  Copyright (c) 2015 Pierre Houston. All rights reserved.
//
//  Inspired by MagicalRecord/MagicalRecord/Core/MagicalRecord+ShorthandMethods.m
//  of which hardly anything substantial remains, however that source code
//  was Copyright (c) 2015 Magical Panda Software LLC. All rights reserved.

#import "TOObservation+Shorthand.h"
#import <objc/runtime.h>

static BOOL shorthandMethodsAreSwizzled = NO;
static NSString * const TotalObserverCategoryPrefix = @"to_";

@implementation TOObservation (Shorthand)

+ (BOOL)shorthandMethodsAreSetup
{
    return shorthandMethodsAreSwizzled;
}

+ (void)setupShorthandMethods
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *classes = [self classesToSwizzle]; // how can this be made dynamic?
        
        [classes enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            Class objectClass = (Class)object;
            
            [self addShortcutInstanceMethodForClass:objectClass];
            [self addShortcutClassMethodForClass:objectClass];
        }];
        
        shorthandMethodsAreSwizzled = YES;
    });
}

+ (NSArray *)classesToSwizzle
{
    return @[ [NSObject class],
#if TARGET_OS_PHONE
              [UIControl class]
#endif
              ];
}


#pragma mark -

+ (void)addShortcutInstanceMethodForClass:(Class)objectClass
{
    const char *prefixCString = TotalObserverCategoryPrefix.UTF8String;
    unsigned long prefixLen = strlen(prefixCString);
    NSRange prefixRange = NSMakeRange(0, prefixLen);
    NSAssert2(TotalObserverCategoryPrefix.length == prefixLen, @"NSString length doesn't match strlen %lu vs %lu", (unsigned long)TotalObserverCategoryPrefix.length, prefixLen);
    
    unsigned int count = 0;
    Method *methods = class_copyMethodList(objectClass, &count);
    
    for (unsigned int i = 0; i < count; ++i) {
        Method method = methods[i];
        SEL prefixedSelector = method_getName(method);
        const char *prefixedSelectorCString = sel_getName(prefixedSelector);
        
        if (strncmp(prefixedSelectorCString, prefixCString, prefixLen) == 0) {
            NSString *prefixedSelectorString = [NSString stringWithUTF8String:prefixedSelectorCString];
            
            NSString *shorthandSelectorString = [prefixedSelectorString stringByReplacingCharactersInRange:prefixRange withString:@""];
            const char *shorthandSelectorCString = shorthandSelectorString.UTF8String;
            SEL shorthandSelector = sel_registerName(shorthandSelectorCString);
            
            // add method with the same implementation function
            class_addMethod(objectClass, shorthandSelector, method_getImplementation(method), method_getTypeEncoding(method));
            
            NSLog(@"Added method %c[%@ %@]", class_isMetaClass(objectClass)?'+':'-', NSStringFromClass(objectClass), shorthandSelectorString);
        }
    }
}

+ (void)addShortcutClassMethodForClass:(Class)objectClass
{
    [self addShortcutInstanceMethodForClass:object_getClass(objectClass)];
}

@end
