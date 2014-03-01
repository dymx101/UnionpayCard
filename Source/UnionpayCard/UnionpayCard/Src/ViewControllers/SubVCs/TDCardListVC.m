//
//  TDCardListVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/27/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCardListVC.h"
#import "UIView+Effect.h"
#import "TDCateogryButton.h"

@interface TDCardListVC () {
    UIView *_topBarShadowView;
    UIView *_topBarView;
    TDCateogryButton    *_btnCategory;
}

@end

@implementation TDCardListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [FDColor sharedInstance].red;
    self.navigationItem.title = @"卡片管理";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _topBarShadowView = [UIView new];
    _topBarShadowView.backgroundColor = [FDColor sharedInstance].black;
    [_topBarShadowView applyEffectShadow];
    [self.view addSubview:_topBarShadowView];
    
    _topBarView = [UIView new];
    _topBarView.backgroundColor = [FDColor sharedInstance].white;
    [self.view addSubview:_topBarView];
    
    _btnCategory = [TDCateogryButton new];
    _btnCategory.backgroundColor = [FDColor sharedInstance].silver;
    [_btnCategory setCateType:kCateTypeAll];
    [_topBarView addSubview:_btnCategory];
}

-(void)layoutViews {
    [_topBarShadowView constrainWidthToView:self.view predicate:nil];
    [_topBarShadowView constrainHeight:@"40"];
    [_topBarShadowView alignTopEdgeWithView:self.view predicate:nil];
    [_topBarShadowView alignCenterXWithView:self.view predicate:nil];
    
    [_topBarView alignToView:_topBarShadowView];
    
    [_btnCategory constrainHeightToView:_topBarView predicate:nil];
    [_btnCategory constrainWidth:@"100"];
    [_btnCategory alignTop:@"0" leading:@"0" toView:_topBarView];
    
}

@end
