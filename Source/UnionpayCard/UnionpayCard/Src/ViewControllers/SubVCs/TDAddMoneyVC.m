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

@interface TDAddMoneyVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tv;
    UIButton        *_btnAddMoneyRec;
    UIButton        *_btnUseMoneyRec;
    
    BOOL            _showAddMoneyRecord;
}

@end

@implementation TDAddMoneyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"消费充值记录";
    
    _showAddMoneyRecord = YES;
    
    [self createViews];
    [self layoutViews];
    
    [_tv reloadData];
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
    
    cell.btnFreeze.hidden = !_showAddMoneyRecord;
    if (_showAddMoneyRecord) {
        cell.lblVendorName.text = @"皇冠蛋糕";
        cell.lblCardNumber.text = @"[卡号] 12378378123871283";
        cell.lblAmount.text = @"充值金额: ￥200.00";
        cell.lblFlowNumber.text = @"充值流水号: 3457378453745";
    } else {
        cell.lblVendorName.text = @"周黑鸭";
        cell.lblCardNumber.text = @"卡号: 2348348385345835";
        cell.lblAmount.text = @"消费金额: ￥100.00";
        cell.lblFlowNumber.text = @"消费流水号: 3457378453745";
    }
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDRecordCell HEIGHT];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static UIView *header = nil;
    if (header == nil) {
        header = [UIView new];
        header.backgroundColor = [UIColor blackColor];
        [header applyEffectShadow];
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [FDColor sharedInstance].silver;
        [header addSubview:bgView];
        [bgView alignToView:header];
        
        //
        _btnAddMoneyRec = [UIButton new];
        [_btnAddMoneyRec setTitle:@"充值记录" forState:UIControlStateNormal];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateHighlighted];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].gray forState:UIControlStateNormal];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].black forState:UIControlStateSelected];
        _btnAddMoneyRec.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
        
        [_btnAddMoneyRec addTarget:self action:@selector(addMoneyRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_btnAddMoneyRec];
        [_btnAddMoneyRec alignLeadingEdgeWithView:bgView predicate:@"0"];
        [_btnAddMoneyRec constrainHeightToView:bgView predicate:nil];
        [_btnAddMoneyRec alignCenterYWithView:bgView predicate:nil];
        [_btnAddMoneyRec constrainWidthToView:bgView predicate:@"*.5"];
        _btnAddMoneyRec.selected = _showAddMoneyRecord;
        
        //
        UIView *_vertDevideLine = [UIView new];
        _vertDevideLine.backgroundColor = [FDColor sharedInstance].silverDark;
        [bgView addSubview:_vertDevideLine];
        [_vertDevideLine constrainWidth:@"1"];
        [_vertDevideLine alignCenterXWithView:bgView predicate:nil];
        [_vertDevideLine alignTop:@"10" bottom:@"-10" toView:bgView];
        
        //
        _btnUseMoneyRec = [UIButton new];
        [_btnUseMoneyRec setTitle:@"消费记录" forState:UIControlStateNormal];
        [_btnUseMoneyRec setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateHighlighted];
        _btnUseMoneyRec.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
        
        [_btnUseMoneyRec addTarget:self action:@selector(useMoneyRecordAction:) forControlEvents:UIControlEventTouchUpInside];
        [_btnUseMoneyRec setTitleColor:[FDColor sharedInstance].gray forState:UIControlStateNormal];
        [_btnUseMoneyRec setTitleColor:[FDColor sharedInstance].black forState:UIControlStateSelected];
        [bgView addSubview:_btnUseMoneyRec];
        [_btnUseMoneyRec alignTrailingEdgeWithView:bgView predicate:@"0"];
        [_btnUseMoneyRec constrainHeightToView:bgView predicate:nil];
        [_btnUseMoneyRec alignCenterYWithView:bgView predicate:nil];
        [_btnUseMoneyRec constrainWidthToView:bgView predicate:@"*.5"];
    }
    
    return header;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

#pragma mark - 
-(void)addMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = YES;
    _btnAddMoneyRec.selected = _showAddMoneyRecord;
    _btnUseMoneyRec.selected = !_showAddMoneyRecord;
    
    [_tv reloadData];
}

-(void)useMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = NO;
    _btnAddMoneyRec.selected = _showAddMoneyRecord;
    _btnUseMoneyRec.selected = !_showAddMoneyRecord;
    
    [_tv reloadData];
}

@end
