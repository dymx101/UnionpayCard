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
#import "Post.h"
#import "Userinfor.h"
#import "Utocard.h"

@implementation TDAPIEngineTest
+(void)run {
    [self testxxx];
}


+(void)testxxx {
    
    [TDHttpService showBtype:^(id responseObject) {
        if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray  * array = responseObject;
            for (Btype * byt in array) {
                NSLog(@">1 %@",byt);
            }
        }
    }];
    
    
    __block NSString * token = nil;
    __block Userinfor * user = nil;
    [TDHttpService LoginUserinfor:@"s@qq.com" loginPass:@"123456" completionBlock:^(id responseObject) {
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]) {
            token = [responseObject objectForKey:@"userToken"];
             [TDHttpService ShowcrrutUser:token completionBlock:^(id responseObject) {
                 if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                     user = [responseObject lastObject];
                     NSString * userId = [NSString stringWithFormat:@"%d",[user.u_id intValue]];
                     [TDHttpService ShowUtocard:userId completionBlock:^(id responseObject) {
                         if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                             NSArray * array = responseObject;
                             for (Utocard * utocard in array) {
                                 NSLog(@">2 %@",utocard);
                             }
                         }
                     }];
                 }
             }];
        }
    }];
    
}

@end
