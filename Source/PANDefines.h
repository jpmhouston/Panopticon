//
//  PANDefines.h
//  Panopticon
//
//  Created by Pierre Houston on 2016-05-07.
//  Copyright © 2016 Pierre Houston. All rights reserved.
//

// compatibility defines for nullable & NS_ASSUME_NONNULL_BEGIN/END
#if __has_feature(nullability)

#ifndef PAN_nullable
#define PAN_nullable nullable
#endif
#ifndef PAN_ASSUME_NONNULL_BEGIN
#define PAN_ASSUME_NONNULL_BEGIN NS_ASSUME_NONNULL_BEGIN
#endif
#ifndef PAN_ASSUME_NONNULL_END
#define PAN_ASSUME_NONNULL_END NS_ASSUME_NONNULL_END
#endif

#else

#ifndef PAN_nullable
#define PAN_nullable
#endif
#ifndef PAN_ASSUME_NONNULL_BEGIN
#define PAN_ASSUME_NONNULL_BEGIN
#endif
#ifndef PAN_ASSUME_NONNULL_END
#define PAN_ASSUME_NONNULL_END
#endif

#endif

// wrapper macros for objective-c generics
#if __has_feature(objc_generics)

#define PAN_GENERICS(CT,ET) CT
#define PAN_ARRAY(ET) NSArray
#define PAN_SET(ET) NSSet
#define PAN_DICTIONARY(KT,VT) NSDictionary
#define PAN_MUTABLEARRAY(ET) NSMutableArray
#define PAN_MUTABLESET(ET) NSMutableSet
#define PAN_MUTABLEDICTIONARY(KT,VT) NSMutableDictionary

#else

#define PAN_GENERICS(CT,ET) CT<ET*>
#define PAN_ARRAY(ET) NSArray<ET*>
#define PAN_SET(ET) NSSet<ET*>
#define PAN_DICTIONARY(KT,VT) NSDictionary<KT*,VT*>
#define PAN_MUTABLEARRAY(ET) NSMutableArray<ET*>
#define PAN_MUTABLESET(ET) NSMutableSet<ET*>
#define PAN_MUTABLEDICTIONARY(KT,VT) NSMutableDictionary<KT*,VT*>

#endif
