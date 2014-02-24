//
//  Message.h
//  UnionpayCard
//
//  Created by towne on 14-2-25.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic,strong) NSNumber * m_id;
@property(nonatomic,strong) NSString * m_content;
@property(nonatomic,strong) NSNumber * m_type;
@property(nonatomic,strong) NSString * m_name;

@end
