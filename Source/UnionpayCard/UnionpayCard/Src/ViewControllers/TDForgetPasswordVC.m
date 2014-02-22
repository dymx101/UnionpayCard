//
//  TDForgetPasswordVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/22/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDForgetPasswordVC.h"

@interface TDForgetPasswordVC ()

@end

@implementation TDForgetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *backImg = [TDImageLibrary sharedInstance].btnBackArrow;
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backImg.size.width, backImg.size.height)];
    [btnBack setImage:backImg forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = itemBack;
    self.navigationItem.hidesBackButton = YES;
}

-(void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
