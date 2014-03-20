//
//  TDMyAccountVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/2/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDMyAccountVC.h"
#import "UIView+Effect.h"

@interface TDMyAccountVC () {
    UIView      *_containerView;
    UILabel     *_lblUserName;
    UIImageView *_ivVip;
    UILabel     *_lblBalance;
    
    UILabel     *_lblConsumeTimes;
    UILabel     *_lblConsumeTotal;
    UILabel     *_lblRechargeTimes;
    UILabel     *_lblRechargeTotal;
    
    UIView      *_line1;
}

@end

@implementation TDMyAccountVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _containerView = [UIView new];
    _containerView.backgroundColor = [FDColor sharedInstance].white;
    [_containerView applyEffectRoundRectShadow];
    [self.view addSubview:_containerView];
    
    _lblUserName = [UILabel new];
    _lblUserName.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblUserName.text = @"霍比特人";
    [_containerView addSubview:_lblUserName];
    
    _ivVip = [UIImageView new];
    _ivVip.image = [UIImage imageNamed:@"icon_mine_level2user"];
    [_containerView addSubview:_ivVip];
    
    _lblBalance = [UILabel new];
    _lblBalance.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblBalance.textColor = [FDColor sharedInstance].gray;
    _lblBalance.text = @"积分: 3690";
    [_containerView addSubview:_lblBalance];
    
    _lblConsumeTimes = [UILabel new];
    _lblConsumeTimes.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblConsumeTimes.textColor = [FDColor sharedInstance].gray;
    _lblConsumeTimes.text = @"消费次数: 15";
    [_containerView addSubview:_lblConsumeTimes];
    
    _lblConsumeTotal = [UILabel new];
    _lblConsumeTotal.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblConsumeTotal.textColor = [FDColor sharedInstance].gray;
    _lblConsumeTotal.text = @"消费金额: ￥3690.00";
    [_containerView addSubview:_lblConsumeTotal];
    
    _lblRechargeTimes = [UILabel new];
    _lblRechargeTimes.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblRechargeTimes.textColor = [FDColor sharedInstance].gray;
    _lblRechargeTimes.text = @"充值次数: 5";
    [_containerView addSubview:_lblRechargeTimes];
    
    _lblRechargeTotal = [UILabel new];
    _lblRechargeTotal.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblRechargeTotal.textColor = [FDColor sharedInstance].gray;
    _lblRechargeTotal.text = @"充值金额: 4000";
    [_containerView addSubview:_lblRechargeTotal];
    
    _line1 = [UIView new];
    _line1.backgroundColor = [FDColor sharedInstance].silver;
    [_containerView addSubview:_line1];
}

-(void)setupViews {
    [_containerView alignTop:@"20" leading:@"20" bottom:@"-20" trailing:@"-20" toView:self.view];
    
    //
    [_lblUserName alignTop:@"15" leading:@"15" toView:_containerView];
    
    //
    [_ivVip alignCenterYWithView:_lblUserName predicate:nil];
    [_ivVip constrainLeadingSpaceToView:_lblUserName predicate:@"8"];
    
    //
    [_lblBalance constrainTopSpaceToView:_lblUserName predicate:@"10"];
    [_lblBalance alignLeadingEdgeWithView:_lblUserName predicate:nil];
    
    [_lblConsumeTimes constrainTopSpaceToView:_lblBalance predicate:@"10"];
    [_lblConsumeTimes alignLeadingEdgeWithView:_lblBalance predicate:nil];
    
    [_lblConsumeTotal constrainLeadingSpaceToView:_lblConsumeTimes predicate:@"20"];
    [_lblConsumeTotal alignCenterYWithView:_lblConsumeTimes predicate:nil];
   
    [_lblRechargeTimes constrainTopSpaceToView:_lblConsumeTimes predicate:@"10"];
    [_lblRechargeTimes alignLeadingEdgeWithView:_lblConsumeTimes predicate:nil];
    
    [_lblRechargeTotal constrainLeadingSpaceToView:_lblRechargeTimes predicate:@"20"];
    [_lblRechargeTotal alignCenterYWithView:_lblRechargeTimes predicate:nil];
    
    [_line1 alignLeading:@"0" trailing:@"0" toView:_containerView];
    [_line1 constrainTopSpaceToView:_lblRechargeTimes predicate:@"10"];
    [_line1 constrainHeight:@"0.5"];
}

@end
