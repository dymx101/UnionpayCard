//
//  Announcement.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  公告
 */
@interface Announcement : NSObject

/** id */
@property(nonatomic,strong) NSNumber * a_nid;

/** 公告内容 */
@property(nonatomic,strong) NSString * a_conut;

/** 公告状态 */
@property(nonatomic,strong) NSNumber * a_start;

/** 公告发布时间 */
@property(nonatomic,strong) NSString * a_tmd;

/** 公告过期时间 */
@property(nonatomic,strong) NSString * a_gqtmd;

/** 管理员id */
@property(nonatomic,strong) NSNumber * adminManager;

/** 发布ip */
@property(nonatomic,strong) NSString * a_ip;

@end
