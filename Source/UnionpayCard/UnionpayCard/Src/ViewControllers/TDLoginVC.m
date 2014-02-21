//
//  TDLoginVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/21/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDLoginVC.h"

@interface TDLoginVC ()

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
}

#pragma mark -
-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
