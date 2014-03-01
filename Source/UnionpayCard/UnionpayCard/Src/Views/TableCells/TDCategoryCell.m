//
//  TDCategoryCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCategoryCell.h"


#define MY_HEIGHT   (35)

@interface TDCategoryCell () {
    UIView                  *_highlightCoverView;
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
    
    
    _highlightCoverView = [UIView new];
    _highlightCoverView.backgroundColor = [UIColor colorWithWhite:0xDD / 255.f alpha:.5f];
    [self addSubview:_highlightCoverView];
    _highlightCoverView.hidden = YES;
    
    _btnCategory = [TDCateogryButton new];
    [_btnCategory setCateType:kCateTypeAll];
    [_btnCategory removeInnerAction];
    [self addSubview:_btnCategory];
}

-(void)layoutViews {
    [_btnCategory alignToView:self];
    [_highlightCoverView alignToView:self];
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//    _highlightCoverView.hidden = !highlighted;
//}

-(void)setItemSelected:(BOOL)aSelected {
    _highlightCoverView.hidden = !aSelected;
    [_btnCategory setSelected:aSelected];
}


#pragma mark - style

+(float)HEIGHT {
    return MY_HEIGHT;
}

@end
