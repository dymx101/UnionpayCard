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
    UIImageView *iv = [UIImageView new];
    [iv setImageWithURL:[NSURL URLWithString:@"http://orzhd.com/briian/2007/08/0022.png"] placeholderImage:[UIImage imageNamed:@"union_pay"]];
    [self.view addSubview:iv];
    [iv alignCenterWithView:self.view];
}

@end
