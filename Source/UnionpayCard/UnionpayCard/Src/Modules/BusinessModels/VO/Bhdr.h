//
//  Bhdr.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户活动申请
@interface Bhdr : NSObject

/** id */
@property(nonatomic,strong) NSNumber * hd_id;

/** 商户id */
@property(nonatomic,strong) NSNumber * b_id;

/** 商户联系人 */
@property(nonatomic,strong) NSString * b_contacts;

/** 审核状态*/
@property(nonatomic,strong) NSNumber * b_stat;

/** 商户电话 */
@property(nonatomic,strong) NSString * b_phone;

/** 活动标题 */
@property(nonatomic,strong) NSString * hd_tile;

/** 活动内容 */
@property(nonatomic,strong) NSString * hd_conxt;

/** 活动处理状态 */
@property(nonatomic,strong) NSNumber * hd_start;

/** 活动提交时间 */
@property(nonatomic,strong) NSString *  hd_addtime;

@end
