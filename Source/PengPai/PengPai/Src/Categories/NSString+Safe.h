//
//  NSString+safe.h
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (safe)

- (NSString *)safeSubstringFromIndex:(NSUInteger)from;

- (NSString *)safeSubstringToIndex:(NSUInteger)to;

- (NSString *)safeSubstringWithRange:(NSRange)range;

- (NSRange)safeRangeOfString:(NSString *)aString;

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

- (NSString *)safeStringByAppendingString:(NSString *)aString;

- (id)safeInitWithString:(NSString *)aString;

+ (id)safeStringWithString:(NSString *)string;

/*********************************************
 *  加密主Key:1126
key 的生成规则，比如手机号码  13397186156  就是取手机的最后4位  6+1 ＝ 7 1+1 ＝ 2 5＋2 ＝ 7 6+6 ＝ 12 就是 C (10-C 11-C 12-C 类推)  所以key 就是 727C 传入参数
 */
+ (id) sumpk:(int) digital;

- (id) encod;

@end
