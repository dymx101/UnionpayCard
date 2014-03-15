//
//  Uvip.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *   VIP用户级别
 */
@interface Uvip : NSObject

/** id */
@property(nonatomic,strong) NSNumber *  u_v_id;

/** 用户级别名 */
@property(nonatomic,strong) NSString * u_v_nume;

/** 用户级别logo 图片 */
@property(nonatomic,strong) NSString * u_v_logo;

/** 用户级别匹配值 */
@property(nonatomic,strong) NSNumber *  u_v_value;

/** 优惠百分比 */
@property(nonatomic,strong) NSNumber *  u_v_perce;

@end
