//
//  TDHttpService.m
//  UnionpayCard
//
//  Created by towne on 14-3-5.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDHttpService.h"

@implementation TDHttpService

/**
 *  功能:从SEL获取接口名称
 */
+ (NSString *)interfaceNameFromSelector:(SEL)aSelector
{
    if (aSelector)
    {
        NSString *selStr = NSStringFromSelector(aSelector);
        NSRange range = [NSStringFromSelector(aSelector) safeRangeOfString:@":" options:NSLiteralSearch];
        if (range.location != NSNotFound)
        {
            NSString *retStr = [selStr safeSubstringToIndex:range.location];
            return retStr;
        }
    }
    return nil;
}

/**
 *  功能:命令模式调用
 */
+ (void) postCommand :(TDHttpCommand *) command completionBlock:(TDCompletionBlock)aCompletionBlock {

    [[TDHttpClient sharedClient] processCommand:command callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
        if (anError==nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                aCompletionBlock(responseObject);
            });
        }
        else
            NSLog(@"%@",anError);
    }];
}

/**
 *  功能:用户登录
 */
+ (void)LoginUserinfor:(NSString * ) loginame loginPass:(NSString *) logpassword
       completionBlock:(TDCompletionBlock)aCompletionBlock {
    
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:loginame forKey:@"u_logname"];
    [input setValue:logpassword forKey:@"u_log_password"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:根据tOken 查询用户
 */
+ (void)ShowUserinfor:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:商户一级类别
 */
+ (void)showBtype:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：展示用户卡片
 */
+ (void)ShowUtocard:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:选卡后更新用户信息
 *  u_pre_num 当前用户使用卡号
 *  u_prefix  当前用户使用卡柄
 */
+ (void)updateUserinfor:(NSString *) u_pre_num uPrefix:(NSString *) u_prefix userToken:(NSString *)userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:u_pre_num forKey:@"u_pre_num"];
    [input setValue:u_prefix forKey:@"u_prefix"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:消费记录
 */
+ (void)ShowConsumption:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:@"0" forKey:@"frist"];
    [input setValue:@"0" forKey:@"pageNum"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：充值记录
 */
+ (void)ShowPreRecords:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:@"0" forKey:@"frist"];
    [input setValue:@"0" forKey:@"pageNum"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：查询用户注册手机是否存在
 */
+ (void)checkiphoneUserinfor: (NSString *) uPhone completionBlock:(TDCompletionBlock)aCompletionBlock {

    NSString * key = [uPhone encod];
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:uPhone forKey:@"u_iphone"];
    [input setValue:key forKey:@"key"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

@end
