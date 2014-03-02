//
//  TDFontLibrary.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDFontLibrary.h"

#define FONT_SIZE_TITLE     (15.f)

@implementation TDFontLibrary
DEF_SINGLETON(TDFontLibrary)

-(void)doInit {
    _fontTileButton = [UIFont systemFontOfSize:25.f];
    
    _fontLarge = [UIFont systemFontOfSize:17.f];
    _fontLargeBold = [UIFont boldSystemFontOfSize:17.f];
    
    _fontNormal = [UIFont systemFontOfSize:13.f];
    _fontSmall = [UIFont systemFontOfSize:11.f];
    
    _fontTitle = [UIFont systemFontOfSize:FONT_SIZE_TITLE];
    _fontTitleBold = [UIFont boldSystemFontOfSize:FONT_SIZE_TITLE];
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
