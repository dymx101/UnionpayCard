//
//  TDAddMoneyVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/27/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDAddMoneyVC.h"
#import "TDRecordCell.h"

@interface TDAddMoneyVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tv;
}

@end

@implementation TDAddMoneyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"消费充值记录";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _tv = [UITableView new];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tv];
}

-(void)layoutViews {
    [_tv alignToView:self.view];
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDStr = @"TDRecordCell";
    TDRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDStr];
    if (cell == nil) {
        cell = [TDRecordCell new];
    }
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDRecordCell HEIGHT];
}

@end
