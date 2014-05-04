//
//  Bhtype.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户热门分类
@interface Bhtype : NSObject

@property(nonatomic,strong) NSNumber *  b_h_id;

/** 分类名称 */
@property(nonatomic,strong) NSString * b_h_name;

@end
