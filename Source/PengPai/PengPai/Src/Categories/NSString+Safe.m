//
//  NSString+safe.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSString+safe.h"

@implementation NSString (safe)

- (NSString *)safeSubstringFromIndex:(NSUInteger)from
{
    if (from > self.length) {
        return nil;
    } else {
        return [self substringFromIndex:from];
    }
}

- (NSString *)safeSubstringToIndex:(NSUInteger)to
{
    if (to > self.length) {
        return nil;
    } else {
        return [self substringToIndex:to];
    }
}

- (NSString *)safeSubstringWithRange:(NSRange)range
{
    NSInteger location = range.location;
    NSInteger length = range.length;
    if (location<0 || location+length>self.length) {
        return nil;
    } else {
        return [self substringWithRange:range];
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString
{
    if (aString == nil) {
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self rangeOfString:aString];
    }
}

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask
{
    if (aString == nil) {
        return NSMakeRange(NSNotFound, 0);
    } else {
        return [self rangeOfString:aString options:mask];
    }
}

- (NSString *)safeStringByAppendingString:(NSString *)aString
{
    if (aString == nil) {
        return [self stringByAppendingString:@""];
    } else {
        return [self stringByAppendingString:aString];
    }
}

- (id)safeInitWithString:(NSString *)aString
{
    if (aString == nil) {
        return [self initWithString:@""];
    } else {
        return [self initWithString:aString];
    }
}

+ (id)safeStringWithString:(NSString *)string
{
    if (string == nil) {
        return [self stringWithString:@""];
    } else {
        return [self stringWithString:string];
    }
}

+ (id) sumpk:(int) digital {
    switch (digital) {
        case 0:
			return @"0";
        case 1:
			return @"1";
        case 2:
			return @"2";
        case 3:
			return @"3";
        case 4:
			return @"4";
        case 5:
			return @"5";
        case 6:
			return @"6";
        case 7:
			return @"7";
        case 8:
			return @"8";
        case 9:
			return @"9";
        case 10:
			return @"A";
        case 11:
			return @"B";
        case 12:
			return @"C";
        case 13:
			return @"D";
        case 14:
			return @"E";
        case 15:
			return @"F";
        case 16:
			return @"G";
        case 17:
			return @"H";
        case 18:
			return @"I";
        default:
            break;
    }
    return nil;
}

- (id) encod
{
    if (self.length <= 4) {
        return nil;
    }
    
    NSString * pk = [self substringFromIndex:(self.length - 4)];
    NSString * mkey = @"1126";
    NSMutableString * encodkey = [NSMutableString new];
    for(int i =0; i < mkey.length;i++)
    {
        int a = [[pk safeSubstringWithRange:NSMakeRange(i,1)] intValue];
        int b = [[mkey safeSubstringWithRange:NSMakeRange(i,1)] intValue];
        NSMutableString * merge =  [[self class] sumpk:(a+b)];
        [encodkey appendString:merge];
        
    }
    return encodkey;
}



@end
