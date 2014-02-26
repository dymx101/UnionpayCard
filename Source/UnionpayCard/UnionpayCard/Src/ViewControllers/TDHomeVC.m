//
//  TDHomeVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDHomeVC.h"

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
    [self layoutSubviews];
}



-(void)createSubviews {
    
    _scrollView = [UIScrollView new];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = 2;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [FDColor sharedInstance].white;
    _pageControl.currentPageIndicatorTintColor = [FDColor sharedInstance].caribbeanGreen;
    //[_pageControl addTarget:self action:@selector(pageValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    //
    UIButton *btnTile = [self tileButtonWithTitle:@"用户\n注册" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"卡片\n管理" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"商户\n浏览" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"消费\n充值" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"积分\n活动" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"消费\n预定" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"邮件\n管理" action:nil];
    [_scrollView addSubview:btnTile];
    [_tileButtons addObject:btnTile];
    
    btnTile = [self tileButtonWithTitle:@"生活\n缴费" action:nil];
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

#define PADDING_TOP              (20)
#define PADDING_Y               (20)
#define BUTTON_SIZE             (80)
#define BUTTON_OFFSET_X_CENTER  (50)
#define PAGE_WIDTH              (320)

-(void)layoutSubviews {
    
    [_pageControl alignCenterXWithView:self.view predicate:nil];
    [_pageControl constrainWidthToView:self.view predicate:nil];
    [_pageControl alignBottomEdgeWithView:self.view predicate:@"-80"];
    
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView alignToView:self.view];
    
    int btnCount = _tileButtons.count;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = _tileButtons[i];
        
        int timesOfSix = i / 6;
        
        NSString *btnSize = (@(BUTTON_SIZE)).stringValue;
        [btn constrainWidth:btnSize height:btnSize];
        
        int offsetX = (i % 2) ? BUTTON_OFFSET_X_CENTER : -BUTTON_OFFSET_X_CENTER;
        NSNumber *offsetCenterX = @(offsetX + PAGE_WIDTH * timesOfSix);
        [btn alignCenterXWithView:_scrollView predicate:offsetCenterX.stringValue];
        
        int factor = i % 6;
        NSNumber *paddingTop = @(PADDING_TOP + PADDING_Y * (factor / 2 + 1) + (factor / 2) * BUTTON_SIZE);
        [btn alignTopEdgeWithView:_scrollView predicate:paddingTop.stringValue];
        
        
        
        if (i == btnCount - 1) {
            float paddingX = PAGE_WIDTH / 2 - BUTTON_OFFSET_X_CENTER - BUTTON_SIZE / 2;
            [btn alignTrailingEdgeWithView:_scrollView predicate:(@(-paddingX)).stringValue];
        }
    }
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
