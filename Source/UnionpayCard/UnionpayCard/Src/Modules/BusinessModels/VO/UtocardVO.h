//
//  Utocard.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户卡片对照
 */
@interface UtocardVO : NSObject

/** id */
@property(nonatomic,strong) NSNumber * u_t_cid;

/** 用户ID*/
@property(nonatomic,strong) NSNumber * userinfor;

/** 用户名称*/
@property(nonatomic,strong) NSString * username;

/** 用户电话*/
@property(nonatomic,strong) NSString * uiphone;

/** 用户虚拟卡号*/
@property(nonatomic,strong) NSString * u_card;

/** 用户卡柄*/
@property(nonatomic,strong) NSString * b_prefilx;

/** 商户简称*/
@property(nonatomic,strong) NSString * b_jname;

/** 商户卡样式:图片*/
@property(nonatomic,strong) NSString * b_cordimg;

/** 卡片状态*/
@property(nonatomic,strong) NSNumber * card_state;

/** 卡片余额*/
@property(nonatomic,strong) NSString * card_balance;

/** 商户名称*/
@property(nonatomic,strong) NSString * b_c_name;

@end
