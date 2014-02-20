//
//  TDImageLibrary.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDImageLibrary.h"

@implementation TDImageLibrary
DEF_SINGLETON(TDImageLibrary)

- (id)init
{
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void)doInit {
    _logoName = [UIImage imageNamed:@"icon_homepage_MTLogo.png"];
    _btnBgOrange = [[UIImage imageNamed:@"bg_roominfo_showtime.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}
@end
