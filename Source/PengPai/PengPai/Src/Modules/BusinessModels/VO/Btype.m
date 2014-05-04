//
//  Btype.m
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "Btype.h"

@implementation Btype

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.b_t_id forKey:@"b_t_id"];
    [aCoder encodeObject:self.b_type_name forKey:@"b_type_name"];
    [aCoder encodeObject:self.b_cord_type forKey:@"b_cord_type"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.b_t_id = [aDecoder decodeObjectForKey:@"b_t_id"];
    self.b_type_name = [aDecoder decodeObjectForKey:@"b_type_name"];
    self.b_cord_type = [aDecoder decodeObjectForKey:@"b_cord_type"];
    return self;
}

@end
