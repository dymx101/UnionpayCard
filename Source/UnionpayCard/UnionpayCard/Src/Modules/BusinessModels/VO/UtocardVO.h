//
//  Utocard.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtocardVO : NSObject

@property(nonatomic,strong) NSNumber * u_t_cid;
@property(nonatomic,strong) NSNumber * userinfor;
@property(nonatomic,strong) NSString * username;
@property(nonatomic,strong) NSString * uiphone;
@property(nonatomic,strong) NSString * u_card;
@property(nonatomic,strong) NSString * b_prefilx;
@property(nonatomic,strong) NSString * b_jname;
@property(nonatomic,strong) NSString * b_cordimg;
@property(nonatomic,strong) NSNumber * card_state;
@property(nonatomic,strong) NSString * card_balance;
@property(nonatomic,strong) NSString * b_c_name;

@end
