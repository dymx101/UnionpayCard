//
//  FDDefine.h
//  iBolter
//
//  Created by Dong Yiming on 1/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 判断是否为IPAD
#define ISIPADDEVICE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//LOG
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#ifdef DEBUG
#define DALog(fmt, ...)  { UIAlertView *alert = [[OTSAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#define DALog(...)
#endif


// ios version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//
#define LocalString(key)    NSLocalizedString(key, nil);

// NSNumber define
#undef	__INT
#define __INT( __x )			[NSNumber numberWithInt:(NSInteger)(__x)]

#undef	__UINT
#define __UINT( __x )			[NSNumber numberWithUnsignedInt:(NSUInteger)(__x)]

#undef	__LONG
#define __LONG( __x )			[NSNumber numberWithLong:(long)(__x)]

#undef	__LONGLONG
#define __LONGLONG( __x )		[NSNumber numberWithLongLong:(long long)(__x)]

#undef	__FLOAT
#define	__FLOAT( __x )			[NSNumber numberWithFloat:(float)(__x)]

#undef	__DOUBLE
#define	__DOUBLE( __x )			[NSNumber numberWithDouble:(double)(__x)]

#undef	__BOOL
#define __BOOL( __x )			[NSNumber numberWithBool:(BOOL)(__x)]



///////////////////////////////////////////////////////////////////////////////////
@interface FDDefine : NSObject @end
