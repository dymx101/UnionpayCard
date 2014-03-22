//
//  TDAddMoneyVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/27/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDAddMoneyVC.h"
#import "TDRecordCell.h"
#import "UIView+Effect.h"
#import "Userinfor.h"
#import "Consumption.h"
#import "PreRecords.h"
#import "TDLoginVC.h"

@interface TDAddMoneyVC () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    UITableView     *_tv;
    
    BOOL            _showAddMoneyRecord;
    UIView          *header;
    
    UISegmentedControl     *_segmentPageSwitch;
    UISegmentedControl     *_segmentSearch;
    
    UISearchBar             *_searchBar;
}

@property (nonatomic, strong) Userinfor * userinfor;
@property (nonatomic, strong) NSArray * Consumptions;
@property (nonatomic, strong) NSArray * PreRecords;
@end


@implementation TDAddMoneyVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"消费充值记录";
    
    _showAddMoneyRecord = YES;
    
    [self createViews];
    [self layoutViews];
    
    [self sendRequest];
    
    [_tv reloadData];
}

- (void) sendRequest {
    
    if (SharedAppUser) {
        
        __weak TDAddMoneyVC * weakSelf = self;
        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        [HUD show:YES];
        
        [TDHttpService ShowConsumption:SharedToken completionBlock:^(id responseObject) {
            [HUD hide:YES];
            if (responseObject!=nil && [responseObject isKindOfClass:[NSArray class]]) {
                weakSelf.Consumptions = responseObject;
                [TDHttpService ShowPreRecords:SharedToken completionBlock:^(id responseObject) {
                    [HUD hide:YES];
                    if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                        weakSelf.PreRecords = responseObject;
                        [self->_tv reloadData];
                    }
                }];
            }
        }];
    }
}

-(void)createViews {
    _tv = [UITableView new];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tv];
    
    
    _segmentPageSwitch = [[UISegmentedControl alloc] initWithItems:@[@"充值记录", @"消费记录"]];
    _segmentPageSwitch.selectedSegmentIndex = 0;
    _segmentPageSwitch.tintColor = [FDColor sharedInstance].white;
    [_segmentPageSwitch addTarget:self action:@selector(segPageChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentPageSwitch;
}

-(void)layoutViews {
    [_tv alignToView:self.view];
}

#pragma mark - segment control
-(void)segPageChanged:(UISegmentedControl *)aControl {
    NSUInteger selectedIndex = aControl.selectedSegmentIndex;
    if (selectedIndex == 0) {
        [self addMoneyRecordAction:nil];
    } else {
        [self useMoneyRecordAction:nil];
    }
}

-(void)segSearchChanged:(UISegmentedControl *)aControl {
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger numberofrows = 0;
    if (_showAddMoneyRecord) {
        numberofrows = [self.PreRecords count];
    }
    else {
        numberofrows = [self.Consumptions count];
    }
    return numberofrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIDStr = @"TDRecordCell";
    TDRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIDStr];
    if (cell == nil) {
        cell = [TDRecordCell new];
    }
    
    cell.btnFreeze.hidden = !_showAddMoneyRecord;
    if (_showAddMoneyRecord) {
        PreRecords * preRecord = self.PreRecords[indexPath.row];
        cell.lblVendorName.text = preRecord.b_jname;
        cell.lblCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",preRecord.card];
        cell.lblAmount.text = [NSString stringWithFormat:@"上账金额: ￥%@",preRecord.card_amount];
        cell.lblFlowNumber.text = [NSString stringWithFormat:@"充值流水号: %@",preRecord.b_no];
        cell.lblDataNumber.text = [NSString stringWithFormat:@"充值时间: %@",preRecord.pre_r_tmd];
    } else {
        Consumption * consumption =  self.Consumptions[indexPath.row];
        cell.lblVendorName.text = consumption.b_jname;
        cell.lblCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",consumption.card];
        cell.lblAmount.text = [NSString stringWithFormat:@"上账金额: ￥%@",consumption.con_amount];
        cell.lblFlowNumber.text =[NSString stringWithFormat:@"消费流水号: %@",consumption.b_no];
        cell.lblDataNumber.text = [NSString stringWithFormat:@"消费时间: %@",consumption.con_tmd];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDRecordCell HEIGHT];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (header == nil) {
        header = [UIView new];
        header.backgroundColor = [UIColor blackColor];
        [header applyEffectShadow];
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [FDColor sharedInstance].silver;
        [header addSubview:bgView];
        [bgView alignToView:header];
        
        //
        _segmentSearch = [[UISegmentedControl alloc] initWithItems:@[@"名称", @"卡号"]];
        _segmentSearch.selectedSegmentIndex = 0;
        //_segmentSearch.tintColor = [FDColor sharedInstance].themeBlue;
        [_segmentSearch addTarget:self action:@selector(segSearchChanged:) forControlEvents:UIControlEventValueChanged];
        [bgView addSubview:_segmentSearch];
        [_segmentSearch alignTop:@"5" leading:@"10" toView:bgView];
        
        //
        _searchBar = [UISearchBar new];
        _searchBar.delegate = self;
        if([TDUtil isIOS7]) {
            _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        }
        [bgView addSubview:_searchBar];
        [_searchBar alignCenterYWithView:_segmentSearch predicate:nil];
        [_searchBar alignLeading:@"100" trailing:@"-20" toView:bgView];
    }
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

#pragma mark -
-(void)addMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = YES;
    
    [_tv reloadData];
}

-(void)useMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = NO;
    
    [_tv reloadData];
}

#pragma mark - search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

@end
