//
//  TDLoginVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/21/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDLoginVC.h"
#import "TDForgetPasswordVC.h"
#import "TDRegisterVC.h"
#import "TDRegisterNoAccountVC.h"
#import "Btype.h"
#import "GGUserDefault.h"

@interface TDLoginVC ()<MBProgressHUDDelegate> {
    UIImageView     *_loginInputView;
    UIView          *_lineView;
    
    UIImageView     *_ivUserName;
    UIImageView     *_ivPwd;
    
    UITextField     *_tfUserName;
    UITextField     *_tfPwd;
    
    UIButton        *_btnLogin;
    UIButton        *_btnRegister;
    UIButton        *_btnRegisterNoAccount;
    
    UIButton        *_btnrememberME;
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
    
    /**
     
     忘记密码 在网页上面实现
     
     UIImage *forgetPwdBgImg = [TDImageLibrary sharedInstance].btnBgGrayRound;
     UIButton *forgetPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
     [forgetPwdBtn setBackgroundImage:forgetPwdBgImg forState:UIControlStateNormal];
     [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
     forgetPwdBtn.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
     [forgetPwdBtn addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *itemForgetPwd = [[UIBarButtonItem alloc] initWithCustomView:forgetPwdBtn];
     self.navigationItem.rightBarButtonItem = itemForgetPwd;
     
     */
    
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
//    _tfUserName.text = @"13100615583";
    
    _tfPwd = [UITextField new];
    _tfPwd.placeholder = @"密码";
    _tfPwd.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfPwd.secureTextEntry = YES;
    [_loginInputView addSubview:_tfPwd];
//    _tfPwd.text = @"windwhc";
    
    _btnrememberME = [TDUtil checkBoxWithTitle:@"记住我" target:self action:@selector(rememberMEStatusChanged:)];
    [self.view addSubview:_btnrememberME];
    _btnrememberME.selected = NO;
    [_btnrememberME constrainWidth:@"100"];

    
    _btnLogin = [UIButton new];
    [_btnLogin setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    _btnLogin.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLogin];
    
    _btnRegister = [UIButton new];
    [_btnRegister setTitle:@"立即注册" forState:UIControlStateNormal];
    [_btnRegister setTitleColor:[FDColor sharedInstance].caribbeanGreen forState:UIControlStateNormal];
    [_btnRegister addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnRegister.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [self.view addSubview:_btnRegister];
    
    _btnRegisterNoAccount = [UIButton new];
    [_btnRegisterNoAccount setTitle:@"无账号快捷登录" forState:UIControlStateNormal];
    [_btnRegisterNoAccount setTitleColor:[FDColor sharedInstance].caribbeanGreen forState:UIControlStateNormal];
    [_btnRegisterNoAccount addTarget:self action:@selector(registerNoAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnRegisterNoAccount.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [self.view addSubview:_btnRegisterNoAccount];
    _btnRegisterNoAccount.hidden = YES;
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
    
    [_btnrememberME alignLeadingEdgeWithView:_tfPwd predicate:@"-40"];
    [_btnrememberME constrainTopSpaceToView:_tfPwd predicate:@"20"];
    
    [_btnLogin constrainWidthToView:_loginInputView predicate:nil];
    [_btnLogin alignLeadingEdgeWithView:_loginInputView predicate:nil];
    [_btnLogin constrainTopSpaceToView:_loginInputView predicate:@"40"];
    
    [_btnRegister alignLeadingEdgeWithView:_btnLogin predicate:@"10"];
    [_btnRegister constrainTopSpaceToView:_btnLogin predicate:@"10"];
    
    [_btnRegisterNoAccount alignTrailingEdgeWithView:_btnLogin predicate:@"-15"];
    [_btnRegisterNoAccount constrainTopSpaceToView:_btnLogin predicate:@"10"];
}


#pragma mark -
-(void)registerAction:(id)sender {
    TDRegisterVC *vc = [TDRegisterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loginAction:(id)sender {
    
    if (![_tfUserName.text isEqual:@""] && ![_tfPwd.text isEqual:@""]) {
        [GGUserDefault saveMyName:_tfUserName.text];
        [GGUserDefault saveMyPhone:_tfPwd.text];
    }
    __weak TDLoginVC * weakSelf = self;
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    [TDHttpService LoginUserinfor:_tfUserName.text loginPass:_tfPwd.text completionBlock:^(id responseObject) {
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]) {
            SharedToken = [responseObject objectForKey:@"userToken"];
            if (!SharedToken) {
                [HUD hide:YES];
                ALERT_MSG(nil, @"用户账号密码不正确");
                return;
            }
            [TDHttpService ShowUserinfor:SharedToken completionBlock:^(id responseObject) {
                [HUD hide:YES];
                if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                    SharedAppUser = [responseObject lastObject];
//                    [weakSelf.delegate getProfile:SharedToken];
                    [self postNotification:OTS_NOTE_LOGIN_OK];
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                } else {
                    ALERT_MSG(nil, @"用户账号密码不正确");
                }
            }];
        }
    }];
}

-(void)rememberMEStatusChanged:(UIButton *)sender {
    BOOL rememberME = sender.selected;
    _btnrememberME.selected = !rememberME;
    
    if (_btnrememberME.selected) {
        _tfUserName.text = [GGUserDefault myName];
        _tfPwd.text = [GGUserDefault myPhone];
    } else
    {
        _tfUserName.text = @"";
        _tfPwd.text = @"";
    }
}

-(void)registerNoAccountAction:(id)sender {
    TDRegisterNoAccountVC *vc = [TDRegisterNoAccountVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
