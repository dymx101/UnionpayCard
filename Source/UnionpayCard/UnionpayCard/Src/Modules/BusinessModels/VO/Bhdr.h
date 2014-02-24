//
//  Bhdr.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bhdr : NSObject

@property(nonatomic,strong) NSNumber * hd_id;
@property(nonatomic,strong) NSNumber * b_id; // 商户id
@property(nonatomic,strong) NSString * b_contacts;
@property(nonatomic,strong) NSNumber * b_stat;
@property(nonatomic,strong) NSString * b_phone;
@property(nonatomic,strong) NSString * hd_tile;
@property(nonatomic,strong) NSString * hd_conxt;
@property(nonatomic,strong) NSNumber * hd_start;
@property(nonatomic,strong) NSString *  hd_addtime;

@end
