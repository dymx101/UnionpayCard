//
//  B2type.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  商户2级分类
 */
@interface B2type : NSObject

/** id */
@property(nonatomic,strong) NSNumber * b_t2_id;

/** 商户2级分类名称*/
@property(nonatomic,strong) NSString * b_t2_name;

@property(nonatomic,strong) NSNumber * btype; //商户一级分类

/** 一级分类名*/
@property(nonatomic,strong) NSString * btypename;

@end
