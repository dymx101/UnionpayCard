//
//  TDRecordCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/3/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRecordCell.h"
#import "UIView+Effect.h"

#define  MY_HEIGHT      (100)

@interface TDRecordCell () {
    
}
//@property (nonatomic, strong) UIView   *bgView;

@end

@implementation TDRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createViews];
    }
    return self;
}

-(void)createViews {
//    _bgView = [UIView new];
//    _bgView.backgroundColor = [FDColor sharedInstance].white;
//    _bgView.layer.cornerRadius = 3;
//    _bgView.layer.borderWidth = 1;
//    _bgView.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
//    
//    [self addSubview:_bgView];
//    [_bgView alignTop:@"2" leading:@"5" bottom:@"-2" trailing:@"-5" toView:self];
    
    //
    _lblVendorName = [UILabel new];
    _lblVendorName.font = [TDFontLibrary sharedInstance].fontLargeBold;
    _lblVendorName.textColor = [FDColor sharedInstance].black;
    [self addSubview:_lblVendorName];
    [_lblVendorName alignTop:@"15" leading:@"20" toView:self];
    
    //
    _lblCardNumber = [UILabel new];
    _lblCardNumber.font = [TDFontLibrary sharedInstance].fontSmall;
    _lblCardNumber.textColor = [FDColor sharedInstance].darkGray;
    [self addSubview:_lblCardNumber];
    [_lblCardNumber alignCenterYWithView:_lblVendorName predicate:nil];
    [_lblCardNumber constrainLeadingSpaceToView:_lblVendorName predicate:@"10"];
    
    //
    _lblAmount = [UILabel new];
    _lblAmount.font = [TDFontLibrary sharedInstance].fontSmall;
    _lblAmount.textColor = [FDColor sharedInstance].themeBlue;
    [self addSubview:_lblAmount];
    [_lblAmount constrainTopSpaceToView:_lblVendorName predicate:@"15"];
    [_lblAmount alignLeadingEdgeWithView:_lblVendorName predicate:@"0"];
    
    //
    _lblFlowNumber = [UILabel new];
    _lblFlowNumber.font = [TDFontLibrary sharedInstance].fontSmall;
    _lblFlowNumber.textColor = [FDColor sharedInstance].themeBlue;
    [self addSubview:_lblFlowNumber];
    [_lblFlowNumber constrainTopSpaceToView:_lblAmount predicate:@"5"];
    [_lblFlowNumber alignLeadingEdgeWithView:_lblVendorName predicate:@"0"];
    
    //
    _btnFreeze = [UIButton new];
    [_btnFreeze setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnFreeze setTitle:@"冻结" forState:UIControlStateNormal];
    _btnFreeze.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [self addSubview:_btnFreeze];
    [_btnFreeze alignBottomEdgeWithView:_lblFlowNumber predicate:nil];
    [_btnFreeze alignTrailingEdgeWithView:self predicate:@"-15"];
    [_btnFreeze constrainWidth:@"60" height:@"25"];
    
    //
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [FDColor sharedInstance].silver;
    [self.contentView addSubview:bottomLine];
    [bottomLine constrainHeight:@"1"];
    [bottomLine alignBottomEdgeWithView:self.contentView predicate:nil];
    [bottomLine alignCenterXWithView:self.contentView predicate:nil];
    [bottomLine constrainWidthToView:self.contentView predicate:nil];
}

+(float)HEIGHT {
    return MY_HEIGHT;
}


@end
