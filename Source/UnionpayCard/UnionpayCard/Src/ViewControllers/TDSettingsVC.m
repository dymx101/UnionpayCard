//
//  TDSettingsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSettingsVC.h"
#import "TDSettingCell.h"

@interface TDSettingsVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tvSettings;
}

@end

@implementation TDSettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    
    [self installLogoToNavibar];
    
    [self createViews];
    [self layoutViews];
}

-(NSArray *)settingItems {
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:@[@"消息提醒", @"分享设置", @"清空缓存"]];
    [items addObject:@[@"意见反馈", @"支付帮助", @"检查更新", @"关于朋派"]];
    
    return items;
}

-(void)createViews {
    _tvSettings = [UITableView new];//[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tvSettings.backgroundColor = [UIColor clearColor];
    _tvSettings.delegate = self;
    _tvSettings.dataSource = self;
    _tvSettings.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tvSettings];
    
}

-(void)layoutViews {
    [_tvSettings alignToView:self.view];
}



#pragma mark -
-(int)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self settingItems].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = [self settingItems][section];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDStr = @"cellID";
    TDSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDStr];
    if (cell == nil) {
        cell = [TDSettingCell new];//[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDStr];
    }
    
    int section = indexPath.section;
    int row = indexPath.row;
    ETDCellStyle cellStyle = [TDSettingCell cellStyleWithIndexPath:indexPath tableView:tableView tableViewDataSource:self];
    [cell setStyle:cellStyle];
    cell.lblTitle.text = [self settingItems][section][row];
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDSettingCell HEIGHT];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

@end
