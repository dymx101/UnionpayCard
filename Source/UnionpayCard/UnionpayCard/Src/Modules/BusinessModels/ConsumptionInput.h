//
//  ConsumptionInput.h
//  UnionpayCard
//
//  Created by towne on 14-3-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumptionInput : NSObject

@property (nonatomic, strong) NSString * userToken;
@property (nonatomic, strong) NSString * b_jname;
@property (nonatomic, strong) NSString * card;
@property (nonatomic, strong) NSString * scon_tmd;
@property (nonatomic, strong) NSString * mcon_tmd;
@property (nonatomic, strong) NSString * con_state;
@property(nonatomic,strong) NSString * frist;
@property(nonatomic,strong) NSString * pageNum;

@end
