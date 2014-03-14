//
//  Parameters.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  参数控制
 */
@interface Parameters : NSObject

/** ID */
@property(nonatomic,strong) NSNumber *  per_id;

/** 参数控制名*/
@property(nonatomic,strong) NSString * per_name;

/** 参数控制值*/
@property(nonatomic,strong) NSNumber *  per_value;

/** 参数状态*/
@property(nonatomic,strong) NSNumber *  per_state;

@end
