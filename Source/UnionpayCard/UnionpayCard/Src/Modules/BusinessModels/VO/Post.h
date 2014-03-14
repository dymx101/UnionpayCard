//
//  Post.h
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 *  终端
 */
@interface Post : NSObject

/** 终端号*/
@property(nonatomic,strong) NSString * p_num;

/** 商户ID*/
@property(nonatomic,strong) NSNumber * binfor;

/** 商户名称*/
@property(nonatomic,strong) NSString * b_name;

/** 充值密码*/
@property(nonatomic,strong) NSString * p_pwd;

/** 商户编号*/
@property(nonatomic,strong) NSString * b_no;

/** 受理预付卡卡柄*/
@property(nonatomic,strong) NSString * b_prefix;

/** 终端号说明*/
@property(nonatomic,strong) NSString * p_explain;

/** 终端号状态*/
@property(nonatomic,strong) NSNumber * p_state;

/** 终端号加入时间*/
@property(nonatomic,strong) NSDate * p_regdate;

/** 添加此信息的管理员号*/
@property(nonatomic,strong) NSNumber * adminManager;

@end
