//
//  TDCateogryButton.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDCategoryResource.h"

@interface TDCateogryButton : UIView
@property (nonatomic, strong) UIImageView   *ivIcon;
@property (nonatomic, strong) UILabel       *lblTitle;

-(void)setCateType:(ETDCateType)aCateType;

-(void)setSelected:(BOOL)aSelected;
-(BOOL)selected;
@end
