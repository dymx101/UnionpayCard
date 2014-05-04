//
//  Binfor.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//商户基本信息表
@interface Binfor : NSObject

/** 商户ID */
@property(nonatomic,strong) NSNumber *  b_id;

/** 商户名称 */
@property(nonatomic,strong) NSString * b_username;

/** 商户密码 */
@property(nonatomic,strong) NSString * b_password;

/** 商户验证电话*/
@property(nonatomic,strong) NSString * b_loginphone;

/** 商户动态验证码*/
@property(nonatomic,strong) NSString * b_msgyzm;

/** 验证码发送时间*/
@property(nonatomic,strong) NSString * b_msgdatetime;

/** 商户名称  */
@property(nonatomic,strong) NSString * b_name;

/** 商户简称 */
@property(nonatomic,strong) NSString * b_jname;

/**  商户卡片样式（图片）*/
@property(nonatomic,strong) NSString * b_cordimg;

/** 商户工商执照号 */
@property(nonatomic,strong) NSString * b_cordnum;

/** 商户1级类别 */
@property(nonatomic,strong) NSString * btype;

/** 商户2级类别 */
@property(nonatomic,strong) NSString * b2type;

/** 商户热门分类 */
@property(nonatomic,strong) NSString * bhtype;

/** 商户所在省份 */
@property(nonatomic,strong) NSString * bprovince;

/** 商户所在城市 */
@property(nonatomic,strong) NSString * bcity;

/** 商户所在地区 */
@property(nonatomic,strong) NSString * bdistrict;

/** 商户所在区域，如：洪山区 */
@property(nonatomic,strong) NSString * bcbd;

/** 商户所在商圈，如中南商圈 */
@property(nonatomic,strong) NSString * bcrcle;

/** 商户坐标 */
@property(nonatomic,strong) NSString * b_coordinate;

/** 商户联系人 */
@property(nonatomic,strong) NSString * b_contacts;

/** 审核状态 */
@property(nonatomic,strong) NSNumber *  b_stat;

/** 商户热点状态 */
@property(nonatomic,strong) NSNumber *  b_h_state;

/** 商户推荐状态 */
@property(nonatomic,strong) NSNumber *  b_t_state;

/** 商户排序 */
@property(nonatomic,strong) NSNumber *  b_sort;

/** 商户介绍 */
@property(nonatomic,strong) NSString * b_details;

/** 商户分数 */
@property(nonatomic,strong) NSNumber *  b_fraction;

/** 商户vip等级 */
@property(nonatomic,strong) NSNumber *  b_vip;

/** 商户好评次数 */
@property(nonatomic,strong) NSNumber *  b_z;

/** 商户中评次数 */
@property(nonatomic,strong) NSNumber *  b_in;

/** 商户差评次数  */
@property(nonatomic,strong) NSNumber *  b_c;

/** 充值详情 */
@property(nonatomic,strong) NSString * b_recharge;

/** 预付卡卡柄，如：AA，AB,...,AJ */
@property(nonatomic,strong) NSString * b_prefix;

/** 扣率 */
@property(nonatomic,strong) NSNumber *  b_rate;

/** 清算天数  */
@property(nonatomic,strong) NSNumber *  b_liq;

/** 注册日期 */
@property(nonatomic,strong) NSString * b_regdate;

/** 商户广告词 */
@property(nonatomic,strong) NSString * b_ad;

/** 商户图片  */
@property(nonatomic,strong) NSString * b_img;

/** 商户标识 */
@property(nonatomic,strong) NSString * b_logo;

/** 商户管理后台风格  */
@property(nonatomic,strong) NSNumber *  b_back;

/** 协议扫描件地址 */
@property(nonatomic,strong) NSString * b_agreement;

/** /商户编号  */
@property(nonatomic,strong) NSString * b_no;

/** 商户法人 */
@property(nonatomic,strong) NSString * b_man;

/** 开卡总数 */
@property(nonatomic,strong) NSNumber *  cord_num;

/** 商户负责人联系方式 */
@property(nonatomic,strong) NSString * b_m_phone;

/** 商户充值总金额 */
@property(nonatomic,strong) NSNumber *  b_rechargem;

/** 商户消费总金额 */
@property(nonatomic,strong) NSNumber *  b_consumption;

/** 商户充值总次数  */
@property(nonatomic,strong) NSNumber *  b_re_num;

/** 商户消费总次数 */
@property(nonatomic,strong) NSNumber *  b_con_num;


@end
