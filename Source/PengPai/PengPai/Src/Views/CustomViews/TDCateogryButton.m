//
//  TDCateogryButton.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCateogryButton.h"

@interface TDCateogryButton () {
    ETDCateType             _type;
    BOOL                    _selected;
    UITapGestureRecognizer  *_tapGest;
}


@end

@implementation TDCateogryButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatViews];
        [self layoutViews];
    }
    return self;
}

-(void)creatViews {
    _ivIcon = [UIImageView new];
    [self addSubview:_ivIcon];
    
    _lblTitle = [UILabel new];
    [self addSubview:_lblTitle];
    
    //
    [self addInnerAction];
}

-(void)layoutViews {
    [_ivIcon alignCenterYWithView:self predicate:nil];
    [_ivIcon alignLeadingEdgeWithView:self predicate:@"20"];
    [_ivIcon constrainWidth:@"19" height:@"19"];
    
    [_lblTitle alignCenterYWithView:self predicate:nil];
    _lblTitle.font = [TDFontLibrary sharedInstance].fontNormal;
    [_lblTitle constrainLeadingSpaceToView:_ivIcon predicate:@"10"];
}

#pragma mark - 
-(void)setCateType:(ETDCateType)aCateType {
    _type = aCateType;
    _lblTitle.text = [TDCategoryResource title:_type];
    [self update];
}

-(void)setSelected:(BOOL)aSelected {
    _selected = aSelected;
    [self update];
}

-(BOOL)selected {
    return _selected;
}

-(void)update {
    _ivIcon.image = (_selected ? [TDCategoryResource imageSelected:_type] : [TDCategoryResource imageNormal:_type]);
}

#pragma mark - innner gest
-(void)removeInnerAction {
    [self removeGestureRecognizer:_tapGest];
}

-(void)addInnerAction {
    _tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:_tapGest];
}

-(void)tapAction:(id)sender {
    _selected = !_selected;
    [self update];
}

@end
