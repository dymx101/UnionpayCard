//
//  TDRegisterVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/23/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRegisterVC.h"
#import "TDRegisterStep2VC.h"
#import "GNWebVC.h"

#define STR_I_AGREE @"我已阅读并同意"

@interface TDRegisterVC () {
    UIImageView     *_ivProgress;
    UIImageView     *_ivBgInput;
    UITextField     *_tfInput;
    UIButton        *_btnGetCode;
    
    UIButton        *_btnAgree;
    UIButton        *_btnAgreement;
}

@end

@implementation TDRegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivProgress = [UIImageView new];
    _ivProgress.image = [UIImage imageNamed:@"register_step1_banner"];
    [self.view addSubview:_ivProgress];
    
    
    _ivBgInput = [UIImageView new];
    _ivBgInput.image = [TDImageLibrary sharedInstance].boxBGInput;
    [self.view addSubview:_ivBgInput];
    
    _tfInput = [UITextField new];
    _tfInput.placeholder = @"请输入您的手机号";
    _tfInput.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfInput.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_tfInput];
    
    _btnGetCode = [UIButton new];
    [_btnGetCode setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _btnGetCode.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnGetCode addTarget:self action:@selector(getcodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnGetCode];
    
    _btnAgree = [TDUtil checkBoxWithTitle:STR_I_AGREE target:self action:@selector(agreeAvtion:)];
    _btnAgree.selected = YES;
    [self.view addSubview:_btnAgree];
    
    _btnAgreement = [UIButton new];
    [_btnAgreement setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateNormal];
    _btnAgreement.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [_btnAgreement setTitle:@"朋派网用户协议" forState:UIControlStateNormal];
    [_btnAgreement addTarget:self action:@selector(seeAgreementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAgreement];
}

-(void)layoutViews {
    [_ivProgress alignTopEdgeWithView:self.view predicate:nil];
    [_ivProgress alignCenterXWithView:self.view predicate:nil];
    
    [_ivBgInput constrainTopSpaceToView:_ivProgress predicate:@"20"];
    [_ivBgInput alignCenterXWithView:self.view predicate:nil];
    
    [_tfInput alignLeading:@"20" trailing:@"-20" toView:_ivBgInput];
    [_tfInput alignCenterYWithView:_ivBgInput predicate:nil];
    
    [_btnGetCode constrainWidthToView:_ivBgInput predicate:nil];
    [_btnGetCode alignCenterXWithView:self.view predicate:nil];
    [_btnGetCode constrainTopSpaceToView:_ivBgInput predicate:@"20"];
    
    [_btnAgree alignLeadingEdgeWithView:_btnGetCode predicate:nil];
    [_btnAgree constrainTopSpaceToView:_btnGetCode predicate:@"15"];
    [_btnAgree constrainWidth:@"120"];
    
    [_btnAgreement alignBaselineWithView:_btnAgree predicate:nil];
    [_btnAgreement constrainLeadingSpaceToView:_btnAgree predicate:@"0"];
}

#pragma mark - action
-(void)agreeAvtion:(id)sender {
    _btnAgree.selected = !_btnAgree.selected;
    _btnGetCode.enabled = _btnAgree.selected;
}

-(void)seeAgreementAction:(id)sender {
    GNWebVC *webvc = [GNWebVC new];
    webvc.title = @"朋派网用户协议";
    webvc.urlStr = @"http://www.nuomi.com/about/eula";
    [self.navigationController pushViewController:webvc animated:YES];
}

-(void)getcodeAction:(id)sender {
    
    if (![self isMobileNumber:_tfInput.text]) {
        ALERT_MSG(nil, @"您输入的电话号码格式不正确");
        return;
    }
    
    __weak TDRegisterVC * weakSelf = self;
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService checkiphoneUserinfor:_tfInput.text completionBlock:^(id responseObject) {
        [HUD hide:YES];
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            TDRegisterStep2VC *vc = [TDRegisterStep2VC new];
            vc.phoneNUM = _tfInput.text;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            ALERT_MSG(nil, @"该电话号码已被注册");
        }
    }];
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
