//
//  GNTextFieldCell.h
//  GageinNew
//
//  Created by Dong Yiming on 3/11/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNTextFieldCell : UITableViewCell
@property (nonatomic, strong) UITextField       *textField;

-(void)setStyle:(ETDCellStyle)aStyle;

@end
