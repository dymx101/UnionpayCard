//
//  TDSettingsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSettingsVC.h"
#import "TDSettingCell.h"
#import "httpRequest.h"
#import "TDJsonToDictionary.h"
#import "OTSDataView.h"
#import "OTSAlert.h"
#import "GNWebVC.h"

#define ALERTVIEW_TAG_UPDATE  2    //更新
#define ALERTVIEW_TAG_NO_UPDATE  3   //不更新

@interface TDSettingsVC () <UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate> {
    UITableView     *_tvSettings;
}

@property(nonatomic,strong) NSDictionary * download;
@property(nonatomic, strong) OTSDataAlertView *safeAlertView;//当前vc弹出的alert view，这里记录它是为了在vc释放时将其delegate置空，防止闪退
@end


@implementation TDSettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"更多";
    
    [self installLogoToNavibar];
    
    [self createViews];
    [self layoutViews];
    
    [self observeNotification:OTS_ALERT_ENSURE];
}

-(NSArray *)settingItems {
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:@[@"清空缓存"]];
    [items addObject:@[@"检查更新", @"关于朋派"]];
    
    return items;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    ETDCellStyle cellStyle = [TDUtil cellStyleWithIndexPath:indexPath tableView:tableView tableViewDataSource:self];
    [cell setStyle:cellStyle];
    cell.lblTitle.text = [self settingItems][section][row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDSettingCell HEIGHT];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self clearCacheAction];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:HUD];
                    [HUD show:YES];
                    NSDictionary  * strParamDic = @{@"method":@"canUpdate"};
                    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
                    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
                        [HUD hide:YES];
                        if(responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]){
                            self.download = (NSDictionary *) responseObject;
                            if (self.download && [[self.download objectForKey:@"canUpdate"] intValue] == 1 && [self.download objectForKey:@"downloadUrl"] !=nil
                                ) {
                                self.safeAlertView = [[OTSAlert sharedInstance] alert:[self.download objectForKey:@"remark"] title:@"有可用的新版本" leftBtn:@"取消" rightBtn:@"更新" delegate:self];
                                [self.safeAlertView setTag:ALERTVIEW_TAG_UPDATE];
                            } else {
                                self.safeAlertView = [[OTSAlert sharedInstance] alert:@"您当前使用的已经是最新版的朋派生活客户端,感谢您对朋派网的支持!" title:@"更新提示" leftBtn:@"确定" rightBtn:nil delegate:self];
                                [self.safeAlertView setTag:ALERTVIEW_TAG_NO_UPDATE];
                            }
                            [self.safeAlertView show];
                        }
                    }];
                }
                    break;
                case 1:
                {
                    GNWebVC *webvc = [GNWebVC new];
                    webvc.title = @"关于朋派";
                    webvc.urlStr = @"http://www.ponpay.com/gypp.php";
                    [self.navigationController pushViewController:webvc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

//清除缓存
-(void)clearCacheAction
{
    UIActionSheet *shit = [[UIActionSheet alloc] initWithTitle:@"确定要清除缓存图片？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"确定", nil];
    shit.tag=123456;
    [shit showInView:[UIApplication sharedApplication].keyWindow];
}

/**
 *  功能:清除缓存
 */
-(void)doClear
{
    //    [[SDDataCache sharedDataCache] clearMemory];
    //    [[SDDataCache sharedDataCache] clearDisk];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showStringWithCustomViewHUD:@"清除成功" second:1];
}

/**
 *  功能:显示图片，字符串hud几秒钟时间
 */
- (void)showStringWithCustomViewHUD:(NSString *)aMessage second:(int)aSecond
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"set_add_icon"]];
    imageView.frame=CGRectMake(0, 0, 37, 37);
    hud.customView=imageView;
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.labelText=aMessage;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:aSecond];
}

/**
 *  功能:隐藏hud
 */
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 123456: //清除缓存
            switch (buttonIndex) {
                case 0:
                {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeIndeterminate;
                    hud.labelText = @"正在清除";
                    [self performSelector:@selector(doClear) withObject:nil afterDelay:2.0f];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        case 1234567://联系客服
            switch (buttonIndex) {
                case 0: {
                    
                    break;
                }
                default:
                    break;
            }
        default:
            break;
    }
    
}

#pragma mark alertview相关
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case ALERTVIEW_TAG_UPDATE://更新
            if (buttonIndex==1) {
                
                [self toAppStoreDownload]; //去AppStore更新
            }
            break;
        case ALERTVIEW_TAG_NO_UPDATE://不更新
            break;
        default:
            break;
    }
}

/**
 *  功能:跳转到AppStore下载
 */
-(void)toAppStoreDownload
{
    NSString *tempStr=[[NSString alloc] safeInitWithString:[self.download objectForKey:@"downloadUrl"]];
    NSString *url=[tempStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *iTunesUrl=[NSURL URLWithString:url] ;
    [[UIApplication	sharedApplication] openURL:iTunesUrl];
    
}


@end
