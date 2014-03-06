//
//  TDMerchantsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDMerchantsVC.h"

@interface TDMerchantsVC ()

@end

@implementation TDMerchantsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"商家";
    
    [self installLogoToNavibar];
    [self installMapAndSearchToNavibar];
    
    [self setupViews];
}

-(void)setupViews {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"union_pay"]];
    [self.view addSubview:iv];
    [iv alignCenterWithView:self.view];
}

@end
