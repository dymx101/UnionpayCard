//
//  TDHttpCmd.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDHttpCmd.h"

@implementation TDHttpCmd

+ (id)cmd {
    
    return [[self alloc] init];
}

- (id)init {
    
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(NSString *)method {
    
    return @"GET";
}

-(NSString *)path {
    
    return @"Show/{\"method\":\"showBtype\"}";

}


@end
