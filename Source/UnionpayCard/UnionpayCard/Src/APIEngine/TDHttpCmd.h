//
//  TDHttpCmd.h
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDHttpCmd : NSObject

@property (nonatomic,strong) NSMutableDictionary * inPut;
@property (nonatomic,strong) NSString * prefix;
@property (nonatomic,strong) NSString * method;
@property (nonatomic,strong) NSString * path; // 请求对应接口的文件在服务器上的位置，如"www.baidu.com/index"中的"index"

+(id)cmd;

@end
