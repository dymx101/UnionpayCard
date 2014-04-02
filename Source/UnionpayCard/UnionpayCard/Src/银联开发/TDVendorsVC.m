//
//  TDVendorsVC.m
//  UnionpayCard
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDVendorsVC.h"
#import <QuartzCore/QuartzCore.h>
#import "TDVendorsCell.h"
#import "httpRequest.h"
#import "TDJsonToDictionary.h"
#import "TDBusinessDetailVC.h"
@interface TDVendorsVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TDVendorsCellDelegate>{
    UITableView  * classifyTable;
    UITableView  * businessTable;
    NSMutableDictionary  * classifyDic;
    NSArray      * classifyNameArr;
    NSArray      * businessArr;
    NSMutableDictionary  * imageDic;
    NSInteger      currPage;
}
@property(nonatomic,strong)IBOutlet  UIView  * headView;
@property(nonatomic,strong)IBOutlet  UIButton * allTypeBtn;
@property(nonatomic,strong)IBOutlet  UITextField * searchText;
@property(nonatomic,strong)IBOutlet  UIView   * searchBgView;
@property(nonatomic,strong)IBOutlet  UILabel  * classifyNameLab;
-(IBAction)typeBtnClick:(UIButton*)btn;
-(IBAction)exitKeyBoard:(UITextField*)sender;
@end

@implementation TDVendorsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"商户浏览";
        classifyDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestClassifyData];
    _headView.frame = CGRectMake(0.0,0.0,KSCREEN_WIDTH,30);
    [self.view addSubview:_headView];
    CGRect  searchframe = _searchText.frame;
    searchframe.origin.y = 0.0;
    searchframe.size.height = 22.0;
    _searchText.frame = searchframe;
    _searchText.delegate = self;
    _searchBgView.layer.cornerRadius = 10.0;
    UIImageView  * leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 15.0, 15.0)];
    leftView.image = [UIImage imageNamed:@"icon_search_glass@2x"];
    _searchText.leftView = leftView;
    _searchText.leftViewMode = UITextFieldViewModeAlways;
    
    //创建商家列表
    CGRect tempRect = _headView.frame;
    CGFloat  tableHeight;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0){
        tableHeight = KSCREEN_HEIGHT - tempRect.size.height - 50.0 - 44.0 - 20;
    }else{
        tableHeight = KSCREEN_HEIGHT - tempRect.size.height - 50.0 - 44.0;
    }
    businessTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0,tempRect.origin.y + tempRect.size.height,KSCREEN_WIDTH, tableHeight) style:UITableViewStylePlain];
    businessTable.delegate = self;
    businessTable.dataSource = self;
    if([businessTable respondsToSelector:@selector(setSeparatorInset:)]){
        [businessTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:businessTable];
     NSDictionary  * strParamDic = @{@"method":@"ShowBinfor",@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
    [self requestBusinessData:strParamDic];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)hideClassifyTable{
    [UIView animateWithDuration:.2 animations:^{
        classifyTable.frame = CGRectMake(0.0, _headView.frame.size.height, 100.0, 0.0);
        [classifyTable removeFromSuperview];
        classifyTable = nil;
    }];
}
#pragma mark - httpRequest
-(void)requestRemainSumData:(NSDictionary *)dic indexPath:(NSIndexPath*)indexPath{
    
    NSDictionary  * strParamDic = @{@"method":@"ShowUtocard",@"userToken":SharedToken,@"u_card":[dic objectForKey:@"b_prefix"],@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
    NSString * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            TDVendorsCell * cell = (TDVendorsCell*)[businessTable cellForRowAtIndexPath:indexPath];
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSArray       * tempArr = [tempDic objectForKey:@"showtable"];
            NSDictionary  * tDic = [tempArr objectAtIndex:0];
            NSString  * strRemainSum = [tDic objectForKey:@"card_balance"];
            cell.remainSumLab.text = strRemainSum;
        }
    }];
}
-(void)requestClassifyData{
    NSDictionary  * strParamDic = @{@"method":@"showBtype"};
    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSArray       * tempArr = [tempDic objectForKey:@"showtable"];
            for (NSDictionary  *dic in tempArr) {
                [classifyDic setObject:[dic objectForKey:@"b_t_id"] forKey:[dic objectForKey:@"b_type_name"]];
            }
            classifyNameArr = [classifyDic allKeys];
        }else{
            [self.view makeToast:@"获取一级分类数据失败"];
        }
    }];
}
-(void)requestBusinessData:(NSDictionary*)strParamDic{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            businessArr = [tempDic objectForKey:@"showtable"];
            [businessTable reloadData];
        }else{
            if(businessArr.count){
                [self.view makeToast:@"获取商户列表数据失败"];
            }else{
                [self.view makeToast:@"已加载完所有商户数据"];
            }
        }
        [HUD hide:YES];
    }];
}
-(BOOL)checkUserCanApply:(NSDictionary*)dic indexPath:(NSIndexPath*)indexPath{
    BOOL result = YES;
    NSLog(@"> %@",SharedToken);
    NSDictionary  * strParamDic = @{@"method":@"countcard",@"b_id":[dic objectForKey:@"b_id"],@"userToken":SharedToken};
    NSString      * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSString  * strResult = [tempDic objectForKey:@"State"];
            TDVendorsCell * cell = (TDVendorsCell*)[businessTable cellForRowAtIndexPath:indexPath];
            if([strResult intValue] == 1){
                [self requestRemainSumData:dic indexPath:indexPath];
                [cell hide];
            }else if([strResult intValue] == 0){
                [cell show];
            }else{
                [self.view makeToast:@"数据错误"];
            }
        }
    }];
    return result;
}
#pragma mark -btnclick
-(IBAction)typeBtnClick:(UIButton*)btn{
    if(classifyDic.count){
        if(classifyTable == Nil){
            classifyTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0, _headView.frame.size.height, 100.0, 0.0) style:UITableViewStylePlain];
            classifyTable.delegate = self;
            classifyTable.dataSource = self;
            [classifyTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            if([classifyTable respondsToSelector:@selector(setSeparatorInset:)]){
                [classifyTable setSeparatorInset:UIEdgeInsetsZero];
            }
            [self.view addSubview:classifyTable];
            [UIView animateWithDuration:0.2 animations:^{
                classifyTable.frame = CGRectMake(0.0, _headView.frame.size.height, 100.0, businessTable.frame.size.height);
            }];
        }
    }else{
        [self.view makeToast:@"正在请求一级分类数据请稍等"];
    }
}
-(IBAction)exitKeyBoard:(UITextField*)sender{
    [sender resignFirstResponder];
}
-(void)clickTableHeader:(UIButton*)btn{
    [self hideClassifyTable];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.text = @"武汉银科技";
    if(textField.text == nil || [textField.text isEqualToString:@""]){
        [self.view makeToast:@"商户名不能为空"];
    }else{
        NSDictionary  * strParamDic = @{@"method":@"ShowBinfor",@"b_jname":textField.text,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
        [self requestBusinessData:strParamDic];
    }
    return YES;
}
#pragma mark - TDVendorsCellDelegate
-(void)clickApply:(NSInteger)index{
    NSString  * strId = [[businessArr objectAtIndex:index] objectForKey:@"b_id"];
    NSDictionary * strParamDic = @{@"method":@"Regcard",@"b_id":strId,@"userToken":SharedToken};
    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSString  *strResult = [tempDic objectForKey:@"State"];
            if([strResult isEqualToString:@"error"]){
                [self.view makeToast:@"申请失败"];
            }else if([strResult intValue] == 0){
                [self.view makeToast:@"申请成功"];
            }else if([strResult intValue] == 1){
                [self.view makeToast:@"已经申请了一张卡"];
            }else{
                [self.view makeToast:@"未知异常"];
            }
        }
    }];
}
#pragma mark - table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger  numRow = 0;
    if([tableView isEqual:classifyTable]){
        numRow = classifyNameArr.count;
    }else if([tableView isEqual:businessTable]){
        numRow = businessArr.count;
    }
    return numRow;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString * strIndx = @"TDVendorsCell";
    NSInteger  row = indexPath.row;
    if([tableView isEqual:businessTable]){
        TDVendorsCell  * cell = [tableView dequeueReusableCellWithIdentifier:strIndx];
        if(!cell){
            cell = [[TDVendorsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndx];
        }
        cell.delegate = self;
        NSDictionary  * tempDic = [businessArr objectAtIndex:row];
        [self checkUserCanApply:tempDic indexPath:indexPath];
        [cell displayCell:tempDic index:row];
        return cell;
    }else if([tableView isEqual:classifyTable]){
        UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:strIndx];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndx];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.text = [classifyNameArr objectAtIndex:row];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:classifyTable]){
        return 30;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 30.0)];
    view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:251.0/255.0 blue:231.0/255.0 alpha:1.0];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 5.0, 20.0, 20.0)];
    imgView.image = [UIImage imageNamed:@"icon_drag"];
    [view addSubview:imgView];
    UILabel  * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(37.0, 4.0, 57.0, 21.0)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:12.0];
    titleLab.text = @"全部分类";
    [view addSubview:titleLab];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0.0, 0.0, view.frame.size.width, 30.0) ;
    [btn addTarget:self action:@selector(clickTableHeader:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger  index = indexPath.row;
    UITableViewCell  * cell = [tableView cellForRowAtIndexPath:indexPath];
    if([tableView isEqual:classifyTable]){
        NSNumber *b_id = [classifyDic   objectForKey:cell.textLabel.text];
        [self hideClassifyTable];
        _classifyNameLab.text = [classifyNameArr objectAtIndex:index];
        NSDictionary  * strParamDic = @{@"method":@"ShowBinfor",@"b_type":[NSString stringWithFormat:@"%@",b_id],@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
        [self requestBusinessData:strParamDic];
        
    }else{
        TDVendorsCell  * cell = (TDVendorsCell*)[tableView cellForRowAtIndexPath:indexPath];
        NSDictionary  * tempDic = [businessArr objectAtIndex:index];
        TDBusinessDetailVC * vc = [[TDBusinessDetailVC alloc]init];
        vc.strImageName = [tempDic objectForKey:@"b_img"];
        vc.strTitle = [tempDic objectForKey:@"b_jname"];
        vc.strDetail = [tempDic objectForKey:@"b_ad"];
        vc.strZCount = [tempDic objectForKey:@"cord_num"];
        vc.isShowApplyBtn = cell.applyBtn.hidden;
        vc.strBusinessDetail = [tempDic objectForKey:@"b_details"];
        vc.strFullDetail = [tempDic objectForKey:@"b_recharge"];
        vc.isRemainSum = cell.remainSumLab.hidden;
        vc.strRemainSum = cell.remainSumLab.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:businessTable]){
        return 82.0;
    }else if([tableView isEqual:classifyTable]){
        return 40.0;
    }
    return 0;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 20)){
        currPage ++;
        if(self.searchText.text != nil && [self.searchText.text isEqualToString:@""]){
            NSDictionary  * strParamDic = @{@"method":@"ShowBinfor",@"b_jname":self.searchText.text,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
            [self requestBusinessData:strParamDic];
        }else{
            NSDictionary  * strParamDic = @{@"method":@"ShowBinfor",@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
            [self requestBusinessData:strParamDic];
        }
    }
}
@end
