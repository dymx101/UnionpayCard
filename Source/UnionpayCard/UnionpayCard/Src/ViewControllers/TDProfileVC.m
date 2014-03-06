//
//  TDProfileVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDProfileVC.h"
#import "TDLoginVC.h"
#import "Userinfor.h"
#import "TDMyAccountVC.h"
#import "TDSettingCell.h"

@interface TDProfileVC () <UITableViewDelegate, UITableViewDataSource,TDLoginVCDelegate> {
    UITableView             *_tv;
    UIView                  *_viewNotLoggedIn;
    
    UIView                  *_viewLoggedIn;
    UILabel                 *_lblUserName;
    UIImageView             *_ivVip;
    UILabel                 *_lblBalance;
    UIButton                *_btnRightArrow;
}
@property (nonatomic,strong)     UIView                 *_headerView;
@property (nonatomic,strong)     Userinfor              *_mUser;

@end

@implementation TDProfileVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    [self createSubviews];
    [self layoutSubviews];
    
    [self installLogoToNavibar];
}

-(NSArray *)settingItems {
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:@[@"充值记录", @"消费记录"]];
    [items addObject:@[@"我的收藏", @"我的代金券"]];
    
    return items;
}

-(void)createSubviews {
    
    _tv = [UITableView new];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tv];
}

-(void)layoutSubviews {
    _tv.backgroundColor = [FDColor sharedInstance].clear;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tv alignToView:self.view];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section != 0) {
        return nil;
    }
    
    __headerView = [UIView new];
    UIImageView *ivBg = [[UIImageView alloc] initWithImage:[TDImageLibrary sharedInstance].mineAccountBg];
    [__headerView addSubview:ivBg];
    
    [ivBg alignTop:@"0" leading:@"0" bottom:@"-20" trailing:@"0" toView:__headerView];
    
    // view not logged in
    _viewNotLoggedIn = [UIView new];
    [__headerView addSubview:_viewNotLoggedIn];
    [_viewNotLoggedIn alignToView:__headerView];
    
    // label not logged in
    UILabel *lblNotLoggedIn = [UILabel new];
    lblNotLoggedIn.text = @"您还没有登录哦～";
    lblNotLoggedIn.font = [TDFontLibrary sharedInstance].fontNormal;
    lblNotLoggedIn.textColor = [FDColor sharedInstance].darkGray;
    [_viewNotLoggedIn addSubview:lblNotLoggedIn];
    [lblNotLoggedIn alignCenterXWithView:_viewNotLoggedIn predicate:nil];
    [lblNotLoggedIn alignTopEdgeWithView:_viewNotLoggedIn predicate:@"10"];
    
    // button log in
    UIButton *btnLogin = [UIButton new];
    [btnLogin setBackgroundImage:[TDImageLibrary sharedInstance].btnBgWhite forState:UIControlStateNormal];
    [btnLogin setTitle:@"马上登录" forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [btnLogin setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewNotLoggedIn addSubview:btnLogin];
    [btnLogin alignCenterXWithView:_viewNotLoggedIn predicate:nil];
    [btnLogin constrainTopSpaceToView:lblNotLoggedIn predicate:@"5"];
    [btnLogin constrainWidth:@"100"];
    
    
    // view logged in
    _viewLoggedIn = [UIView new];
    //_viewLoggedIn.backgroundColor = [UIColor redColor];
    [__headerView addSubview:_viewLoggedIn];
    _viewLoggedIn.hidden = YES;
    [_viewLoggedIn alignToView:__headerView];
    
    [_viewLoggedIn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAccountAction:)]];
    
    //
    _lblUserName = [UILabel new];
    _lblUserName.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblUserName.text = @"霍比特人";
    [_viewLoggedIn addSubview:_lblUserName];
    
    [_lblUserName alignTop:@"25" leading:@"30" toView:_viewLoggedIn];
    
    //
    _ivVip = [UIImageView new];
    _ivVip.image = [UIImage imageNamed:@"icon_mine_level2user"];
    [_viewLoggedIn addSubview:_ivVip];
    
    [_ivVip alignCenterYWithView:_lblUserName predicate:nil];
    [_ivVip constrainLeadingSpaceToView:_lblUserName predicate:@"8"];
    
    //
    _lblBalance = [UILabel new];
    _lblBalance.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblBalance.textColor = [FDColor sharedInstance].gray;
    _lblBalance.text = @"余额: ￥500.00";
    [_viewLoggedIn addSubview:_lblBalance];
    
    [_lblBalance constrainTopSpaceToView:_lblUserName predicate:@"10"];
    [_lblBalance alignLeadingEdgeWithView:_lblUserName predicate:nil];
    
    //
    _btnRightArrow = [UIButton new];
    [_btnRightArrow setImage:[UIImage imageNamed:@"icon_deal_arrow"] forState:UIControlStateNormal];
    //[_btnRightArrow addTarget:self action:@selector(viewAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewLoggedIn addSubview:_btnRightArrow];
    
    [_btnRightArrow alignCenterYWithView:_viewLoggedIn predicate:nil];
    [_btnRightArrow alignTrailingEdgeWithView:_viewLoggedIn predicate:@"-30"];
    
    return __headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 20;
    }
    
    return [TDImageLibrary sharedInstance].mineAccountBg.size.height + 20;
}

#pragma mark - 
-(void)loginAction:(id)sender {
    TDLoginVC *vc = [TDLoginVC new];
    vc.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)viewAccountAction:(id)sender {
    [self naviToVC:[TDMyAccountVC class]];
}

#pragma delegate - 
- (void) getProfile:(NSString *) tOken{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    __weak TDProfileVC * weakSelf = self;
    [HUD showAnimated:YES whileExecutingBlock:^{
         [TDHttpService ShowcrrutUser:tOken completionBlock:^(id responseObject) {
             if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                 weakSelf._mUser = [responseObject lastObject];
                 BOOL loginOK = YES;
                 _viewLoggedIn.hidden = !loginOK;
                 _viewNotLoggedIn.hidden = loginOK;
                 _lblUserName.text = [__mUser u_name];
                 _lblBalance.text = [NSString stringWithFormat:@"余额: ￥%0.0f",[__mUser.u_rec_money doubleValue]];
             }
         }];
    } completionBlock:nil];
}
@end
