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
    [[TDHttpClient sharedClient] processCmd:[TDHttpCmd new] callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
        NSLog(@">>%@",responseObject);
    }];
}

@end
