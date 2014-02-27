//
//  TDBaseVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseVC.h"

@interface TDBaseVC ()

@end

@implementation TDBaseVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [FDColor sharedInstance].silver;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // add logo to navigation bar
    if (self.navigationController.viewControllers.count > 1 && self == self.navigationController.topViewController) {
        [self installBackArrowToNavibar];
    }
}


-(void)dealloc {
    [self unobserveAllNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

-(void)installLogoToNavibar {
    UIImage *logoImg = [TDImageLibrary sharedInstance].logoName;
    UIImageView *ivLogo = [[UIImageView alloc] initWithImage:logoImg];
    float ratio = .5f;
    ivLogo.frame = CGRectMake(0, 0, logoImg.size.width * ratio, logoImg.size.height * ratio);
    UIBarButtonItem *itemLogo = [[UIBarButtonItem alloc] initWithCustomView:ivLogo];
    self.navigationItem.leftBarButtonItem = itemLogo;
}

-(void)installMapAndSearchToNavibar {
    UIImage *mapImg = [UIImage imageNamed:@"icon_map"];
    UIButton *btnMap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mapImg.size.width, mapImg.size.height)];
    [btnMap setImage:mapImg forState:UIControlStateNormal];
    UIBarButtonItem *mapItem = [[UIBarButtonItem alloc] initWithCustomView:btnMap];
    
    UIImage *searchImg = [UIImage imageNamed:@"icon_homepage_search"];
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, searchImg.size.width, searchImg.size.height)];
    [btnSearch setImage:searchImg forState:UIControlStateNormal];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:btnSearch];
    
    self.navigationItem.rightBarButtonItems = @[searchItem, mapItem];
}

-(void)installBackArrowToNavibar {
    UIImage *backImg = [TDImageLibrary sharedInstance].btnBackArrow;
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backImg.size.width, backImg.size.height)];
    [btnBack setImage:backImg forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(naviBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = itemBack;
    self.navigationItem.hidesBackButton = YES;
}

-(void)naviBackAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)naviToVC:(Class)aClass {
    if (aClass) {
        id obj = [aClass new];
        if ([obj isKindOfClass:[UIViewController class]]) {
            [self.navigationController pushViewController:(UIViewController *)obj animated:YES];
        }
    }
}

#pragma mark - HUD
/**
 *  功能:显示hud
 */
- (void)showHUD:(NSString *)aMessage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aMessage;
}

/**
 *  功能:隐藏hud
 */
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/**
 *  功能:显示字符串hud几秒钟时间
 */
- (void)showStringHUD:(NSString *)aMessage second:(int)aSecond
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.customString = aMessage;
//    hud.mode = MBProgressHUDModeNSString;
    
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:aSecond];
}

#pragma mark - Loading View
/**
 *  功能:显示loading
 */
- (void)showLoading
{
    [self showHUD:nil];
}

/**
 *  功能:隐藏loading
 */
- (void)hideLoading
{
    [self hideHUD];
}

@end
