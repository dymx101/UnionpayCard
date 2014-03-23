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
    BOOL                    _isSearchByName;
    
    UISearchBar             *_searchBar;
    
    UIButton                *_lblStartTime;
    UIButton                *_btnStartTime;
    NSDate                  *_startDate;
    
    UIButton                *_lblEndTime;
    UIButton                *_btnEndTime;
    NSDate                  *_endDate;
    
    BOOL                    _isPickingStartTime;
    
    UIView                  *_pickerHolder;
    UIDatePicker            *_pickerTime;
    UIButton                *_btnPickerOK;
    UIButton                *_btnPickerCancel;
    
    NSLayoutConstraint      *_constraintPickerSpaceFromBottom;
    
    UILabel                 *_lblRechargeType;
    UIButton                *_btnRechargeByPos;
    UIButton                *_btnRechargeOnline;
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
    
    _pickerHolder = [UIView new];
    _pickerHolder.backgroundColor = [FDColor sharedInstance].silver;
    [self.view addSubview:_pickerHolder];
    
    _btnPickerOK = [UIButton new];
    [_btnPickerOK setTitle:@"确定" forState:UIControlStateNormal];
    _btnPickerOK.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [_btnPickerOK addTarget:self action:@selector(pickOKAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnPickerOK setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateNormal];
    [_pickerHolder addSubview:_btnPickerOK];
    
    _btnPickerCancel = [UIButton new];
    [_btnPickerCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnPickerCancel addTarget:self action:@selector(pickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    _btnPickerCancel.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [_btnPickerCancel setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateNormal];
    [_pickerHolder addSubview:_btnPickerCancel];
    
    _pickerTime = [UIDatePicker new];
    _pickerTime.datePickerMode = UIDatePickerModeDate;
    [_pickerTime addTarget:self action:@selector(timePickChanged:) forControlEvents:UIControlEventValueChanged];
    _pickerTime.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_pickerHolder addSubview:_pickerTime];
}

#define PICKER_HEIGHT       (140)
-(void)layoutViews {
    [_tv alignToView:self.view];
    

    [_pickerHolder constrainHeight:@(PICKER_HEIGHT).stringValue];
    _constraintPickerSpaceFromBottom = [_pickerHolder alignBottomEdgeWithView:self.view predicate:@(PICKER_HEIGHT).stringValue].firstObject;
    [_pickerHolder alignLeading:@"0" trailing:@"0" toView:self.view];
    
    
    [_btnPickerOK alignTrailingEdgeWithView:_pickerHolder predicate:@"-10"];
    [_btnPickerOK alignTopEdgeWithView:_pickerHolder predicate:@"5"];
    
    [_btnPickerCancel alignLeadingEdgeWithView:_pickerHolder predicate:@"10"];
    [_btnPickerCancel alignTopEdgeWithView:_pickerHolder predicate:@"5"];
    
    [_pickerTime constrainHeight:@"100"];
    [_pickerTime alignBottomEdgeWithView:_pickerHolder predicate:@"0"];
    [_pickerTime alignLeading:@"0" trailing:@"0" toView:_pickerHolder];
}

#pragma mark - date picker
-(void)timePickChanged:(UIDatePicker *)aPicker {
    
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
    _isSearchByName = (aControl.selectedSegmentIndex == 0);
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
        _isSearchByName = YES;
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
        
        //
        _lblStartTime = [UIButton new];
        _lblStartTime.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
        [_lblStartTime setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
        [_lblStartTime setTitle:@"开始时间: " forState:UIControlStateNormal];
        [_lblStartTime addTarget:self action:@selector(pickStartTime:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_lblStartTime];
        [_lblStartTime alignLeadingEdgeWithView:_segmentSearch predicate:nil];
        [_lblStartTime constrainTopSpaceToView:_segmentSearch predicate:@"10"];
        
        _btnStartTime = [UIButton new];
        _btnStartTime.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
        [_btnStartTime setTitle:@"" forState:UIControlStateNormal];
        [_btnStartTime setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateNormal];
        [_btnStartTime addTarget:self action:@selector(pickStartTime:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_btnStartTime];
        [_btnStartTime alignCenterYWithView:_lblStartTime predicate:nil];
        [_btnStartTime constrainLeadingSpaceToView:_lblStartTime predicate:@"5"];
        
        
        //
        _lblEndTime = [UIButton new];
        _lblEndTime.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
        [_lblEndTime setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
        [_lblEndTime setTitle:@"结束时间: " forState:UIControlStateNormal];
        [_lblEndTime addTarget:self action:@selector(pickEndTime:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_lblEndTime];
        [_lblEndTime constrainTopSpaceToView:_lblStartTime predicate:@"3"];
        [_lblEndTime alignLeadingEdgeWithView:_lblStartTime predicate:nil];
        
        _btnEndTime = [UIButton new];
        _btnEndTime.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
        [_btnEndTime setTitle:@"" forState:UIControlStateNormal];
        [_btnEndTime setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateNormal];
        [_btnEndTime addTarget:self action:@selector(pickEndTime:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_btnEndTime];
        [_btnEndTime alignCenterYWithView:_lblEndTime predicate:nil];
        [_btnEndTime constrainLeadingSpaceToView:_lblEndTime predicate:@"5"];
        
        //
        _lblRechargeType = [UILabel new];
        _lblRechargeType.font = [TDFontLibrary sharedInstance].fontNormal;
        _lblRechargeType.text = @"充值方式:";
        [bgView addSubview:_lblRechargeType];
        [_lblRechargeType constrainTopSpaceToView:_lblEndTime predicate:@"8"];
        [_lblRechargeType alignLeadingEdgeWithView:_lblEndTime predicate:nil];
        
        _btnRechargeByPos = [TDUtil checkBoxWithTitle:@"POS充值" target:self action:@selector(rechargeTypeChanged:)];
        _btnRechargeByPos.selected = YES;
        [bgView addSubview:_btnRechargeByPos];
        [_btnRechargeByPos alignCenterYWithView:_lblRechargeType predicate:nil];
        [_btnRechargeByPos constrainLeadingSpaceToView:_lblRechargeType predicate:@"20"];
        [_btnRechargeByPos constrainWidth:@"100"];
        
        _btnRechargeOnline = [TDUtil checkBoxWithTitle:@"在线充值" target:self action:@selector(rechargeTypeChanged:)];
        [bgView addSubview:_btnRechargeOnline];
        _btnRechargeOnline.tag = 1;
        [_btnRechargeOnline alignCenterYWithView:_btnRechargeByPos predicate:nil];
        [_btnRechargeOnline constrainLeadingSpaceToView:_btnRechargeByPos predicate:@"5"];
        [_btnRechargeOnline constrainWidth:@"100"];
    }
    
    return header;
}

-(void)rechargeTypeChanged:(UIView *)sender {
    BOOL rechargeOnline = sender.tag;
    _btnRechargeByPos.selected = !rechargeOnline;
    _btnRechargeOnline.selected = rechargeOnline;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 140;
}

#pragma mark - action
-(void)addMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = YES;
    
    [_tv reloadData];
}

-(void)useMoneyRecordAction:(id)sender {
    _showAddMoneyRecord = NO;
    
    [_tv reloadData];
}

-(void)pickStartTime:(id)sender {
    _isPickingStartTime = YES;
    
    _constraintPickerSpaceFromBottom.constant = 0;
    [UIView animateWithDuration:.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)pickEndTime:(id)sender {
    _isPickingStartTime = NO;
    
    _constraintPickerSpaceFromBottom.constant = 0;
    [UIView animateWithDuration:.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)pickOKAction:(id)sender {
    
    if (_isPickingStartTime) {
        _startDate = _pickerTime.date;
    } else {
        _endDate = _pickerTime.date;
    }
    
    [self updateTimeTexts];
    
    _constraintPickerSpaceFromBottom.constant = PICKER_HEIGHT;
    [UIView animateWithDuration:.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)updateTimeTexts {
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [formatter stringFromDate:_startDate];
    [_btnStartTime setTitle:dateStr forState:UIControlStateNormal];
    
    dateStr = [formatter stringFromDate:_endDate];
    [_btnEndTime setTitle:dateStr forState:UIControlStateNormal];
}

-(void)pickCancelAction:(id)sender {
    _constraintPickerSpaceFromBottom.constant = PICKER_HEIGHT;
    [UIView animateWithDuration:.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

@end
