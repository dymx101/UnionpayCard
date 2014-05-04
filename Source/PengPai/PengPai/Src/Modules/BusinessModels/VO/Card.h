//
//  Card.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//虚拟卡
@interface Card : NSObject

/** 卡id*/
@property(nonatomic,strong) NSNumber *  card_id;

/** 商户*/
@property(nonatomic,strong) NSNumber *  binfor;

/** 用户*/
@property(nonatomic,strong) NSNumber *  userinfor;

/** 卡拥有者名称*/
@property(nonatomic,strong) NSString * username;

/** 虚拟卡号*/
@property(nonatomic,strong) NSString * card;

/** 虚拟卡余额*/
@property(nonatomic,strong) NSNumber *  card_balance;

/** 虚拟卡VIP状态*/
@property(nonatomic,strong) NSNumber *  card_v_stat;

/** 卡状态*/
@property(nonatomic,strong) NSNumber *  card_state;

/** 卡注册日期*/
@property(nonatomic,strong) NSString * card_log_tmd;

/** 卡对应手机号码*/
@property(nonatomic,strong) NSString * u_iphone;  

@end
