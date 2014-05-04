//
//  GNTextFieldCell.m
//  GageinNew
//
//  Created by Dong Yiming on 3/11/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNTextFieldCell.h"

@interface GNTextFieldCell () {
    UIImageView     *_ivBg;
    UIView          *_seperatorView;
    UIView          *_highlightCoverView;
}

@end

@implementation GNTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [FDColor sharedInstance].clear;
        
        _ivBg = [UIImageView new];
        [self.contentView addSubview:_ivBg];
        
        _seperatorView = [UIView new];
        _seperatorView.backgroundColor = [FDColor sharedInstance].silver;
        [self.contentView addSubview:_seperatorView];
        
        _highlightCoverView = [UIView new];
        float grayValue = (0XEE/255.f);
        _highlightCoverView.backgroundColor = [UIColor colorWithWhite:grayValue alpha:1.f];
        [self.contentView addSubview:_highlightCoverView];
        _highlightCoverView.hidden = YES;
        
        _textField = [UITextField new];
        _textField.font = [TDFontLibrary sharedInstance].fontNormal;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:_textField];
        
        [self setupConstraints];
    }
    return self;
}

-(void)setupConstraints {
    [_ivBg constrainHeightToView:self.contentView predicate:nil];
    [_ivBg alignTopEdgeWithView:self.contentView predicate:nil];
    [_ivBg alignLeading:@"20" trailing:@"-20" toView:self];
    
    [_seperatorView constrainHeight:@"1"];
    [_seperatorView alignLeading:@"20" trailing:@"-20" toView:self];
    [_seperatorView alignBottomEdgeWithView:self predicate:nil];
    
    [_highlightCoverView alignToView:_ivBg];
    
    [_textField alignTop:@"2" leading:@"30" bottom:@"2" trailing:@"-30" toView:self.contentView];
}

-(void)setStyle:(ETDCellStyle)aStyle {
    switch (aStyle) {
        case kTDCellStyleTop:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupTop;
            _seperatorView.hidden = NO;
            break;
            
        case kTDCellStyleMiddle:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupMiddle;
            _seperatorView.hidden = NO;
            break;
            
        case kTDCellStyleBottom:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupBottom;
            _seperatorView.hidden = YES;
            break;
            
        case kTDCellStyleRound:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupRound;
            _seperatorView.hidden = YES;
            break;
            
        default:
            break;
    }
}

@end
