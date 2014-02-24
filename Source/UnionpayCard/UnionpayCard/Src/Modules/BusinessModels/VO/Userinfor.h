//
//  Userinfor.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Userinfor : NSObject

@property(nonatomic,strong) NSNumber *  u_id;
@property(nonatomic,strong) NSString * u_realname;
@property(nonatomic,strong) NSNumber *  u_sex;
@property(nonatomic,strong) NSString * u_cbcid;
@property(nonatomic,strong) NSString * u_emil;
@property(nonatomic,strong) NSString * u_name;
@property(nonatomic,strong) NSString * u_log_ip;
@property(nonatomic,strong) NSString * u_log_datetime;
@property(nonatomic,strong) NSString * u_iphone;
@property(nonatomic,strong) NSNumber *  u_integral;
@property(nonatomic,strong) NSNumber *  u_log_erro;
@property(nonatomic,strong) NSNumber *  u_tran_erro;
@property(nonatomic,strong) NSString * u_tranerro_datetime;
@property(nonatomic,strong) NSString * u_tranerro_pos;
@property(nonatomic,strong) NSString * u_prefix;
@property(nonatomic,strong) NSString * u_pre_num;
@property(nonatomic,strong) NSString * u_tran_datetime;
@property(nonatomic,strong) NSNumber *  u_tran_state;
@property(nonatomic,strong) NSNumber *  u_log_state;
@property(nonatomic,strong) NSNumber *  u_loss_state;
@property(nonatomic,strong) NSString * u_loss_datetime;
@property(nonatomic,strong) NSString * u_login_datetime;
@property(nonatomic,strong) NSString * u_tran_lasttime;
@property(nonatomic,strong) NSNumber *  u_log_num;
@property(nonatomic,strong) NSNumber *  u_tran_num;
@property(nonatomic,strong) NSNumber *  u_rec_num;
@property(nonatomic,strong) NSNumber *  u_tran_money;
@property(nonatomic,strong) NSNumber *  u_rec_money;
@property(nonatomic,strong) NSNumber *  u_acti_state;
@property(nonatomic,strong) NSNumber *  uvip;
@property(nonatomic,strong) NSNumber *  u_review_num;
@property(nonatomic,strong) NSNumber *  u_intro_num;
@property(nonatomic,strong) NSNumber *  today_emil_num;
@property(nonatomic,strong) NSNumber *  today_review_num;
@property(nonatomic,strong) NSString * emil_lasttime;
@property(nonatomic,strong) NSNumber *  today_draw_num;
@property(nonatomic,strong) NSNumber *  activities_num;

@end
