//
//  TDBaseVC.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDBaseVC : UIViewController
-(void)installLogoToNavibar;
-(void)installMapAndSearchToNavibar;
-(void)installBackArrowToNavibar;

-(void)naviToVC:(Class)aClass;

@end
