//
//  TDCategoryCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCategoryCell.h"
#import "TDCateogryButton.h"

#define MY_HEIGHT   (35)

@interface TDCategoryCell () {
    UIView                  *_highlightCoverView;
    TDCateogryButton        *_btnCategory;
}

@end

@implementation TDCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createViews];
        [self layoutViews];
    }
    return self;
}

-(void)createViews {
    _btnCategory = [TDCateogryButton new];
    [_btnCategory setCateType:kCateTypeAll];
    [self.contentView addSubview:_btnCategory];
    
    _highlightCoverView = [UIView new];
    _highlightCoverView.backgroundColor = [UIColor colorWithWhite:0xEE / 255.f alpha:.5f];
    [self.contentView addSubview:_highlightCoverView];
    //_highlightCoverView.hidden = YES;
}

-(void)layoutViews {
    [_btnCategory alignToView:_btnCategory.superview];
    [_highlightCoverView alignToView:self];
    //[_highlightCoverView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    _highlightCoverView.hidden = !highlighted;
}

#pragma mark - style

+(float)HEIGHT {
    return MY_HEIGHT;
}

@end
