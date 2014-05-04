//
//  Bcrcle.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户所在商圈
@interface Bcrcle : NSObject

@property(nonatomic,strong) NSNumber * b_cr_id;

/** 商圈名称 */
@property(nonatomic,strong) NSString * b_cr_name;

@end
