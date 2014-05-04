//
//  IntegRecords.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  积分消费记录
 */
@interface IntegRecords : NSObject

/** id */
@property(nonatomic,strong) NSNumber *  integ_r_id;

/** 兑换类型*/
@property(nonatomic,strong) NSNumber *  integType;

/** 类型名称*/
@property(nonatomic,strong) NSString * integTypename;

/** 用户id*/
@property(nonatomic,strong) NSNumber *  userinfor;

/** 用户性别*/
@property(nonatomic,strong) NSNumber *  usersex;

/** 用户名称*/
@property(nonatomic,strong) NSString * userinforname;

/** 用户电话*/
@property(nonatomic,strong) NSString * useriphone;

/** 兑换时间*/
@property(nonatomic,strong) NSString * integ_r_tmd;

/** 兑换状态 */
@property(nonatomic,strong) NSNumber *  integ_r_state;

/** 消费的积分*/
@property(nonatomic,strong) NSNumber *  integChange;

/** 消费积分名称*/
@property(nonatomic,strong) NSString * integchangename;

/** 积分显示状态*/
@property(nonatomic,strong) NSNumber *  integ_show_state;

/** 说明类容*/
@property(nonatomic,strong) NSString * integ_content;

@end
