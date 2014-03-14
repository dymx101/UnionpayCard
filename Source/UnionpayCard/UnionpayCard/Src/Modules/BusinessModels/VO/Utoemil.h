//
//  Utoemil.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户邮件
 */
@interface Utoemil : NSObject

/** id */
@property(nonatomic,strong) NSNumber *  u_t_eid;

/** 邮件标题 */
@property(nonatomic,strong) NSString * u_t_etitle;

/** 邮件内容 */
@property(nonatomic,strong) NSString * u_t_econtent;

/** 发送邮件人 */
@property(nonatomic,strong) NSNumber *  send_uid;

/** 接收人*/
@property(nonatomic,strong) NSNumber *  rec_uid;

/** 赠送积分数*/
@property(nonatomic,strong) NSNumber *  emil_lntegral;

/** 邮件发送时间*/
@property(nonatomic,strong) NSString * emil_tmd;

/** 邮件阅读时间*/
@property(nonatomic,strong) NSString * emil_rdtmd;

/** 邮件阅读状态*/
@property(nonatomic,strong) NSNumber *  emil_rdstate;

/** 邮件删除状态*/
@property(nonatomic,strong) NSNumber *  emil_delstate;

@end
