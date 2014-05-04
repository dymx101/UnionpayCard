//
//  Uemil.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户邮件通知
 */
@interface Uemil : NSObject

/** id */
@property(nonatomic,strong) NSNumber * u_e_id;

/** 标题*/
@property(nonatomic,strong) NSString * u_e_title;

/** 内容*/
@property(nonatomic,strong) NSString * u_e_conut;

/** 用户ID*/
@property(nonatomic,strong) NSNumber * userinfor;

/** 邮件阅读状态*/
@property(nonatomic,strong) NSNumber * u_e_start;

/** 邮件删除状态*/
@property(nonatomic,strong) NSNumber * u_e_orstart;

/** 邮件发送时间*/
@property(nonatomic,strong) NSString * u_e_tmd;

/** 邮件阅读时间*/
@property(nonatomic,strong) NSString * u_e_rdtmd;

/** 管理员ID */
@property(nonatomic,strong) NSNumber * adminManager;

/** 管理员真实姓名*/
@property(nonatomic,strong) NSString * amdin_rename;

/** 用户真实姓名*/
@property(nonatomic,strong) NSString * u_realname;

/** 用户电话*/
@property(nonatomic,strong) NSString * u_iphone;

@end
