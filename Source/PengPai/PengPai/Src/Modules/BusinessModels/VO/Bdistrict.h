//
//  Bdistrict.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户所在区
@interface Bdistrict : NSObject

@property(nonatomic,strong) NSNumber *  b_d_id;
@property(nonatomic,strong) NSString * b_d_name; //商户所在区名称
@property(nonatomic,strong) NSNumber *  bcity;   //所属市ID
@property(nonatomic,strong) NSNumber *  bprovince; //所属省ID

@end
