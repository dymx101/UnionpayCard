//
//  RecordInput.h
//  UnionpayCard
//
//  Created by towne on 14-3-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordInput : NSObject

@property (nonatomic, strong) NSString * userToken;
@property (nonatomic, strong) NSString * b_jname;
@property (nonatomic, strong) NSString * card;
@property (nonatomic, strong) NSString * spre_r_tmd;
@property (nonatomic, strong) NSString * mpre_r_tmd;
@property (nonatomic, strong) NSString * pre_type_id;
@property (nonatomic, strong) NSString * acc_state;
@property(nonatomic,strong) NSString * frist;
@property(nonatomic,strong) NSString * pageNum;

@end
