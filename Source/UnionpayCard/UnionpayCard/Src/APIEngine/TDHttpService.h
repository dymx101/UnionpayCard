//
//  TDHttpService.h
//  UnionpayCard
//
//  Created by towne on 14-3-5.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDHttpService : NSObject

/**
 *  功能:用户登录
 */
+ (void)LoginUserinfor:(NSString * ) loginame loginPass:(NSString *) logpassword
       completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:根据tOken 查询用户
 */
+ (void)ShowUserinfor:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:商户一级类别
 */
+ (void)showBtype:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能：展示用户卡片
 */
+ (void)ShowUtocard:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:选卡后更新用户信息
 */
+ (void)updateUserinfor:(NSString *) u_pre_num uPrefix:(NSString *) u_prefix userToken:(NSString *)userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:消费记录
 */
+ (void)ShowConsumption:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能：充值记录
 */
+ (void)ShowPreRecords:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;
@end
