//
//  TDAPIEngineTest.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDAPIEngineTest.h"

@implementation TDAPIEngineTest
+(void)run {
    [self testxxx];
}


+(void)testxxx {
    
    // 入参数 封装成一个dictinary
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:@"showBtype" forKey:@"method"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    
    //命令模式调用
    [[TDHttpClient sharedClient] processCommand:command callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
        NSLog(@">>%@",responseObject);
    }];
}

@end
