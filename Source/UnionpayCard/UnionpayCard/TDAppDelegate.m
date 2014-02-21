//
//  TDAppDelegate.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDAppDelegate.h"
#import "RDVTabBarItem.h"

#import "TDHomeVC.h"
#import "TDMerchantsVC.h"
#import "TDProfileVC.h"
#import "TDSettingsVC.h"

#import "TDAPIEngineTest.h"

@implementation TDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [TDHttpClient processCmd:[TDHttpCmd cmd] callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
//        NSLog(@">>%@",responseObject);
//    }];
    
    // create tab bar controller
    _tabbarController = [RDVTabBarController new];
    NSArray *viewControllers = @[[self ncWithVC:[TDHomeVC new]]
                                 , [self ncWithVC:[TDMerchantsVC new]]
                                 , [self ncWithVC:[TDProfileVC new]]
                                 , [self ncWithVC:[TDSettingsVC new]]];
    _tabbarController.viewControllers = viewControllers;
    [self customizeTabBarForController:_tabbarController];
    
    _window.rootViewController = _tabbarController;
    
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self customizeInterface];
    
    [TDAPIEngineTest run];
    
    [TDUtil findFonts];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    UIImage *unfinishedImage = finishedImage;//[UIImage imageNamed:@"tabbar_normal_background"];
    
    NSDictionary *selectedTitleAttributes = @{UITextAttributeFont : [UIFont systemFontOfSize:12.f],
                                              UITextAttributeTextColor : [UIColor blackColor]};
    NSDictionary *unselectedTitleAttributes = @{UITextAttributeFont : [UIFont systemFontOfSize:12.f],
                                              UITextAttributeTextColor : [UIColor grayColor]};
    
    [tabBarController.tabBar setHeight:60];
    //tabBarController.tabBar.backgroundView.image = [UIImage imageNamed:@"bg_tabbar"];
    //tabBarController.tabBar.contentEdgeInsets = UIEdgeInsetsMake(-10, 10, 10, 10);
    NSArray *tabItems = tabBarController.tabBar.items;
    for (RDVTabBarItem *item in tabItems) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
    }
    
    UIImage *normalImage = [UIImage imageNamed:@"icon_tabbar_homepage.png"];
    UIImage *selectedImage = [UIImage imageNamed:@"icon_tabbar_homepage_selected.png"];
    RDVTabBarItem *item = tabItems[0];

    [item setTitle:@"首页"];
    item.selectedTitleAttributes = selectedTitleAttributes;
    item.unselectedTitleAttributes = unselectedTitleAttributes;
    [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
    
    normalImage = [UIImage imageNamed:@"icon_tabbar_merchant_normal.png"];
    selectedImage = [UIImage imageNamed:@"icon_tabbar_merchant_selected.png"];
    item = tabItems[1];
    [item setTitle:@"分类"];
    item.selectedTitleAttributes = selectedTitleAttributes;
    item.unselectedTitleAttributes = unselectedTitleAttributes;
    [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
    
    normalImage = [UIImage imageNamed:@"icon_tabbar_mine.png"];
    selectedImage = [UIImage imageNamed:@"icon_tabbar_mine_selected.png"];
    item = tabItems[2];
    [item setTitle:@"我的"];
    item.selectedTitleAttributes = selectedTitleAttributes;
    item.unselectedTitleAttributes = unselectedTitleAttributes;
    [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
    
    normalImage = [UIImage imageNamed:@"icon_tabbar_misc.png"];
    selectedImage = [UIImage imageNamed:@"icon_tabbar_misc_selected.png"];
    item = tabItems[3];
    [item setTitle:@"更多"];
    item.selectedTitleAttributes = selectedTitleAttributes;
    item.unselectedTitleAttributes = unselectedTitleAttributes;
    [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
}

-(UINavigationController *)ncWithVC:(UIViewController *)aVC {
    if (aVC) {
        return [[UINavigationController alloc] initWithRootViewController:aVC];
    }
    
    return nil;
}


- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.titleTextAttributes = [self naviBarAttributes];
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_tall"]
                                      forBarMetrics:UIBarMetricsDefault];
    } else {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar"]
                                      forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *textAttributes = nil;
        
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            textAttributes = @{
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                               NSForegroundColorAttributeName: [UIColor blackColor],
                               };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            textAttributes = @{
                               UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                               UITextAttributeTextColor: [UIColor blackColor],
                               UITextAttributeTextShadowColor: [UIColor clearColor],
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
#endif
        }
        
        [navigationBarAppearance setTitleTextAttributes:textAttributes];
    }
}

-(NSMutableDictionary *)naviBarAttributes {
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [attributes setValue:[UIColor darkGrayColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 1)] forKey:UITextAttributeTextShadowOffset];
    //[attributes setValue:[TDFontLibrary sharedInstance].fontTileButton forKey:UITextAttributeFont];
    return attributes;
}

@end
