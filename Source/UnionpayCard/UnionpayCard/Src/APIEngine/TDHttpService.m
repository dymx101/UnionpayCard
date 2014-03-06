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

//命令模式调用
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

+ (void)ShowcrrutUser:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

+ (void)showBtype:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

+ (void)ShowUtocard:(NSString *) userId completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userId forKey:@"u_id"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}
@end
