//
//  TDHttpCmd.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDHttpCommand.h"
#import "TDJsonToDictionary.h"

@implementation TDHttpCommand

+ (id)command {
    
    return [[self alloc] init];
}

- (id)init {
    
    self = [super init];
    if(self) {
        self.prefix = @"apps_android.php?url=";
        self.method = @"GET";
    }
    return self;
}

- (NSMutableDictionary * ) inPut
{
    if (_inPut == nil) {
        self.inPut = [NSMutableDictionary new];
        return _inPut;
    }
    return _inPut;
}

- (NSString *)realPath:(NSMutableDictionary *) aDictionary withPrefix:(NSString *) prefix{
    NSString * realString = [NSString stringWithFormat:@"%@%@",prefix,[TDJsonToDictionary jsonStringFromDictionary:aDictionary]];
    return [realString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *) path {
    return [self realPath:self.inPut withPrefix:_prefix];
}


@end
