//
//  Userinfor.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户基本信息表
 */
@interface Userinfor : NSObject

/** id */
@property(nonatomic,strong) NSNumber *  u_id;

/** 用户真实姓名 */
@property(nonatomic,strong) NSString * u_realname;

/** 用户性别*/
@property(nonatomic,strong) NSNumber *  u_sex;

/** 证件号码*/
@property(nonatomic,strong) NSString * u_cbcid;

/** 用户邮箱*/
@property(nonatomic,strong) NSString * u_emil;

/** 用户登录名*/
@property(nonatomic,strong) NSString * u_name;

/** 用户上次登录IP*/
@property(nonatomic,strong) NSString * u_log_ip;

/** 用户上次登录时间*/
@property(nonatomic,strong) NSString * u_log_datetime;

/** 用户手机号码*/
@property(nonatomic,strong) NSString * u_iphone;

/** 用户积分*/
@property(nonatomic,strong) NSNumber *  u_integral;

/** 用户登录码输入错误次数*/
@property(nonatomic,strong) NSNumber *  u_log_erro;

/** 用户交易密码输入错误次数*/
@property(nonatomic,strong) NSNumber *  u_tran_erro;

/** 用户输入错误时间*/
@property(nonatomic,strong) NSString * u_tranerro_datetime;

/** 用户输入错误终端*/
@property(nonatomic,strong) NSString * u_tranerro_pos;

/** 用户当前使用卡柄*/
@property(nonatomic,strong) NSString * u_prefix;

/** 用户当前使用卡号*/
@property(nonatomic,strong) NSString * u_pre_num;

/** 用户交易卡过期时间*/
@property(nonatomic,strong) NSString * u_tran_datetime;

/** 用户交易状态*/
@property(nonatomic,strong) NSNumber *  u_tran_state;

/** 用户登录状态*/
@property(nonatomic,strong) NSNumber *  u_log_state;

/** 用户挂失状态*/
@property(nonatomic,strong) NSNumber *  u_loss_state;

/** 用户挂失时间*/
@property(nonatomic,strong) NSString * u_loss_datetime;

/** 用户注册时间*/
@property(nonatomic,strong) NSString * u_login_datetime;

/** 用户上次消费时间*/
@property(nonatomic,strong) NSString * u_tran_lasttime;

/** 用户登录次数*/
@property(nonatomic,strong) NSNumber *  u_log_num;

/** 用户消费次数*/
@property(nonatomic,strong) NSNumber *  u_tran_num;

/** 用户充值次数*/
@property(nonatomic,strong) NSNumber *  u_rec_num;

/** 用户交易总额*/
@property(nonatomic,strong) NSNumber *  u_tran_money;

/** 用户充值总额*/
@property(nonatomic,strong) NSNumber *  u_rec_money;

/** 活动短信提醒状态*/
@property(nonatomic,strong) NSNumber *  u_acti_state;

/** 用户身份等级*/
@property(nonatomic,strong) NSNumber *  uvip;

/** 用户评论数*/
@property(nonatomic,strong) NSNumber *  u_review_num;

/** 介绍用户数*/
@property(nonatomic,strong) NSNumber *  u_intro_num;

/** 用户当天 发送邮件数*/
@property(nonatomic,strong) NSNumber *  today_emil_num;

/** 用户当天评论次数*/
@property(nonatomic,strong) NSNumber *  today_review_num;

/** 用户最后一次邮件发送时间*/
@property(nonatomic,strong) NSString * emil_lasttime;

/** 当天抽奖次数*/
@property(nonatomic,strong) NSNumber *  today_draw_num;

/** *用户参加活动总是数 */
@property(nonatomic,strong) NSNumber *  activities_num;

@end
