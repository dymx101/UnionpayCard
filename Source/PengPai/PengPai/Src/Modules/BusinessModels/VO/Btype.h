//
//  Btype.h
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  商户1级类别
 */
@interface Btype : NSObject

/** ID */
@property(nonatomic,strong) NSNumber * b_t_id;

/** 商户类别名*/
@property(nonatomic,strong) NSString * b_type_name;

/** 卡柄类别 如 AA,AB,AC..AJ */
@property(nonatomic,strong) NSString * b_cord_type;

@end
