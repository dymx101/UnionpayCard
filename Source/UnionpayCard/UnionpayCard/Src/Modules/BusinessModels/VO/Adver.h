//
//  Adver.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网站广告表
 */
@interface Adver : NSObject

/**  ID*/
@property(nonatomic,strong) NSNumber * ad_id;

/**  管理员ID*/
@property(nonatomic,strong) NSNumber * adminManager;

/**  广告图片1*/
@property(nonatomic,strong) NSString * ad_img1;

/**  广告图片2*/
@property(nonatomic,strong) NSString * ad_img2;

/**  广告图片3*/
@property(nonatomic,strong) NSString * ad_img3;

/**  广告图片4*/
@property(nonatomic,strong) NSString * ad_img4;

/**  广告图片5*/
@property(nonatomic,strong) NSString * ad_img5;

/**  广告标题1*/
@property(nonatomic,strong) NSString * ad_title1;

/**  广告标题2*/
@property(nonatomic,strong) NSString * ad_title2;

/**  广告标题3*/
@property(nonatomic,strong) NSString * ad_title3;

/**  广告标题4*/
@property(nonatomic,strong) NSString * ad_title4;

/**  广告标题5*/
@property(nonatomic,strong) NSString * ad_title5;

/**  广告链接1*/
@property(nonatomic,strong) NSString * ad_src1;

/**  广告链接2*/
@property(nonatomic,strong) NSString * ad_src2;

/**  广告链接3*/
@property(nonatomic,strong) NSString * ad_src3;

/**  广告链接4*/
@property(nonatomic,strong) NSString * ad_src4;

/**  广告链接5*/
@property(nonatomic,strong) NSString * ad_src5;

/**  发布时间*/
@property(nonatomic,strong) NSString * ad_tmd;

@end
