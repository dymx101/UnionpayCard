//
//  TDHomeVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDHomeVC.h"

#import "TDCardListVC.h"
#import "TDVendorsVC.h"
#import "TDAddMoneyVC.h"
#import "TDCreditVC.h"
#import "TDCreditVC.h"
#import "TDConsumeVC.h"
#import "TDMailVC.h"
#import "TDLifeVC.h"
#import "TDRegisterVC.h"
#import "TDPhoneFeeVC.h"
#import "TDLoginVC.h"
#import "TDLogVendorsVCViewController.h"

typedef enum {
    kVcRegister = 1000
    , kVcCardList
    , kVcVendors
    , kVcAddMoney
    , kVcCredit
    , kVcConsume
    , kVcMail
    , kVcLife
    , kVcPhoneFee
}EVcType;



@interface TDHomeVC () <UIScrollViewDelegate> {
    UIScrollView            *_scrollView;
    NSMutableArray         *_tileButtons;
    
    UIPageControl           *_pageControl;
}

@end

@implementation TDHomeVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [FDColor sharedInstance].lightGray;
    _tileButtons = [NSMutableArray array];
    
    [self installLogoToNavibar];
    [self installMapAndSearchToNavibar];
	
    [self createSubviews];
    [self layout8Tiles];
    //[self layoutSubviews];
}



-(void)createSubviews {
    
    _scrollView = [UIScrollView new];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
//    _pageControl = [UIPageControl new];
//    _pageControl.numberOfPages = 2;
//    _pageControl.userInteractionEnabled = NO;
//    _pageControl.pageIndicatorTintColor = [FDColor sharedInstance].white;
//    _pageControl.currentPageIndicatorTintColor = [FDColor sharedInstance].caribbeanGreen;
//    [self.view addSubview:_pageControl];
    
    //
    UIButton *btnTile = [UIButton new];//[self tileButtonWithTitle:@"用户\n注册" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_vendor"] forState:UIControlStateNormal];
    btnTile.tag = kVcVendors;//kVcRegister;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"卡片\n管理" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_card_mgr"] forState:UIControlStateNormal];
    btnTile.tag = kVcCardList;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"商户\n浏览" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_add_money"] forState:UIControlStateNormal];
    btnTile.tag = kVcAddMoney;//kVcVendors;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"消费\n充值" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_credit"] forState:UIControlStateNormal];
    btnTile.tag = kVcCredit;//kVcAddMoney;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"积分\n活动" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_mail"] forState:UIControlStateNormal];
    btnTile.tag = kVcMail;//kVcCredit;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"消费\n预定" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_order"] forState:UIControlStateNormal];
    btnTile.tag = kVcConsume;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"邮件\n管理" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_phone"] forState:UIControlStateNormal];
    btnTile.tag = kVcPhoneFee;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [UIButton new];//[self tileButtonWithTitle:@"生活\n缴费" action:nil];
    [btnTile setImage:[UIImage imageNamed:@"tile_public"] forState:UIControlStateNormal];
    btnTile.tag = kVcLife;
    [btnTile addTarget:self action:@selector(tileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];

}

-(UIButton *)tileButtonWithTitle:(NSString *)aTitle action:(SEL)anAction {
    UIButton *btnTile = [UIButton new];
    btnTile.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    btnTile.titleLabel.textAlignment = NSTextAlignmentCenter;
    //[btnTile setBackgroundColor:aBgColor];
    [btnTile setBackgroundImage:[TDImageLibrary sharedInstance].btnBgOrange forState:UIControlStateNormal];
    [btnTile setTitle:aTitle forState:UIControlStateNormal];
    btnTile.titleLabel.font = [TDFontLibrary sharedInstance].fontTileButton;
    
    if (anAction != NULL) {
        [btnTile addTarget:self action:anAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btnTile;
}

-(void)tileButtonAction:(UIButton *)sender {
    int tag = sender.tag;
    switch (tag) {
        case kVcRegister:
            [self naviToVC:[TDRegisterVC class]];
            break;
            
        case kVcCardList: {
            if (SharedAppUser) {
                [self naviToVC:[TDCardListVC class]];
            } else {
                /** gotologin */
                TDLoginVC *vc = [TDLoginVC new];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nc animated:YES completion:nil];
            }
        }
            break;
            
        case kVcVendors:
                 [self naviToVC:[TDLogVendorsVCViewController class]];

            break;
            
        case kVcAddMoney:
            if (SharedAppUser) {
                [self naviToVC:[TDAddMoneyVC class]];
            } else {
                /** gotologin */
                TDLoginVC *vc = [TDLoginVC new];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nc animated:YES completion:nil];
            }
            break;
            
        case kVcCredit:
            [self naviToVC:[TDCreditVC class]];
            break;
            
        case kVcConsume:
            [self naviToVC:[TDConsumeVC class]];
            break;
            
        case kVcMail:
            [self naviToVC:[TDMailVC class]];
            break;
            
        case kVcLife:
            [self naviToVC:[TDLifeVC class]];
            break;
            
        case kVcPhoneFee:
            [self naviToVC:[TDPhoneFeeVC class]];
            break;
            
        default:
            break;
    }
}

#define PADDING_TOP              (20)
#define PADDING_Y               (20)
#define BUTTON_SIZE             (60)
#define BUTTON_OFFSET_X_CENTER  (50)
#define PAGE_WIDTH              (320)

-(void)layout8Tiles {
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView alignToView:self.view];
    
    NSArray *firstLineButtons = [_tileButtons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 4)]];
    NSArray *secondLineButtons = [_tileButtons objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 4)]];
    
    int i = 0;
    for (UIButton *btn in firstLineButtons) {
        [btn alignTopEdgeWithView:_scrollView predicate:@"20"];

        if (i == 0) {
            [btn alignLeadingEdgeWithView:_scrollView predicate:@"22"];
        }
        i ++;
    }
    [UIView spaceOutViewsHorizontally:firstLineButtons predicate:@"20"];
    
    i = 0;
    for (UIButton *btn in secondLineButtons) {
        [btn alignTopEdgeWithView:_scrollView predicate:@"90"];
        
        if (i == 0) {
            [btn alignLeadingEdgeWithView:_scrollView predicate:@"22"];
        }
        i ++;
    }
    [UIView spaceOutViewsHorizontally:secondLineButtons predicate:@"20"];

}

-(void)layoutSubviews {
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView alignToView:self.view];
    
    int btnCount = _tileButtons.count;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = _tileButtons[i];
        
        //int timesOfSix = i / 6;
        int numPerRow = 2;
        
        NSString *btnSize = (@(BUTTON_SIZE)).stringValue;
        [btn constrainWidth:btnSize height:btnSize];
        
        int offsetX = (i % numPerRow) ? BUTTON_OFFSET_X_CENTER : -BUTTON_OFFSET_X_CENTER;
        NSNumber *offsetCenterX = @(offsetX);//@(offsetX + PAGE_WIDTH * timesOfSix);
        [btn alignCenterXWithView:_scrollView predicate:offsetCenterX.stringValue];
        
        int factor = i;//i % 6;
        NSNumber *paddingTop = @(PADDING_TOP + PADDING_Y * (factor / numPerRow + 1) + (factor / numPerRow) * BUTTON_SIZE);
        [btn alignTopEdgeWithView:_scrollView predicate:paddingTop.stringValue];
        
        
        
        if (i == btnCount - 1) {
//            float paddingX = PAGE_WIDTH / 2 - BUTTON_OFFSET_X_CENTER - BUTTON_SIZE / 2;
//            [btn alignTrailingEdgeWithView:_scrollView predicate:(@(-paddingX)).stringValue];
            [btn alignBottomEdgeWithView:_scrollView predicate:@(-PADDING_TOP).stringValue];
        }
    }
    
//    [_pageControl alignCenterXWithView:self.view predicate:nil];
//    [_pageControl constrainWidthToView:self.view predicate:nil];
//    [_pageControl alignBottomEdgeWithView:(UIButton*)(_tileButtons[5]) predicate:@"40"];
}

#pragma mark - scroll view delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int offsetX = scrollView.contentOffset.x;
    float scrollWidth = scrollView.frame.size.width;
    int page = (offsetX + (scrollWidth / 2)) / scrollWidth;
    _pageControl.currentPage = page;
}

#pragma mark - actions 
-(void)pageValueChanged:(id)sender {
    float offsetX = _pageControl.currentPage * PAGE_WIDTH;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}



@end
