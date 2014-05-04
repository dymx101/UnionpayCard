//
//  TDJsonParser.h
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDJsonParser : NSObject
/**
 *  功能:对json数据进行解析
 */
+ (NSObject *)parseData:(id)aJsonData;

@end
