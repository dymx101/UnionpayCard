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
#import "TDCategoryCell.h"

@interface TDCardListVC () <UITableViewDelegate, UITableViewDataSource> {
    UIView              *_topBarShadowView;
    UIView              *_topBarView;
    TDCateogryButton    *_btnCategory;
    
    UIButton              *_viewMask;
    UITableView         *_cateTv;
    NSLayoutConstraint  *_constraintCateTvHeight;
    float               _cateTvHeight;
    int                 _cateTVSelectedIndex;
}

@end

@implementation TDCardListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [FDColor sharedInstance].red;
    self.navigationItem.title = @"卡片管理";
    
    _cateTvHeight = 400;
    
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTapAction:)];
    [_btnCategory addGestureRecognizer:tap];
    [_topBarView addSubview:_btnCategory];
    
    // mask
    _viewMask = [UIButton new];
    _viewMask.backgroundColor = [UIColor colorWithWhite:0 alpha:.5f];
    [self.view addSubview:_viewMask];
    [_viewMask addTarget:self action:@selector(hideCateMenu:) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer *tapMask = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCateMenu:)];
//    [_viewMask addGestureRecognizer:tapMask];
    
    //
    _cateTv = [UITableView new];
    _cateTv.delegate = self;
    _cateTv.dataSource = self;
    _cateTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_viewMask addSubview:_cateTv];
    

    [self hideCateMenu:nil];
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
    
    [_viewMask alignToView:self.view];
    
    [_cateTv alignTop:@"40" leading:@"1" toView:_viewMask];
    [_cateTv constrainWidth:@"99"];
    _constraintCateTvHeight = [_cateTv constrainHeight:@(_cateTvHeight).stringValue].firstObject;
}

#pragma mark - 
-(void)categoryTapAction:(id)sender {
    _viewMask.hidden = !_viewMask.hidden;
}

-(void)hideCateMenu:(id)sender {
    _viewMask.hidden = YES;
}

#pragma mark - table view
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _cateTv) {
        return 8;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _cateTv) {
        static NSString *cellIdStr = @"cellIdStr";
        TDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdStr];
        if (cell == nil) {
            cell = [TDCategoryCell new];
        }
        
        BOOL showCover = (indexPath.row == _cateTVSelectedIndex);
        [cell setItemSelected:showCover];
        
        return cell;
    }
    
    return nil;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _cateTv) {
        return [TDCategoryCell HEIGHT];
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cateTVSelectedIndex = indexPath.row;
    [tableView reloadData];
}

@end
