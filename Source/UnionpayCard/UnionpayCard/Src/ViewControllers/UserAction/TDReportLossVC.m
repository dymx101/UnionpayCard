//
//  TDReportLossVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDReportLossVC.h"

@interface TDReportLossVC () {
    UIImageView     *_ivBgInputOld;
    UITextField     *_tfInputOld;
    
    UIImageView     *_ivBgInputNew;
    UITextField     *_tfInputNew;
    
    UIButton        *_btnGetCode;
}

@end

@implementation TDReportLossVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"紧急挂失";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivBgInputOld = [UIImageView new];
    _ivBgInputOld.image = [TDImageLibrary sharedInstance].blank;
    [self.view addSubview:_ivBgInputOld];
    
    _tfInputOld = [UITextField new];
    _tfInputOld.placeholder = @"真实姓名";
    _tfInputOld.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInputOld.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_tfInputOld];
    
    //
    _ivBgInputNew = [UIImageView new];
    _ivBgInputNew.image = [TDImageLibrary sharedInstance].blank;
    [self.view addSubview:_ivBgInputNew];
    
    _tfInputNew = [UITextField new];
    _tfInputNew.placeholder = @"身份证号";
    _tfInputNew.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInputNew.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfInputNew.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_tfInputNew];
    
    //
    _btnGetCode = [UIButton new];
    [_btnGetCode setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
    [_btnGetCode setTitle:@"修改交易密码" forState:UIControlStateNormal];
    _btnGetCode.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnGetCode addTarget:self action:@selector(changePwdAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnGetCode];
}

-(void)layoutViews {
    [_ivBgInputOld alignTopEdgeWithView:self.view predicate:@"20"];
    [_ivBgInputOld alignCenterXWithView:self.view predicate:nil];
    
    [_ivBgInputNew constrainTopSpaceToView:_ivBgInputOld predicate:@"5"];
    [_ivBgInputNew alignCenterXWithView:self.view predicate:nil];
    
    [_tfInputOld alignLeading:@"20" trailing:@"-20" toView:_ivBgInputOld];
    [_tfInputOld alignCenterYWithView:_ivBgInputOld predicate:nil];
    
    [_tfInputNew alignLeading:@"20" trailing:@"-20" toView:_ivBgInputNew];
    [_tfInputNew alignCenterYWithView:_ivBgInputNew predicate:nil];
    
    [_btnGetCode constrainWidthToView:_ivBgInputNew predicate:nil];
    [_btnGetCode alignCenterXWithView:self.view predicate:nil];
    [_btnGetCode constrainTopSpaceToView:_ivBgInputNew predicate:@"15"];
}

#pragma mark - actions
-(void)changePwdAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
