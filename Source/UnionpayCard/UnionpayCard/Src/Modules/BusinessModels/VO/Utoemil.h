//
//  Utoemil.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utoemil : NSObject

@property(nonatomic,strong) NSNumber *  u_t_eid;
@property(nonatomic,strong) NSString * u_t_etitle;
@property(nonatomic,strong) NSString * u_t_econtent;
@property(nonatomic,strong) NSNumber *  send_uid;
@property(nonatomic,strong) NSNumber *  rec_uid;
@property(nonatomic,strong) NSNumber *  emil_lntegral;
@property(nonatomic,strong) NSString * emil_tmd;
@property(nonatomic,strong) NSString * emil_rdtmd;
@property(nonatomic,strong) NSNumber *  emil_rdstate;
@property(nonatomic,strong) NSNumber *  emil_delstate;

@end
