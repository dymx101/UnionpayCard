//
//  TDLoginVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/21/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDLoginVC.h"
#import "TDForgetPasswordVC.h"

@interface TDLoginVC () {
    UIImageView     *_loginInputView;
    UIView          *_lineView;
    
    UIImageView     *_ivUserName;
    UIImageView     *_ivPwd;
    
    UITextField     *_tfUserName;
    UITextField     *_tfPwd;
    
    UIButton        *_btnLogin;
}

@end

@implementation TDLoginVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    UIImage *dismissImg = [TDImageLibrary sharedInstance].dismiss;
    UIButton *btnDismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dismissImg.size.width, dismissImg.size.height)];
    [btnDismiss setImage:dismissImg forState:UIControlStateNormal];
    [btnDismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemDismiss = [[UIBarButtonItem alloc] initWithCustomView:btnDismiss];
    self.navigationItem.leftBarButtonItem = itemDismiss;
    
    UIImage *forgetPwdBgImg = [TDImageLibrary sharedInstance].btnBgGrayRound;
    UIButton *forgetPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [forgetPwdBtn setBackgroundImage:forgetPwdBgImg forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [forgetPwdBtn addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemForgetPwd = [[UIBarButtonItem alloc] initWithCustomView:forgetPwdBtn];
    self.navigationItem.rightBarButtonItem = itemForgetPwd;
    
    [self createViews];
    [self layoutViews];
}

#pragma mark -
-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)forgetPasswordAction:(id)sender {
    TDForgetPasswordVC *vc = [TDForgetPasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)createViews {
    _loginInputView = [[UIImageView alloc] initWithImage:[TDImageLibrary sharedInstance].bgLoginInput];
    _loginInputView.userInteractionEnabled = YES;
    [self.view addSubview:_loginInputView];
    
    _lineView = [UIView new];
    _lineView.backgroundColor = [FDColor sharedInstance].silver;
    [_loginInputView addSubview:_lineView];
    
    _ivUserName = [UIImageView new];
    _ivUserName.image = [UIImage imageNamed:@"icon_login_user"];
    [_loginInputView addSubview:_ivUserName];
    
    _ivPwd = [UIImageView new];
    _ivPwd.image = [UIImage imageNamed:@"icon_login_password"];
    [_loginInputView addSubview:_ivPwd];
    
    _tfUserName = [UITextField new];
    _tfUserName.placeholder = @"账号";
    _tfUserName.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_loginInputView addSubview:_tfUserName];
    
    _tfPwd = [UITextField new];
    _tfPwd.placeholder = @"密码";
    _tfPwd.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_loginInputView addSubview:_tfPwd];
    
    _btnLogin = [UIButton new];
    [_btnLogin setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    _btnLogin.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [self.view addSubview:_btnLogin];
}

-(void)layoutViews {
    [_loginInputView alignLeading:@"20" trailing:@"-20" toView:self.view];
    [_loginInputView alignTopEdgeWithView:self.view predicate:@"20"];
    [_loginInputView constrainHeight:@"80"];
    
    [_lineView constrainHeight:@"1"];
    [_lineView alignCenterYWithView:_loginInputView predicate:nil];
    [_lineView constrainWidthToView:_loginInputView predicate:nil];
    [_lineView alignLeadingEdgeWithView:_loginInputView predicate:nil];
    
    [_ivUserName alignLeadingEdgeWithView:_loginInputView predicate:@"15"];
    [_ivUserName alignTopEdgeWithView:_loginInputView predicate:@"12"];
    
    [_ivPwd alignLeadingEdgeWithView:_loginInputView predicate:@"15"];
    [_ivPwd alignTopEdgeWithView:_lineView predicate:@"12"];
    
    [_tfUserName constrainLeadingSpaceToView:_ivUserName predicate:@"10"];
    [_tfUserName constrainWidthToView:_loginInputView predicate:@"-50"];
    [_tfUserName alignCenterYWithView:_ivUserName predicate:nil];
    
    [_tfPwd constrainLeadingSpaceToView:_ivPwd predicate:@"10"];
    [_tfPwd constrainWidthToView:_loginInputView predicate:@"-50"];
    [_tfPwd alignCenterYWithView:_ivPwd predicate:nil];
    
    [_btnLogin constrainWidthToView:_loginInputView predicate:nil];
    [_btnLogin alignLeadingEdgeWithView:_loginInputView predicate:nil];
    [_btnLogin constrainTopSpaceToView:_loginInputView predicate:@"20"];
}

@end
