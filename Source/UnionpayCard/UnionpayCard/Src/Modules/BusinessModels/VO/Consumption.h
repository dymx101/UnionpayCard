//
//  Consumption.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consumption : NSObject

@property(nonatomic,strong) NSNumber * con_id;
@property(nonatomic,strong) NSString * con_nor;
@property(nonatomic,strong) NSString * con_pos;
@property(nonatomic,strong) NSString * b_no;
@property(nonatomic,strong) NSNumber * binfor;
@property(nonatomic,strong) NSNumber * userinfor;
@property(nonatomic,strong) NSString * u_realname;
@property(nonatomic,strong) NSString * b_jname;
@property(nonatomic,strong) NSString * card;
@property(nonatomic,strong) NSNumber * con_amount;
@property(nonatomic,strong) NSString * con_tmd;
@property(nonatomic,strong) NSString * u_iphone;
@property(nonatomic,strong) NSNumber * con_state;

@end
