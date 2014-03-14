//
//  Bcity.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 商户所在城市  */
@interface Bcity : NSObject

@property(nonatomic,strong) NSNumber * b_c_id;
@property(nonatomic,strong) NSString * b_c_name;  //城市名称
@property(nonatomic,strong) NSNumber * bprovince; //上级省ID

@end
