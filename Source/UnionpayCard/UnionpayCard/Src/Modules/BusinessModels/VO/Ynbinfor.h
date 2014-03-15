//
//  Ynbinfor.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  商户申请信息表
 */
@interface Ynbinfor : NSObject

/** 商户ID*/
@property(nonatomic,strong) NSNumber * b_id;

/** 商户登录名*/
@property(nonatomic,strong) NSString * b_username;

/** 商户登录密码*/
@property(nonatomic,strong) NSString * b_password;

/** 商户验证电话*/
@property(nonatomic,strong) NSString * b_loginphone;

/** 商户工商执照号*/
@property(nonatomic,strong) NSString * b_cordnum;

/** 商户名称*/
@property(nonatomic,strong) NSString * b_name;

/** 商户1级类别*/
@property(nonatomic,strong) NSNumber * b_type;

/** 商户2级类别*/
@property(nonatomic,strong) NSNumber * b_2_type;

/** 商户所在省份ID*/
@property(nonatomic,strong) NSNumber * b_province;

/** 商户所在市ID*/
@property(nonatomic,strong) NSNumber * b_city;

/** 商户所在区ID*/
@property(nonatomic,strong) NSNumber * b_district;

/** 商户所在区域ID*/
@property(nonatomic,strong) NSNumber * b_cbd;

/** 商户所在商圈ID*/
@property(nonatomic,strong) NSNumber * b_crcle;

/** 商户联系人*/
@property(nonatomic,strong) NSString * b_contacts;

/** 商户电话*/
@property(nonatomic,strong) NSString * b_phone;

/** 审核状态 */
@property(nonatomic,strong) NSNumber * b_stat;

/** 添加时间*/
@property(nonatomic,strong) NSString * b_addtime;

@end
