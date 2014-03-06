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
+ (void)ShowcrrutUser:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:商户一级类别
 */
+ (void)showBtype:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能：展示用户卡片
 */
+ (void)ShowUtocard:(NSString *) userId completionBlock:(TDCompletionBlock)aCompletionBlock;
@end
