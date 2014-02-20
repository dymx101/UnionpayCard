//
//  FDColor.m
//  iBolter
//
//  Created by Dong Yiming on 1/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
// Because crayons are fun! Full list of colors:
// http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors
//

#import "FDColor.h"

@implementation FDColor
DEF_SINGLETON(FDColor)

- (id)init
{
    self = [super init];
    if (self) {
        _magicMint = [UIColor colorWithCrayola:@"Magic Mint"];
        _midnightBlue = [UIColor colorWithCrayola:@"Midnight Blue"];
        _orangeRed = [UIColor colorWithCrayola:@"Orange Red"];
        _caribbeanGreen = [UIColor colorWithCrayola:@"Caribbean Green"];
        _desertSand = [UIColor colorWithCrayola:@"Desert Sand"];
        _purpleHeart = [UIColor colorWithCrayola:@"Purple Heart"];
        
        _black = [UIColor blackColor];
        _white = [UIColor whiteColor];
        _gray = [UIColor grayColor];
        _blue = [UIColor blueColor];
        _green = [UIColor greenColor];
        _red = [UIColor redColor];
        _clear = [UIColor clearColor];
        
        _silver = [UIColor colorWithHexString:@"EFEFEF"];
    }
    return self;
}

@end
