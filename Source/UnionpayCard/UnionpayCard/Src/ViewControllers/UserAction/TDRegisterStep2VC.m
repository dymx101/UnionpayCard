//
//  TDRegisterStep2VC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/15/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRegisterStep2VC.h"
#import "TDRegisterStep3VC.h"

@interface TDRegisterStep2VC () {
    UIImageView     *_ivProgress;
    UIImageView     *_ivBgInput;
    UITextField     *_tfInput;
    UIButton        *_btnGetCode;
    
    UILabel         *_lblCodeTip;
}

@end

@implementation TDRegisterStep2VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    UIImage *forgetPwdBgImg = [TDImageLibrary sharedInstance].btnBgGrayRound;
    UIButton *forgetPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [forgetPwdBtn setBackgroundImage:forgetPwdBgImg forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"重获验证码" forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [forgetPwdBtn addTarget:self action:@selector(requestCodeAgainAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemForgetPwd = [[UIBarButtonItem alloc] initWithCustomView:forgetPwdBtn];
    self.navigationItem.rightBarButtonItem = itemForgetPwd;
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivProgress = [UIImageView new];
    _ivProgress.image = [UIImage imageNamed:@"register_step2_banner"];
    [self.view addSubview:_ivProgress];
    
    
    _lblCodeTip = [UILabel new];
    _lblCodeTip.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblCodeTip.textColor = [FDColor sharedInstance].gray;
    
    NSMutableString * maskphone = [NSMutableString stringWithString:_phoneNUM];
    [maskphone replaceCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    _lblCodeTip.text = [NSString stringWithFormat:@"验证码短信已发送到%@",maskphone];
    [self.view addSubview:_lblCodeTip];
    
    _ivBgInput = [UIImageView new];
    _ivBgInput.image = [TDImageLibrary sharedInstance].boxBGInput;
    [self.view addSubview:_ivBgInput];
    
    _tfInput = [UITextField new];
    _tfInput.placeholder = @"输入短信中的验证码";
    _tfInput.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfInput.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_tfInput];
    
    _btnGetCode = [UIButton new];
    [_btnGetCode setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnGetCode setTitle:@"提交验证码" forState:UIControlStateNormal];
    _btnGetCode.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnGetCode addTarget:self action:@selector(submitCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnGetCode];
}

-(void)layoutViews {
    [_ivProgress alignTopEdgeWithView:self.view predicate:nil];
    [_ivProgress alignCenterXWithView:self.view predicate:nil];
    
    [_lblCodeTip constrainTopSpaceToView:_ivProgress predicate:@"15"];
    [_lblCodeTip alignCenterXWithView:self.view predicate:nil];
    
    [_ivBgInput constrainTopSpaceToView:_lblCodeTip predicate:@"10"];
    [_ivBgInput alignCenterXWithView:self.view predicate:nil];
    
    [_tfInput alignLeading:@"20" trailing:@"-20" toView:_ivBgInput];
    [_tfInput alignCenterYWithView:_ivBgInput predicate:nil];
    
    [_btnGetCode constrainWidthToView:_ivBgInput predicate:nil];
    [_btnGetCode alignCenterXWithView:self.view predicate:nil];
    [_btnGetCode constrainTopSpaceToView:_ivBgInput predicate:@"20"];
}

#pragma mark - actions
-(void)requestCodeAgainAction:(id)sender {
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService checkiphoneUserinfor:_phoneNUM completionBlock:^(id responseObject) {
        [HUD hide:YES];
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            ALERT_MSG(nil, @"重新发送验证码成功，请查收");
        }
    }];
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重新发送验证码成功，请查收" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //    [alert show];
    
    
}

-(void)submitCodeAction:(id)sender {
    
    if (_tfInput.text.length < 6 ) {
        ALERT_MSG(nil, @"您输入的验证码格式不正确");
        return;
    }
    
    [_tfInput resignFirstResponder];
    
    __weak TDRegisterStep2VC * weakSelf = self;
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService checkphonemassage:_phoneNUM Code:_tfInput.text completionBlock:^(id responseObject) {
        [HUD hide:YES];
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            
            TDRegisterStep3VC *vc = [TDRegisterStep3VC new];
            vc.phoneNUM = _phoneNUM;
            vc.phoneCode = _tfInput.text;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            ALERT_MSG(nil, @"验证码过期");
            _tfInput.text = @"";
        }
        
        
    }];
    
}

@end
