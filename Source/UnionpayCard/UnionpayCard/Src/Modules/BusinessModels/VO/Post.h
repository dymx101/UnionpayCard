//
//  Post.h
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property(nonatomic,strong) NSString * p_num;
@property(nonatomic,strong) NSNumber * binfor;
@property(nonatomic,strong) NSString * b_name;
@property(nonatomic,strong) NSString * p_pwd;
@property(nonatomic,strong) NSString * b_no;
@property(nonatomic,strong) NSString * b_prefix;
@property(nonatomic,strong) NSString * p_explain;
@property(nonatomic,strong) NSNumber * p_state;
@property(nonatomic,strong) NSDate * p_regdate;
@property(nonatomic,strong) NSNumber * adminManager;
@end
