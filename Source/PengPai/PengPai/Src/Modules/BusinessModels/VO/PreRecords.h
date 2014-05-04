//
//  PreRecords.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  充值记录
 */
@interface PreRecords : NSObject

/** id */
@property(nonatomic,strong) NSNumber * pre_r_id;

/** 充值流水号*/
@property(nonatomic,strong) NSString * pre_nor;

/** 商户ID*/
@property(nonatomic,strong) NSNumber * binfor;

/** 用户ID*/
@property(nonatomic,strong) NSNumber * userinfor;

/** 用户真实姓名*/
@property(nonatomic,strong) NSString * u_realname;

/** 商户简称*/
@property(nonatomic,strong) NSString * b_jname;

/** 商户编号*/
@property(nonatomic,strong) NSString * b_no;

/** 虚拟卡号*/
@property(nonatomic,strong) NSString * card;

/** 充值金额*/
@property(nonatomic,strong) NSNumber * amount;

/** 上帐金额*/
@property(nonatomic,strong) NSNumber * card_amount;

/** 充值方式 */
@property(nonatomic,strong) NSNumber * pre_type_id;

/** 充值地址*/
@property(nonatomic,strong) NSString * pre_dre;

/** 用户手机号码*/
@property(nonatomic,strong) NSString * u_iphone;

/** 充值时间*/
@property(nonatomic,strong) NSString * pre_r_tmd;

/** 结算时间*/
@property(nonatomic,strong) NSString * acc_r_tmd;

/** 结算状态*/
@property(nonatomic,strong) NSNumber * acc_stat;

/** 冻结原因*/
@property(nonatomic,strong) NSString * acc_reason;

/** 充值的IP*/
@property(nonatomic,strong) NSString * pre_ip;

@end
