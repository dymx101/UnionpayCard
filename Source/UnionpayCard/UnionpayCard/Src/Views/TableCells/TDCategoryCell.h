//
//  TDCategoryCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDCateogryButton.h"

@interface TDCategoryCell : UITableViewCell
@property (nonatomic, strong)     TDCateogryButton        *btnCategory;

+(float)HEIGHT;

-(void)setItemSelected:(BOOL)aSelected;

@end
