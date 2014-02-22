//
//  TDAPIEngineTest.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDAPIEngineTest.h"
#import "TDJsonParser.h"
#import "Btype.h"

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
        if (anError==nil && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray * array = responseObject;
            for (Btype * byt in array) {
                NSLog(@">1 %@",byt.b_t_id);
                NSLog(@">2 %@",byt.b_type_name);
                NSLog(@">3 %@",byt.b_cord_type);
            }
        }
    }];
}

@end
