//
//  IntegType.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//积分消费类别表
@interface IntegType : NSObject

@property(nonatomic,strong) NSNumber *  integ_type_id;

/** 积分消费类别名 */
@property(nonatomic,strong) NSString * integ_type_name;

@end
