//
//  TDClassifyTableCell.m
//  UnionpayCard
//
//  Created by WHC on 14-4-3.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDClassifyTableCell.h"

@implementation TDClassifyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 20.0)];
        [self.contentView addSubview:_titleImageView];
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 0.0, 67.0, 40.0)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_titleLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
