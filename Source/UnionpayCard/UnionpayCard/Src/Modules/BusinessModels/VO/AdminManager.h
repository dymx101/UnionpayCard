//
//  AdminManager.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  管理员
 */
@interface AdminManager : NSObject

/** 管理员ID*/
@property(nonatomic,strong) NSNumber * a_id;

/** 管理员用户名*/
@property(nonatomic,strong) NSString * a_name;

/** 管理员密码*/
@property(nonatomic,strong) NSString * a_password;

/** 管理员权限*/
@property(nonatomic,strong) NSNumber * a_competence;

/** 用户手机*/
@property(nonatomic,strong) NSString * a_iphone;

/** 用户手机验证码*/
@property(nonatomic,strong) NSString * a_iphonecode;

/** 验证码过期时间*/
@property(nonatomic,strong) NSString * a_code_data;

/** 管理员上次登录IP*/
@property(nonatomic,strong) NSString * a_landedip;

/** 真实姓名*/
@property(nonatomic,strong) NSString * amdin_rename;

@end
