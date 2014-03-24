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
    
    UIView      *_line0;
    
    UILabel     *_lblBalance;
    
    UILabel     *_lblConsumeTimes;
    UILabel     *_lblConsumeTotal;
    UILabel     *_lblRechargeTimes;
    UILabel     *_lblRechargeTotal;
    
    UIView      *_line1;
    
    UILabel     *_lblStatusLogin;
    UILabel     *_lblStatusTrade;
    UILabel     *_lblStatusReportLoss;
    
    UIButton    *_btnStatusLoginNomal;
    UIButton    *_btnStatusLoginLocked;
    
    UIButton    *_btnStatusTradeNomal;
    UIButton    *_btnStatusTradeLocked;
    
    UIButton    *_btnStatusLossNomal;
    UIButton    *_btnStatusLossLocked;
    
    UIView      *_line2;
    
    UILabel     *_lblCurrentCardNumber;
    
    UIButton    *_loginOutBTn;
    
}

@end

//[TDUtil checkBoxWithTitle:STR_I_AGREE target:self action:@selector(agreeAvtion:)];

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
    _lblUserName.font = [TDFontLibrary sharedInstance].fontNormalBold;
    _lblUserName.text = @"霍比特人";
    [_containerView addSubview:_lblUserName];
    
    _ivVip = [UIImageView new];
    _ivVip.image = [UIImage imageNamed:@"icon_mine_level2user"];
    [_containerView addSubview:_ivVip];
    
    _line0 = [UIView new];
    _line0.backgroundColor = [FDColor sharedInstance].silverDark;
    [_containerView addSubview:_line0];
    
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
    _line1.backgroundColor = [FDColor sharedInstance].silverDark;
    [_containerView addSubview:_line1];
    
    
    /////// section 2
    _lblStatusLogin = [UILabel new];
    _lblStatusLogin.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblStatusLogin.textColor = [FDColor sharedInstance].darkGray;
    _lblStatusLogin.text = @"登录状态:";
    [_containerView addSubview:_lblStatusLogin];
    
    _lblStatusTrade = [UILabel new];
    _lblStatusTrade.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblStatusTrade.textColor = [FDColor sharedInstance].darkGray;
    _lblStatusTrade.text = @"交易状态:";
    [_containerView addSubview:_lblStatusTrade];
    
    _lblStatusReportLoss = [UILabel new];
    _lblStatusReportLoss.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblStatusReportLoss.textColor = [FDColor sharedInstance].darkGray;
    _lblStatusReportLoss.text = @"挂失状态:";
    [_containerView addSubview:_lblStatusReportLoss];
    
    //
    _btnStatusLoginNomal = [TDUtil checkBoxWithTitle:@"正常" target:self action:@selector(dummyAction:)];
    _btnStatusLoginNomal.selected = YES;
    _btnStatusLoginNomal.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusLoginNomal];
    
    _btnStatusLoginLocked = [TDUtil checkBoxWithTitle:@"锁定" target:self action:@selector(dummyAction:)];
    _btnStatusLoginLocked.selected = NO;
    _btnStatusLoginLocked.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusLoginLocked];
    
    //
    _btnStatusTradeNomal = [TDUtil checkBoxWithTitle:@"正常" target:self action:@selector(dummyAction:)];
    _btnStatusTradeNomal.selected = YES;
    _btnStatusTradeNomal.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusTradeNomal];
    
    _btnStatusTradeLocked = [TDUtil checkBoxWithTitle:@"锁定" target:self action:@selector(dummyAction:)];
    _btnStatusTradeLocked.selected = NO;
    _btnStatusTradeLocked.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusTradeLocked];
    
    //
    _btnStatusLossNomal = [TDUtil checkBoxWithTitle:@"正常" target:self action:@selector(dummyAction:)];
    _btnStatusLossNomal.selected = NO;
    _btnStatusLossNomal.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusLossNomal];
    
    _btnStatusLossLocked = [TDUtil checkBoxWithTitle:@"锁定" target:self action:@selector(dummyAction:)];
    _btnStatusLossLocked.selected = YES;
    _btnStatusLossLocked.userInteractionEnabled = NO;
    [_containerView addSubview:_btnStatusLossLocked];
    
    
    _line2 = [UIView new];
    _line2.backgroundColor = [FDColor sharedInstance].silverDark;
    [_containerView addSubview:_line2];
    
    
    //// section 3
    _lblCurrentCardNumber = [UILabel new];
    _lblCurrentCardNumber.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblCurrentCardNumber.textColor = [FDColor sharedInstance].themeBlue;
    _lblCurrentCardNumber.text = @"当前卡号:  00123456789X";
    [_containerView addSubview:_lblCurrentCardNumber];
    
    _loginOutBTn = [UIButton new];
    [_loginOutBTn setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_loginOutBTn setTitle:@"退出登录" forState:UIControlStateNormal];
    _loginOutBTn.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_loginOutBTn addTarget:self action:@selector(loginOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginOutBTn];
}

-(void)setupViews {
    [_containerView alignTop:@"20" leading:@"20" bottom:@"-20" trailing:@"-20" toView:self.view];
    
    //
    [_lblUserName alignTop:@"15" leading:@"15" toView:_containerView];
    
    //
    [_ivVip alignCenterYWithView:_lblUserName predicate:nil];
    [_ivVip constrainLeadingSpaceToView:_lblUserName predicate:@"8"];
    
    /////////////////////////////////////////////
    [_line0 alignLeading:@"0" trailing:@"0" toView:_containerView];
    [_line0 constrainTopSpaceToView:_lblUserName predicate:@"15"];
    [_line0 constrainHeight:@"0.5"];
    
    //
    [_lblBalance constrainTopSpaceToView:_line0 predicate:@"15"];
    [_lblBalance alignLeadingEdgeWithView:_lblUserName predicate:nil];
    
    [_lblConsumeTimes constrainTopSpaceToView:_lblBalance predicate:@"10"];
    [_lblConsumeTimes alignLeadingEdgeWithView:_lblBalance predicate:nil];
    
    [_lblConsumeTotal constrainLeadingSpaceToView:_lblConsumeTimes predicate:@"20"];
    [_lblConsumeTotal alignCenterYWithView:_lblConsumeTimes predicate:nil];
   
    [_lblRechargeTimes constrainTopSpaceToView:_lblConsumeTimes predicate:@"10"];
    [_lblRechargeTimes alignLeadingEdgeWithView:_lblConsumeTimes predicate:nil];
    
    [_lblRechargeTotal constrainLeadingSpaceToView:_lblRechargeTimes predicate:@"20"];
    [_lblRechargeTotal alignCenterYWithView:_lblRechargeTimes predicate:nil];
    
    /////////////////////////////////////////////
    [_line1 alignLeading:@"0" trailing:@"0" toView:_containerView];
    [_line1 constrainTopSpaceToView:_lblRechargeTimes predicate:@"15"];
    [_line1 constrainHeight:@"0.5"];
    
    ///// section 2
    [_lblStatusLogin constrainTopSpaceToView:_line1 predicate:@"15"];
    [_lblStatusLogin alignLeadingEdgeWithView:_lblRechargeTimes predicate:nil];
    
    [_btnStatusLoginNomal constrainLeadingSpaceToView:_lblStatusLogin predicate:@"20"];
    [_btnStatusLoginNomal alignCenterYWithView:_lblStatusLogin predicate:nil];
    [_btnStatusLoginNomal constrainWidth:@"50"];
    
    [_btnStatusLoginLocked constrainLeadingSpaceToView:_btnStatusLoginNomal predicate:@"20"];
    [_btnStatusLoginLocked alignCenterYWithView:_btnStatusLoginNomal predicate:nil];
    [_btnStatusLoginLocked constrainWidth:@"50"];
    
    //
    [_lblStatusTrade constrainTopSpaceToView:_lblStatusLogin predicate:@"15"];
    [_lblStatusTrade alignLeadingEdgeWithView:_lblStatusLogin predicate:nil];
    
    [_btnStatusTradeNomal constrainLeadingSpaceToView:_lblStatusTrade predicate:@"20"];
    [_btnStatusTradeNomal alignCenterYWithView:_lblStatusTrade predicate:nil];
    [_btnStatusTradeNomal constrainWidth:@"50"];
    
    [_btnStatusTradeLocked constrainLeadingSpaceToView:_btnStatusTradeNomal predicate:@"20"];
    [_btnStatusTradeLocked alignCenterYWithView:_btnStatusTradeNomal predicate:nil];
    [_btnStatusTradeLocked constrainWidth:@"50"];
    
    //
    [_lblStatusReportLoss constrainTopSpaceToView:_lblStatusTrade predicate:@"15"];
    [_lblStatusReportLoss alignLeadingEdgeWithView:_lblStatusTrade predicate:nil];
    
    [_btnStatusLossNomal constrainLeadingSpaceToView:_lblStatusReportLoss predicate:@"20"];
    [_btnStatusLossNomal alignCenterYWithView:_lblStatusReportLoss predicate:nil];
    [_btnStatusLossNomal constrainWidth:@"50"];
    
    [_btnStatusLossLocked constrainLeadingSpaceToView:_btnStatusLossNomal predicate:@"20"];
    [_btnStatusLossLocked alignCenterYWithView:_btnStatusLossNomal predicate:nil];
    [_btnStatusLossLocked constrainWidth:@"50"];
    
    /////////////////////////////////////////////
    [_line2 alignLeading:@"0" trailing:@"0" toView:_containerView];
    [_line2 constrainTopSpaceToView:_lblStatusReportLoss predicate:@"15"];
    [_line2 constrainHeight:@"0.5"];
    
    
    //// section 3
    [_lblCurrentCardNumber constrainTopSpaceToView:_line2 predicate:@"20"];
    [_lblCurrentCardNumber alignLeadingEdgeWithView:_lblStatusReportLoss predicate:nil];
    
    [_loginOutBTn constrainWidthToView:_lblCurrentCardNumber predicate:nil];
    [_loginOutBTn alignCenterXWithView:self.view predicate:nil];
    [_loginOutBTn constrainTopSpaceToView:_lblCurrentCardNumber predicate:@"15"];
}

#pragma mark - actions
-(void)dummyAction:(id)sender {
    
}

-(void)loginOutAction:(id)sender {
    __weak TDMyAccountVC * weakSelf = self;
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService exitTOKEN:SharedToken completionBlock:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            SharedAppUser = nil;
            [self postNotification:OTS_NOTE_LOGIN_OK];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            ALERT_MSG(nil, @"退出失败 !");
        }
    }];
    
}

@end
