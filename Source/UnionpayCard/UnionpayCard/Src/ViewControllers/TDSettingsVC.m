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
    return @[@"消息提醒", @"分享设置", @"清空缓存"];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self settingItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDStr = @"cellID";
    TDSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDStr];
    if (cell == nil) {
        cell = [TDSettingCell new];//[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDStr];
    }
    
    int row = indexPath.row;
    ETDCellStyle cellStyle = [TDSettingCell cellStyleWithIndexPath:indexPath tableView:tableView tableViewDataSource:self];
    [cell setStyle:cellStyle];
   // cell.textLabel.text = [self settingItems][row];
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDSettingCell HEIGHT];
}

@end
