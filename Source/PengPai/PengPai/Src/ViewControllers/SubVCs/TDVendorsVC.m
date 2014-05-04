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
#import "TDClassifyTableCell.h"
@interface TDVendorsVC (){
    UITableView  * classifyTable;
    UITableView  * businessTable;
    NSMutableDictionary  * classifyDic;
    NSArray      * classifyNameArr;
    NSArray      * businessArr;
    NSMutableDictionary  * imageDic;
    NSInteger      currPage;
    BOOL           isUP;
    BOOL           isDwon;
    BOOL           isSelectedClassisfy;
    NSArray      * normalImageArr;
    NSArray      * selectedImageArr;
    NSInteger      selectedClassifyRow;
    UIView       * bgView;
    
    NSNumber     * currType;
}
@property(nonatomic,strong)IBOutlet  UIView  * headView;
@property(nonatomic,strong)IBOutlet  UIButton * allTypeBtn;
@property(nonatomic,strong)IBOutlet  UISearchBar * searchBar;
@property(nonatomic,strong)IBOutlet  UILabel  * classifyNameLab;
-(IBAction)typeBtnClick:(UIButton*)btn;
@end

@implementation TDVendorsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectedClassifyRow = 0;
        self.navigationItem.title = @"商户浏览";
        classifyDic = [NSMutableDictionary dictionary];
        normalImageArr = @[[UIImage imageNamed:@"icon_cate_normal_-1"],
                           [UIImage imageNamed:@"icon_cate_normal_3"],
                           [UIImage imageNamed:@"icon_cate_normal_99"],
                           [UIImage imageNamed:@"icon_cate_normal_1"],
                           [UIImage imageNamed:@"icon_cate_normal_22"],
                           [UIImage imageNamed:@"icon_cate_normal_4"],
                           [UIImage imageNamed:@"icon_cate_normal_0"],
                           [UIImage imageNamed:@"icon_cate_normal_20"]];
        selectedImageArr = @[[UIImage imageNamed:@"icon_cate_selected_-1"],
                           [UIImage imageNamed:@"icon_cate_selected_3"],
                           [UIImage imageNamed:@"icon_cate_selected_99"],
                           [UIImage imageNamed:@"icon_cate_selected_1"],
                           [UIImage imageNamed:@"icon_cate_selected_22"],
                           [UIImage imageNamed:@"icon_cate_selected_4"],
                           [UIImage imageNamed:@"icon_cate_selected_0"],
                           [UIImage imageNamed:@"icon_cate_selected_20"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestClassifyData];
    _headView.frame = CGRectMake(0.0,0.0,KSCREEN_WIDTH,44.0);
    _headView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    [self.view addSubview:_headView];
    _searchBar.delegate = self;
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
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
    bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.view addSubview:bgView];
    bgView.hidden = YES;
    UITapGestureRecognizer  * sigleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigleTouchBgView)];
    [bgView addGestureRecognizer:sigleTap];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary  * strParamDic;
    if([self isLogin]){
        strParamDic = @{@"method":@"ShowBinfor",@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID,@"userToken":SharedToken};
    }else{
        strParamDic = @{@"method":@"ShowBinfor",@"b_city":_strBC_ID,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
    }
    [self requestBusinessData:strParamDic];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sigleTouchBgView{
    [self hideClassifyTable];
}
-(BOOL)isLogin{
    BOOL result = YES;
    if(SharedToken == nil || [SharedToken isEqualToString:@""]){
        result = NO;
    }
    NSLog(@"token = %@",SharedToken);
    return result;
}
-(void)hideClassifyTable{
    [UIView animateWithDuration:.2 animations:^{
        bgView.hidden = YES;
        if(_searchBar.text.length > 0){
            [_searchBar resignFirstResponder];
            _searchBar.text = @"";
        }
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
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:classifyDic forKeyPath:@"One_Classify_Cache"];
            [ud synchronize];
        }else{
            classifyNameArr = [[[NSUserDefaults  standardUserDefaults]objectForKey:@"One_Classify_Cache"] allKeys];
//            [self.view makeToast:@"获取一级分类数据失败"];
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
            NSArray  * tempBusinessArr = [tempDic objectForKey:@"showtable"];
            if(tempBusinessArr == nil){
                tempBusinessArr = @[];
            }
            if(tempBusinessArr.count == 0){
                if(isSelectedClassisfy){
                    isSelectedClassisfy = NO;
                    businessArr = tempBusinessArr;
                    [businessTable reloadData];
                }else{
                    if(isUP){
                        isUP = NO;
                        currPage --;
                        [self.view makeToast:@"没有更多商户数据"];
                    }else if(isDwon){
                        isDwon = NO;
                        currPage ++;
                        [self.view makeToast:@"当前已经是第一页"];
                    }
                }
            }else{
                businessArr = tempBusinessArr;
                [businessTable reloadData];
            }
            
        }else{
            [self.view makeToast:@"获取商户列表数据失败"];
        }
        [HUD hide:YES];
    }];
}
-(BOOL)checkUserCanApply:(NSDictionary*)dic indexPath:(NSIndexPath*)indexPath{
    BOOL result = YES;
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
    bgView.hidden = NO;
    if(classifyDic.count){
        if(classifyTable == Nil){
            classifyTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0, _headView.frame.size.height, 120.0, 0.0) style:UITableViewStylePlain];
            classifyTable.delegate = self;
            classifyTable.dataSource = self;
            [classifyTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            if([classifyTable respondsToSelector:@selector(setSeparatorInset:)]){
                [classifyTable setSeparatorInset:UIEdgeInsetsZero];
            }
            [self.view addSubview:classifyTable];
            [UIView animateWithDuration:0.2 animations:^{
                classifyTable.frame = CGRectMake(0.0, _headView.frame.size.height, 120.0, businessTable.frame.size.height);
            }];
        }
    }else{
        [self.view makeToast:@"正在请求一级分类数据请稍等"];
    }
}
#pragma mark - TDVendorsCellDelegate
-(void)clickApply:(NSInteger)index cell:(UITableViewCell*)cell{
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
                [(TDVendorsCell*)cell hide];
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
        [cell displayCell:tempDic index:row];
        return cell;
    }else if([tableView isEqual:classifyTable]){
        TDClassifyTableCell  * cell = [tableView dequeueReusableCellWithIdentifier:strIndx];
        if(!cell){
            cell = [[TDClassifyTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndx];
        }
        if(row == 0){
            cell.titleLab.text = @"全部分类";
        }else{
            cell.titleLab.text = [classifyNameArr objectAtIndex:row - 1];
        }
        if(selectedClassifyRow == row){
            cell.titleImageView.image = [selectedImageArr objectAtIndex:selectedClassifyRow];
            cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
        }else{
            cell.titleImageView.image = [normalImageArr objectAtIndex:row];
        }
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger  index = indexPath.row;
    if([tableView isEqual:classifyTable]){
        selectedClassifyRow = index;
        [self hideClassifyTable];
        isSelectedClassisfy = YES;
        NSDictionary  * strParamDic ;
        if(index == 0){
            currType = nil;
            _classifyNameLab.text = @"全部分类";
            if([self isLogin]){
                strParamDic = @{@"method":@"ShowBinfor",@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID,@"userToken":SharedToken};
            }else{
                strParamDic = @{@"method":@"ShowBinfor",@"b_city":_strBC_ID,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20"};
            }
        }else{
            currType = [classifyDic   objectForKey:[classifyNameArr objectAtIndex:index - 1]];
            _classifyNameLab.text = [classifyNameArr objectAtIndex:index - 1];
            if([self isLogin]){
                strParamDic = @{@"method":@"ShowBinfor",@"b_type":[NSString stringWithFormat:@"%@",currType],@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID,@"userToken":SharedToken};
            }else{
                strParamDic = @{@"method":@"ShowBinfor",@"b_type":[NSString stringWithFormat:@"%@",currType],@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID};
            }
        }
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
        vc.strB_id = [tempDic objectForKey:@"b_id"];
        vc.strBName = [tempDic objectForKey:@"b_name"];
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView  * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 10)];
    return view;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    BOOL  isRequest = NO;
    if([scrollView isEqual:businessTable]){
        if (scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height+20))){
            currPage ++;
            isUP = YES;
            isDwon = NO;
            isRequest = YES;
        }else if(scrollView.contentOffset.y < -35.0){
            if(currType <= 0){
                [self.view makeToast:@"当前已经是第一页"];
                return;
            }
            currPage --;
            isDwon = YES;
            isUP = NO;
            isRequest = YES;
        }
        if(isRequest){
            NSMutableDictionary  * strParamDic = [NSMutableDictionary dictionaryWithDictionary:@{@"method":@"ShowBinfor",@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID}];
            if([self isLogin]){
                [strParamDic setObject:SharedToken forKey:@"userToken"];
            }
            if(currType){
                [strParamDic setObject:[NSString stringWithFormat:@"%@",currType] forKey:@"b_type"];
            }
            [self requestBusinessData:strParamDic];
        }
    }
}
#pragma mark - search bar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (searchBar.text.length < 1) {
        searchBar.text = @" ";
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length < 1) {
        searchBar.text = @" ";
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range     replacementText:(NSString *)text{
    BOOL isPreviousTextDummyString = [searchBar.text isEqualToString:@" "];
    BOOL isNewTextDummyString = [text isEqualToString:@" "];
    if (isPreviousTextDummyString && !isNewTextDummyString && text.length > 0) {
        searchBar.text = @"";
    }
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if(searchBar.text == nil || [searchBar.text isEqualToString:@""]){
        [self.view makeToast:@"商户名不能为空"];
    }else{
        NSString  * strSearchContent = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if(strSearchContent != nil && ![strSearchContent isEqualToString:@""]){
            NSDictionary  * strParamDic ;
            if([self isLogin]){
                if(currType == nil){
                    strParamDic = @{@"method":@"ShowBinfor",@"b_jname":strSearchContent,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID,@"userToken":SharedToken};
                }else{
                     strParamDic = @{@"method":@"ShowBinfor",@"b_jname":strSearchContent,@"b_stat":@"0",@"b_type":currType == nil ? @"":[NSString stringWithFormat:@"%@",currType],@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID,@"userToken":SharedToken};
                }
            }else{
                if(currType == nil){
              strParamDic = @{@"method":@"ShowBinfor",@"b_jname":strSearchContent,@"b_stat":@"0",@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID};
            }else{
                strParamDic = @{@"method":@"ShowBinfor",@"b_jname":strSearchContent,@"b_stat":@"0",@"b_type":currType == nil ? @"":[NSString stringWithFormat:@"%@",currType],@"frist":(@(currPage)).stringValue,@"pageNum":@"20",@"b_city":_strBC_ID};
            }
        }
            [self requestBusinessData:strParamDic];
    }
 }
    searchBar.text = @"";
}
@end
