//
//  TDGlobalValue.h
//  UnionpayCard
//
//  Created by towne on 14-3-14.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Userinfor;
@interface TDGlobalValue : NSObject

AS_SINGLETON(TDGlobalValue);

@property(nonatomic,strong) NSString  *token;                       //token
@property(nonatomic,strong) Userinfor *currentAppUser;              //当前登录用户信息

@end
