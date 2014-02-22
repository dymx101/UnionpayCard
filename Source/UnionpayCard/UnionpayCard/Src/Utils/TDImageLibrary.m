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
    _mineAccountBg = [UIImage imageNamed:@"bg_mine_accountView"];
    _btnBgWhite = [UIImage imageNamed:@"ump_btn_change_normal"];
    _dismiss = [UIImage imageNamed:@"btn_dismissItem"];
    _btnBgGrayRound = [[UIImage imageNamed:@"button_dealsmap_buttonBack_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    _btnBackArrow = [UIImage imageNamed:@"btn_backItem"];
    _bgLoginInput = [[UIImage imageNamed:@"bg_login_inputView"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    _btnBgGreen = [[UIImage imageNamed:@"btn_green"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];

}

@end
