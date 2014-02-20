//
//  TDHttpCmd.h
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDHttpCmd : NSObject

@property (nonatomic,copy) NSURLSessionDataTask *task;
@property (nonatomic,copy) id responseObject;

+(id)cmd;

-(NSString *) method; // 请求方式，"GET" or "POST"
-(NSString *) path;   // 请求对应接口的文件在服务器上的位置，如"www.baidu.com/index"中的"index"

@end
