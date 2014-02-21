//
//  TDProfileVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDProfileVC.h"
#import "TDLoginVC.h"

@interface TDProfileVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView            *_tv;
}

@end

@implementation TDProfileVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    [self createSubviews];
    [self layoutSubviews];
}

-(void)createSubviews {
    
    _tv = [UITableView new];
    _tv.delegate = self;
    _tv.dataSource = self;
    [self.view addSubview:_tv];
}

-(void)layoutSubviews {
    _tv.backgroundColor = [FDColor sharedInstance].clear;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tv alignToView:self.view];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDStr = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:cellIDStr];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [UIView new];
    UIImageView *ivBg = [[UIImageView alloc] initWithImage:[TDImageLibrary sharedInstance].mineAccountBg];
    [headerView addSubview:ivBg];
    
    [ivBg alignToView:headerView];
    
    // view not logged in
    UIView *viewNotLoggedIn = [UIView new];
    [headerView addSubview:viewNotLoggedIn];
    [viewNotLoggedIn alignToView:headerView];
    
    // label not logged in
    UILabel *lblNotLoggedIn = [UILabel new];
    lblNotLoggedIn.text = @"您还没有登录哦～";
    [viewNotLoggedIn addSubview:lblNotLoggedIn];
    [lblNotLoggedIn alignCenterXWithView:viewNotLoggedIn predicate:nil];
    [lblNotLoggedIn alignTopEdgeWithView:viewNotLoggedIn predicate:@"10"];
    
    // button log in
    UIButton *btnLogin = [UIButton new];
    [btnLogin setBackgroundImage:[TDImageLibrary sharedInstance].btnBgWhite forState:UIControlStateNormal];
    [btnLogin setTitle:@"马上登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewNotLoggedIn addSubview:btnLogin];
    [btnLogin alignCenterXWithView:viewNotLoggedIn predicate:nil];
    [btnLogin constrainTopSpaceToView:lblNotLoggedIn predicate:@"5"];
    [btnLogin constrainWidth:@"100"];
    
    return headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [TDImageLibrary sharedInstance].mineAccountBg.size.height;
}

#pragma mark - 
-(void)loginAction:(id)sender {
    TDLoginVC *vc = [TDLoginVC new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

@end
