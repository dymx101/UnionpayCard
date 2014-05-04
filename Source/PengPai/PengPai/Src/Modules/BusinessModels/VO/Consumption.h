//
//  Consumption.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消费记录
 */
@interface Consumption : NSObject

/** id */
@property(nonatomic,strong) NSNumber * con_id;

/**  消费流水号 */
@property(nonatomic,strong) NSString * con_nor;

/** 消费终端号 */
@property(nonatomic,strong) NSString * con_pos;

/** 商户编号*/
@property(nonatomic,strong) NSString * b_no;

/** 商户ID*/
@property(nonatomic,strong) NSNumber * binfor;

/** 用户ID*/
@property(nonatomic,strong) NSNumber * userinfor;

/** 用户真实姓名*/
@property(nonatomic,strong) NSString * u_realname;

/** 商户简称*/
@property(nonatomic,strong) NSString * b_jname;

/** 虚拟卡号*/
@property(nonatomic,strong) NSString * card;

/** 消费金额*/
@property(nonatomic,strong) NSNumber * con_amount;

/** 消费时间*/
@property(nonatomic,strong) NSString * con_tmd;

/** 用户手机号码*/
@property(nonatomic,strong) NSString * u_iphone;

/** 消费状态*/
@property(nonatomic,strong) NSNumber * con_state;

@end
