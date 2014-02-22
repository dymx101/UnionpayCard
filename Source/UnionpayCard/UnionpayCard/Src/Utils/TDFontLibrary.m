//
//  TDFontLibrary.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDFontLibrary.h"

@implementation TDFontLibrary
DEF_SINGLETON(TDFontLibrary)

-(void)doInit {
    _fontTileButton = [UIFont fontWithName:FONT_NAME_DUAN_NING_XING size:25.f];
    _fontNormal = [UIFont systemFontOfSize:13.f];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

@end
