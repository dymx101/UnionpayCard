//
//  BinforInput.h
//  UnionpayCard
//
//  Created by towne on 14-3-19.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

//查询条件：一级分类\二级分类\省\市\区\热门分类\附近（地图）\商圈\商户名称
@interface BinforInput : NSObject

@property(nonatomic,strong) NSString * b_name;
@property(nonatomic,strong) NSString * b_no;
@property(nonatomic,strong) NSString * b_jname;
@property(nonatomic,strong) NSString * b_type;
@property(nonatomic,strong) NSString * b_2type;
@property(nonatomic,strong) NSString * b_htype;
@property(nonatomic,strong) NSString * b_province;
@property(nonatomic,strong) NSString * b_city;
@property(nonatomic,strong) NSString * b_district;
@property(nonatomic,strong) NSString * b_cbd;
@property(nonatomic,strong) NSString * b_crcle;
@property(nonatomic,strong) NSString * b_sort;
@property(nonatomic,strong) NSString * b_h_state;    //热点状态
@property(nonatomic,strong) NSString * b_t_state;    //推荐状态
@property(nonatomic,strong) NSString * b_coordinate; //商户坐标
@property(nonatomic,strong) NSString * frist;
@property(nonatomic,strong) NSString * pageNum;

@end
