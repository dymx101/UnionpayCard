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

@interface TDProfileVC () <UITableViewDelegate, UITableViewDataSource,TDLoginVCDelegate> {
    UITableView            *_tv;
}
@property (nonatomic,strong)     UIView                 *_headerView;

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
    
    __headerView = [UIView new];
    UIImageView *ivBg = [[UIImageView alloc] initWithImage:[TDImageLibrary sharedInstance].mineAccountBg];
    [__headerView addSubview:ivBg];
    
    [ivBg alignToView:__headerView];
    
    // view not logged in
    UIView *viewNotLoggedIn = [UIView new];
    [__headerView addSubview:viewNotLoggedIn];
    [viewNotLoggedIn alignToView:__headerView];
    
    // label not logged in
    UILabel *lblNotLoggedIn = [UILabel new];
    lblNotLoggedIn.text = @"您还没有登录哦～";
    lblNotLoggedIn.font = [TDFontLibrary sharedInstance].fontNormal;
    [viewNotLoggedIn addSubview:lblNotLoggedIn];
    [lblNotLoggedIn alignCenterXWithView:viewNotLoggedIn predicate:nil];
    [lblNotLoggedIn alignTopEdgeWithView:viewNotLoggedIn predicate:@"10"];
    
    // button log in
    UIButton *btnLogin = [UIButton new];
    [btnLogin setBackgroundImage:[TDImageLibrary sharedInstance].btnBgWhite forState:UIControlStateNormal];
    [btnLogin setTitle:@"马上登录" forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [btnLogin setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewNotLoggedIn addSubview:btnLogin];
    [btnLogin alignCenterXWithView:viewNotLoggedIn predicate:nil];
    [btnLogin constrainTopSpaceToView:lblNotLoggedIn predicate:@"5"];
    [btnLogin constrainWidth:@"100"];
    
    return __headerView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [TDImageLibrary sharedInstance].mineAccountBg.size.height;
}

#pragma mark - 
-(void)loginAction:(id)sender {
    TDLoginVC *vc = [TDLoginVC new];
    vc.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma delegate - 
- (void) getProfile:(NSString *) tOken{
    NSLog(@">>> %@",tOken);
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"努力装载中";
	HUD.color = [UIColor clearColor];
	HUD.square = YES;
    
    __block Userinfor * mUser = nil;
    [HUD showAnimated:YES whileExecutingBlock:^{
        NSMutableDictionary * input = [NSMutableDictionary new];
        [input setValue:@"ShowcrrutUser" forKey:@"method"];
        [input setValue:tOken forKey:@"userToken"];
        TDHttpCommand * command = [TDHttpCommand new];
        command.inPut = input;
        //命令模式调用
        [[TDHttpClient sharedClient] processCommand:command callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
            if (anError==nil && [responseObject isKindOfClass:[NSArray class]]) {
                mUser = responseObject;
            }
        }];
    } completionBlock:^{
        //刷新 UI 主线程
        
        UIImageView *ivBg = [[UIImageView alloc] initWithImage:[TDImageLibrary sharedInstance].mineAccountBg];
        [__headerView addSubview:ivBg];
        
        [ivBg alignToView:__headerView];
        
        // view not logged in
        UIView *viewNotLoggedIn = [UIView new];
        [__headerView addSubview:viewNotLoggedIn];
        [viewNotLoggedIn alignToView:__headerView];
        
        // label not logged in
        UILabel *lblNotLoggedIn = [UILabel new];
        lblNotLoggedIn.text = [mUser u_realname];
        lblNotLoggedIn.font = [TDFontLibrary sharedInstance].fontNormal;
        [viewNotLoggedIn addSubview:lblNotLoggedIn];
        [lblNotLoggedIn alignCenterXWithView:viewNotLoggedIn predicate:nil];
        [lblNotLoggedIn alignTopEdgeWithView:viewNotLoggedIn predicate:@"10"];
        
        [self.view addSubview:__headerView];
        
        
    }];
}
@end
