//
//  Message.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  短信通知
 */
@interface Message : NSObject

/** id */
@property(nonatomic,strong) NSNumber * m_id;

/** 短信内容*/
@property(nonatomic,strong) NSString * m_content;

/** 短信类型*/
@property(nonatomic,strong) NSNumber * m_type;

/** 短信类别名*/
@property(nonatomic,strong) NSString * m_name;

@end
