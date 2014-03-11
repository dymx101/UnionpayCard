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

@interface TDAddMoneyVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tv;
    UIButton        *_btnAddMoneyRec;
    UIButton        *_btnUseMoneyRec;
    
    BOOL            _showAddMoneyRecord;
    UIView          *header;
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
    
    __weak TDAddMoneyVC * weakSelf = self;
    
    __block NSString * token = nil;
    __block Userinfor * user = nil;
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService LoginUserinfor:@"songwei" loginPass:@"123456" completionBlock:^(id responseObject) {
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]) {
            token = [responseObject objectForKey:@"userToken"];
            [TDHttpService ShowcrrutUser:token completionBlock:^(id responseObject) {
                if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                    user = [responseObject lastObject];
                    weakSelf.userinfor = user;
                    NSString * userId = [NSString stringWithFormat:@"%d",[user.u_id intValue]];
                    [TDHttpService ShowConsumption:userId completionBlock:^(id responseObject) {
                        if (responseObject!=nil && [responseObject isKindOfClass:[NSArray class]]) {
                            weakSelf.Consumptions = responseObject;
                            [TDHttpService ShowPreRecords:userId completionBlock:^(id responseObject) {
                                [HUD hide:YES];
                                if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                                    weakSelf.PreRecords = responseObject;
                                    [self->_tv reloadData];
                                }
                            }];
                        }
                        else
                        {
                            [HUD hide:YES];
                        }
                    }];
                }
            }];
        }
    }];

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
    int numberofrows = 0;
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

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        _btnAddMoneyRec = [UIButton new];
        [_btnAddMoneyRec setTitle:@"充值记录" forState:UIControlStateNormal];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].themeBlue forState:UIControlStateHighlighted];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].gray forState:UIControlStateNormal];
        [_btnAddMoneyRec setTitleColor:[FDColor sharedInstance].black forState:UIControlStateSelected];
        _btnAddMoneyRec.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
        
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addMoneyRecordAction:)];
        //[_btnAddMoneyRec addGestureRecognizer:tap];
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
        
        // crash bug  is not this responds To
        //tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useMoneyRecordAction:)];
        //[_btnUseMoneyRec addGestureRecognizer:tap];
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
