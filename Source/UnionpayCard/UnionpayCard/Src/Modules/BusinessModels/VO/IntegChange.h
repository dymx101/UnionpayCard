//
//  IntegChange.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  积分兑换活动
 */
@interface IntegChange : NSObject

/** id */
@property(nonatomic,strong) NSNumber * integ_c_id;

/**  积分活动名称 */
@property(nonatomic,strong) NSString * integ_c_name;

/** 活动内容 */
@property(nonatomic,strong) NSString * integ_c_content;

/** 活动图片 */
@property(nonatomic,strong) NSString * integ_c_img;

/** 所需积分 */
@property(nonatomic,strong) NSNumber * c_integ;

/** 兑换人数*/
@property(nonatomic,strong) NSNumber * integ_c_number;

/** 兑换截止日期*/
@property(nonatomic,strong) NSString * integ_c_tmd;

/** 兑换状态*/
@property(nonatomic,strong) NSNumber * integ_c_state;

/** 添加时间 */
@property(nonatomic,strong) NSString * integ_c_addtime;

/** 兑换数量*/
@property(nonatomic,strong) NSNumber * integ_c_num;

/** 积分消费类别*/
@property(nonatomic,strong) NSNumber * integType;

/** 积分消费类别名*/
@property(nonatomic,strong) NSString * integTypename;

@end
