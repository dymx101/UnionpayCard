//
//  UIView+Effect.m
//  MucixDown
//
//  Created by Dong Yiming on 2/24/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import "UIView+Effect.h"
#import "FDColor.h"

@implementation UIView (Effect)

-(void)applyEffectCircleSilverBorder
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.masksToBounds = YES;
}

-(void)applyEffectDarkGrayBorder
{
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [FDColor sharedInstance].silverDark.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
}

-(void)applyEffectRoundRectSilverBorder
{
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
}

-(void)applyEffectRoundRectShadow
{
    self.layer.cornerRadius = 8;
    self.layer.shadowColor = [FDColor sharedInstance].darkGray.CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = .1f;
    self.layer.masksToBounds = YES;
}

-(void)applyEffectShadowAndBorder
{
    self.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
    self.layer.borderWidth = 1;
    
    [self applyEffectShadow];
}

-(void)applyEffectShadow
{
    self.layer.shadowColor = [FDColor sharedInstance].darkGray.CGColor;
    self.layer.shadowOpacity = .3f;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 2;
    self.layer.cornerRadius = 0.f;
}

@end
