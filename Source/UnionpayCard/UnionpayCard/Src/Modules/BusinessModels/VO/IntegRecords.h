//
//  IntegRecords.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegRecords : NSObject

@property(nonatomic,strong) NSNumber *  integ_r_id;
@property(nonatomic,strong) NSNumber *  integType;
@property(nonatomic,strong) NSString * integTypename;
@property(nonatomic,strong) NSNumber *  userinfor;
@property(nonatomic,strong) NSNumber *  usersex;
@property(nonatomic,strong) NSString * userinforname;
@property(nonatomic,strong) NSString * useriphone;
@property(nonatomic,strong) NSString * integ_r_tmd;
@property(nonatomic,strong) NSNumber *  integ_r_state;
@property(nonatomic,strong) NSNumber *  integChange; //积分兑换活动
@property(nonatomic,strong) NSString * integchangename;
@property(nonatomic,strong) NSNumber *  integ_show_state;
@property(nonatomic,strong) NSString * integ_content;

@end
