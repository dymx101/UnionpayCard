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
@property (nonatomic, strong) UIView   *bgView;

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
    _bgView = [UIView new];
    _bgView.backgroundColor = [FDColor sharedInstance].white;
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
    
    [self addSubview:_bgView];
    [_bgView alignTop:@"2" leading:@"5" bottom:@"-2" trailing:@"-5" toView:self];
    
    //
    _lblVendorName = [UILabel new];
    _lblVendorName.text = @"仟吉西饼";
    _lblVendorName.font = [TDFontLibrary sharedInstance].fontTitleBold;
    _lblVendorName.textColor = [FDColor sharedInstance].themeBlue;
    [self addSubview:_lblVendorName];
    [_lblVendorName alignTop:@"10" leading:@"20" toView:self];
    
    //
    _lblCardNumber = [UILabel new];
    _lblCardNumber.text = @"卡号:23467384628374";
    _lblCardNumber.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblCardNumber.textColor = [FDColor sharedInstance].gray;
    [self addSubview:_lblCardNumber];
    [_lblCardNumber alignCenterYWithView:_lblVendorName predicate:nil];
    [_lblCardNumber constrainLeadingSpaceToView:_lblVendorName predicate:@"10"];
    
    //
    _lblAmount = [UILabel new];
    _lblAmount.text = @"充值金额：￥200.00";
    _lblAmount.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblAmount.textColor = [FDColor sharedInstance].red;
    [self addSubview:_lblAmount];
    [_lblAmount constrainTopSpaceToView:_lblVendorName predicate:@"10"];
    [_lblAmount alignLeadingEdgeWithView:_lblVendorName predicate:@"0"];
    
    //
    _lblFlowNumber = [UILabel new];
    _lblFlowNumber.text = @"充值流水号: 1376746182361837126378162";
    _lblFlowNumber.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblFlowNumber.textColor = [FDColor sharedInstance].lightGray;
    [self addSubview:_lblFlowNumber];
    [_lblFlowNumber constrainTopSpaceToView:_lblAmount predicate:@"10"];
    [_lblFlowNumber alignLeadingEdgeWithView:_lblVendorName predicate:@"0"];
    
    //
    _btnFreeze = [UIButton new];
    [_btnFreeze setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnFreeze setTitle:@"冻结" forState:UIControlStateNormal];
    _btnFreeze.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [self addSubview:_btnFreeze];
    [_btnFreeze alignCenterYWithView:_lblFlowNumber predicate:nil];
    [_btnFreeze alignTrailingEdgeWithView:_bgView predicate:@"-10"];
    [_btnFreeze constrainWidth:@"70" height:@"30"];
}

+(float)HEIGHT {
    return MY_HEIGHT;
}


@end
