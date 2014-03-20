//
//  TDHttpService.h
//  UnionpayCard
//
//  Created by towne on 14-3-5.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegistInput,BinforInput;
@interface TDHttpService : NSObject

/**
 *  功能:1.用户登录
 */
+ (void)LoginUserinfor:(NSString * ) loginame loginPass:(NSString *) logpassword
       completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:2.根据tOken 查询用户
 */
+ (void)ShowUserinfor:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:3.商户一级类别
 */
+ (void)showBtype:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:4.展示用户卡片
 */
+ (void)ShowUtocard:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:5.选卡后更新用户信息
 */
+ (void)updateUserinfor:(NSString *) u_pre_num uPrefix:(NSString *) u_prefix userToken:(NSString *)userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:6.消费记录
 */
+ (void)ShowConsumption:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:7.充值记录
 */
+ (void)ShowPreRecords:(NSString * ) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:8.查询用户注册手机是否存在
 */
+ (void)checkiphoneUserinfor: (NSString *) uPhone completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:9.校验验证码
 */
+ (void)checkphonemassage: (NSString *) uPhone Code:(NSString *) uCode completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:10.用户注册
 */
+ (void)resaveUserinfor:(RegistInput *) registinput completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:11.修改登陆和交易密码
 */
+ (void)ResetUPwd:(NSString *) userToken uTranpassword:(NSString *) utranpassword newuTranpassword:(NSString *) newutranpassword completionBlock:(TDCompletionBlock)aCompletionBlock;

//12
+ (void)ResetUPwd:(NSString *) userToken uLogpassword:(NSString *) ulogpassword newuLogpassword:(NSString *) newulogpassword completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:13.挂失
 */
+ (void)updateloss:(NSString *) userToken uRealname:(NSString *)urealname uLossstate:(NSString *) ulossstate uCbcid:(NSString *) ucbcid completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:14.统计用户是否有这商户的预付费卡
 */
+ (void)countcard:(NSString *) userToken bId:(NSString *)bid completionBlock:(TDCompletionBlock) aCompletionBlock;

/**
 *  功能:15.用户注册新卡
 */
+ (void)Regcard:(NSString *) userToken bId:(NSString *)bid completionBlock:(TDCompletionBlock) aCompletionBlock;

/**
 *  功能:16.查询商户列表
 */
+ (void)ShowBinfor:(BinforInput *)binforinput completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:17.商户总数
 */
+ (void)countbinfor:(BinforInput *)binforinput completionBlock:(TDCompletionBlock)aCompletionBlock;

/**
 *  功能:18.退出登录
 */
+ (void)exitTOKEN:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock;

@end
