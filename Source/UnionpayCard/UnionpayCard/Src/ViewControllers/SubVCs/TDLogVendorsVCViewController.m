//
//  TDLogVendorsVCViewController.m
//  UnionpayCard
//
//  Created by WHC on 14-4-3.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDLogVendorsVCViewController.h"
#import "httpRequest.h"
#import "TDJsonToDictionary.h"
#import "Toast+UIView.h"
#import "TDVendorsVC.h"
@interface TDLogVendorsVCViewController (){
    UITableView   * cityTable;
    NSMutableDictionary  * contentDic;
    NSArray       *        cityNameArr;
    
}
@end

@implementation TDLogVendorsVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contentDic = [NSMutableDictionary dictionary];
        self.navigationItem.title = @"城市";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat  tableHeight = 0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0){
        tableHeight = KSCREEN_HEIGHT - 50.0 - 44.0 - 20;
    }else{
        tableHeight = KSCREEN_HEIGHT - 50.0 - 44.0;
    }
    cityTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, KSCREEN_WIDTH, tableHeight) style:UITableViewStylePlain];
    cityTable.delegate = self;
    cityTable.dataSource = self;
    [self.view addSubview:cityTable];
    [self requestCityData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - httpRequest
-(void)requestCityData{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    NSDictionary  * strParamDic = @{@"method":@"showBcity"};
    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSArray       * tempArr = [tempDic objectForKey:@"showtable"];
            for (NSDictionary  *dic in tempArr) {
                [contentDic setObject:[dic objectForKey:@"b_c_id"] forKey:[dic objectForKey:@"b_c_name"]];
            }
            cityNameArr = [contentDic allKeys];
            if(tempArr.count){
                [cityTable reloadData];
            }else{
                [self.view makeToast:@"获取城市数据失败"];
            }
            [HUD hide:YES];
        }else{
            [HUD hide:YES];
            [self.view makeToast:@"获取城市数据失败"];
        }
    }];

}
#pragma mark - table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cityNameArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    static  NSString * indx = @"cell";
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:indx];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indx];
    }
    cell.backgroundColor = [UIColor colorWithRed:40.0/255.0 green:139.0/255.0 blue:226.0/255.0 alpha:.5];
    cell.textLabel.text = [cityNameArr objectAtIndex:index];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView  * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10)];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger  index = indexPath.row;
    TDVendorsVC  * vc = [[TDVendorsVC alloc]init];
    vc.strBC_ID = [contentDic objectForKey:[cityNameArr objectAtIndex:index]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}
@end
