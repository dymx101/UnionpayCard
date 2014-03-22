//
//  TDChangeTradePwdVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDChangeTradePwdVC.h"

@interface TDChangeTradePwdVC () {
    UIImageView     *_ivBgInputOld;
    UITextField     *_tfInputOld;
    
    UIImageView     *_ivBgInputNew;
    UITextField     *_tfInputNew;
    
    UIImageView     *_ivBgInputNewAgain;
    UITextField     *_tfInputNewAgain;
    
    UIButton        *_btnGetCode;
}

@end

@implementation TDChangeTradePwdVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"修改交易密码";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivBgInputOld = [UIImageView new];
    _ivBgInputOld.image = [TDImageLibrary sharedInstance].boxBGInput;
    [self.view addSubview:_ivBgInputOld];
    
    _tfInputOld = [UITextField new];
    _tfInputOld.placeholder = @"输入当前交易密码";
    _tfInputOld.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInputOld.clearButtonMode = UITextFieldViewModeWhileEditing;
    //_tfInputOld.keyboardType = UIKeyboardTypePhonePad;
    _tfInputOld.secureTextEntry = YES;
    [self.view addSubview:_tfInputOld];
    
    //
    _ivBgInputNew = [UIImageView new];
    _ivBgInputNew.image = [TDImageLibrary sharedInstance].boxBGInput;
    [self.view addSubview:_ivBgInputNew];
    
    _tfInputNew = [UITextField new];
    _tfInputNew.placeholder = @"输入新交易密码";
    _tfInputNew.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInputNew.clearButtonMode = UITextFieldViewModeWhileEditing;
    //_tfInputNew.keyboardType = UIKeyboardTypePhonePad;
    _tfInputNew.secureTextEntry = YES;
    [self.view addSubview:_tfInputNew];
    
    //
    _ivBgInputNewAgain = [UIImageView new];
    _ivBgInputNewAgain.image = [TDImageLibrary sharedInstance].boxBGInput;
    [self.view addSubview:_ivBgInputNewAgain];
    
    _tfInputNewAgain = [UITextField new];
    _tfInputNewAgain.placeholder = @"再次输入新交易密码";
    _tfInputNewAgain.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInputNewAgain.clearButtonMode = UITextFieldViewModeWhileEditing;
    //_tfInputNewAgain.keyboardType = UIKeyboardTypePhonePad;
    _tfInputNewAgain.secureTextEntry = YES;
    [self.view addSubview:_tfInputNewAgain];
    
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
    
    [_ivBgInputNewAgain constrainTopSpaceToView:_ivBgInputNew predicate:@"5"];
    [_ivBgInputNewAgain alignCenterXWithView:self.view predicate:nil];
    
    [_tfInputOld alignLeading:@"20" trailing:@"-20" toView:_ivBgInputOld];
    [_tfInputOld alignCenterYWithView:_ivBgInputOld predicate:nil];
    
    [_tfInputNew alignLeading:@"20" trailing:@"-20" toView:_ivBgInputNew];
    [_tfInputNew alignCenterYWithView:_ivBgInputNew predicate:nil];
    
    [_tfInputNewAgain alignLeading:@"20" trailing:@"-20" toView:_ivBgInputNewAgain];
    [_tfInputNewAgain alignCenterYWithView:_ivBgInputNewAgain predicate:nil];
    
    [_btnGetCode constrainWidthToView:_ivBgInputNewAgain predicate:nil];
    [_btnGetCode alignCenterXWithView:self.view predicate:nil];
    [_btnGetCode constrainTopSpaceToView:_ivBgInputNewAgain predicate:@"15"];
}

#pragma mark - actions
-(void)changePwdAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
