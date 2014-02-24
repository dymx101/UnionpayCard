//
//  Card.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic,strong) NSNumber *  card_id;
@property(nonatomic,strong) NSNumber *  binfor; // 商户
@property(nonatomic,strong) NSNumber *  userinfor; // 用户
@property(nonatomic,strong) NSString * username;
@property(nonatomic,strong) NSString * card;
@property(nonatomic,strong) NSNumber *  card_balance;
@property(nonatomic,strong) NSNumber *  card_v_stat;
@property(nonatomic,strong) NSNumber *  card_state;
@property(nonatomic,strong) NSString * card_log_tmd;
@property(nonatomic,strong) NSString * u_iphone;

@end
