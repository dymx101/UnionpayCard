//
//  TDCardListVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/27/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCardListVC.h"
#import "UIView+Effect.h"
#import "TDCateogryButton.h"
#import "TDCategoryCell.h"
#import "TDCardCell.h"

#import "Card.h"
#import "Btype.h"
#import "UtocardVO.h"
#import "Userinfor.h"
#import "TDLoginVC.h"

//#warning 重置按钮
//#warning 下拉刷新
//#warning 定时刷新active card数据

#define kDummyString    @" "

@interface TDCardListVC () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    UIView                          *_topBarShadowView;
    UIView                          *_topBarView;
    NSLayoutConstraint              *_constraintTopBarHeight;
    
    UIView              *_topBarViewSearch;
    
    UISegmentedControl      *_segmentSearch;
    BOOL                    _isSearchByName;
    UISearchBar             *_searchBar;
    UILabel                 *_lblCardStatus;
    UIButton                *_btnCardStatusNormal;
    UIButton                *_btnCardStatusFrozen;
    
    TDCateogryButton    *_btnCategory;
    UIView              *_vertDevideLine;
    UIButton            *_btnReset;
    
    UIButton            *_viewMask;
    UITableView         *_cateTv;
    NSLayoutConstraint  *_constraintCateTvHeight;
    float               _cateTvHeight;
    NSInteger           _cateTVSelectedIndex;
    
    UITableView         *_mainTv;
    UIView              *_header;
    __weak NSLayoutConstraint  *_constraintHeaderHeight;
    
    UIImageView         *_ivActiveCard;
    UILabel             *_lblActiveCardTitle;
    UILabel             *_lblActiveCardNumber;
    UILabel             *_lblActiveCardBalanceTitle;
    UILabel             *_lblActiveCardBalanceValue;
    
    UtocardVO             *_selectedCard;
    Btype               *_TDCategoryResource;
    
}
@property (nonatomic, strong)     UITableView         *mainTv;

//For test
@property (nonatomic, assign)   NSUInteger          testDataCount;
@property (nonatomic, strong)   NSArray             * UtoCards;
@property(nonatomic, strong)    NSCache 	        * imageCache;

@property(nonatomic, strong)    NSString            * u_pre_num; //当前使用卡号
@property(nonatomic, strong)    NSString            * u_prefix;  //当前使用卡柄
@property(nonatomic, strong)    Userinfor           * userinfor; //当前用户

@end

@implementation TDCardListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [FDColor sharedInstance].red;
    self.navigationItem.title = @"卡片管理";
    [self installSearchToNavibar];
    
    _cateTvHeight = 380;
    _testDataCount = 10;
    
    [self createViews];
    [self layoutViews];
    [self sendRequest];
}

- (void)didReceiveMemoryWarning {
    [self.imageCache removeAllObjects];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.imageCache removeAllObjects];
    self.imageCache = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSCache *) imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSCache new];
        [_imageCache setName:@"JKImageCache"];
        return _imageCache;
    }
    return _imageCache;
}

-(void)createViews {
    
    UIView *header = [self mainHeader];
    header.alpha = 0;
    [self.view addSubview:header];
    
    _mainTv = [UITableView new];
    _mainTv.delegate = self;
    _mainTv.dataSource = self;
    _mainTv.backgroundColor = [FDColor sharedInstance].clear;
    _mainTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTv.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainTv];
    
    __weak TDCardListVC *weakSelf = self;
    [_mainTv addPullToRefreshWithActionHandler:^{
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf sendRequest];
            [weakSelf.mainTv.pullToRefreshView stopAnimating];
        });
    }];
    [_mainTv.pullToRefreshView setTitle:@"正在加载..." forState:SVPullToRefreshStateLoading];
    [_mainTv.pullToRefreshView setTitle:@"下拉刷新数据" forState:SVPullToRefreshStateStopped];
    [_mainTv.pullToRefreshView setTitle:@"释放开始加载" forState:SVPullToRefreshStateTriggered];
    
    [_mainTv addInfiniteScrollingWithActionHandler:^{
        //
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            weakSelf.testDataCount = weakSelf.testDataCount + 10;
            [weakSelf sendRequest];
            [weakSelf.mainTv.infiniteScrollingView stopAnimating];
        });
    }];
    
    
    _topBarShadowView = [UIView new];
    _topBarShadowView.backgroundColor = [FDColor sharedInstance].black;
    [_topBarShadowView applyEffectShadow];
    [self.view addSubview:_topBarShadowView];
    
    _topBarView = [UIView new];
    _topBarView.backgroundColor = [FDColor sharedInstance].silver;
    [self.view addSubview:_topBarView];
    
    // background for search bar
    _topBarViewSearch = [UIView new];
    _topBarViewSearch.backgroundColor = [FDColor sharedInstance].silver;
    [self.view addSubview:_topBarViewSearch];
    _topBarViewSearch.hidden = YES;
    
    _segmentSearch = [[UISegmentedControl alloc] initWithItems:@[@"名称", @"卡号"]];
    _segmentSearch.selectedSegmentIndex = 0;
    _isSearchByName = YES;
    //_segmentSearch.tintColor = [FDColor sharedInstance].themeBlue;
    [_segmentSearch addTarget:self action:@selector(segSearchChanged:) forControlEvents:UIControlEventValueChanged];
    [_topBarViewSearch addSubview:_segmentSearch];
    [_segmentSearch alignTop:@"5" leading:@"10" toView:_topBarViewSearch];
    
    _searchBar = [UISearchBar new];
    _searchBar.delegate = self;
    _searchBar.text = kDummyString;
    if([TDUtil isIOS7]) {
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    [_topBarViewSearch addSubview:_searchBar];
    [_searchBar alignCenterYWithView:_segmentSearch predicate:nil];
    [_searchBar alignLeading:@"100" trailing:@"-20" toView:_topBarViewSearch];
    
    //
    //
    _lblCardStatus = [UILabel new];
    _lblCardStatus.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblCardStatus.text = @"卡片状态:";
    [_topBarViewSearch addSubview:_lblCardStatus];
    [_lblCardStatus constrainTopSpaceToView:_segmentSearch predicate:@"15"];
    [_lblCardStatus alignLeadingEdgeWithView:_segmentSearch predicate:nil];
    
    _btnCardStatusNormal = [TDUtil checkBoxWithTitle:@"正常" target:self action:@selector(rechargeTypeChanged:)];
    _btnCardStatusNormal.selected = YES;
    [_topBarViewSearch addSubview:_btnCardStatusNormal];
    [_btnCardStatusNormal alignCenterYWithView:_lblCardStatus predicate:nil];
    [_btnCardStatusNormal constrainLeadingSpaceToView:_lblCardStatus predicate:@"20"];
    [_btnCardStatusNormal constrainWidth:@"100"];
    
    _btnCardStatusFrozen = [TDUtil checkBoxWithTitle:@"冻结" target:self action:@selector(rechargeTypeChanged:)];
    [_topBarViewSearch addSubview:_btnCardStatusFrozen];
    _btnCardStatusFrozen.tag = 1;
    [_btnCardStatusFrozen alignCenterYWithView:_btnCardStatusNormal predicate:nil];
    [_btnCardStatusFrozen constrainLeadingSpaceToView:_btnCardStatusNormal predicate:@"5"];
    [_btnCardStatusFrozen constrainWidth:@"100"];
    
    //
    _btnCategory = [TDCateogryButton new];
    _btnCategory.backgroundColor = [FDColor sharedInstance].silver;
    [_btnCategory setCateType:kCateTypeAll];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(categoryTapAction:)];
    [_btnCategory addGestureRecognizer:tap];
    [_topBarView addSubview:_btnCategory];
    
    _vertDevideLine = [UIView new];
    _vertDevideLine.backgroundColor = [FDColor sharedInstance].silverDark;
    [_topBarView addSubview:_vertDevideLine];
    
    _btnReset = [UIButton new];
    [_btnReset setTitle:@"卡片重置" forState:UIControlStateNormal];
    _btnReset.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [_btnReset setTitleColor:[FDColor sharedInstance].darkGray forState:UIControlStateNormal];
    [_btnReset setTitleColor:[FDColor sharedInstance].caribbeanGreen forState:UIControlStateHighlighted];
    [_btnReset addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topBarView addSubview:_btnReset];
    
    // mask
    _viewMask = [UIButton new];
    _viewMask.backgroundColor = [UIColor colorWithWhite:0 alpha:.5f];
    [self.view addSubview:_viewMask];
    [_viewMask addTarget:self action:@selector(hideCateMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    _cateTv = [UITableView new];
    _cateTv.delegate = self;
    _cateTv.dataSource = self;
    _cateTv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_viewMask addSubview:_cateTv];
    
    // search view
    
    
    _viewMask.alpha = 0;
}

#define TOP_BAR_HEIGHT          (40)
#define TOP_BAR_HEIGHT_SEARCH   (80)

-(void)layoutViews {
    
    [_topBarShadowView constrainWidthToView:self.view predicate:nil];
    _constraintTopBarHeight = [_topBarShadowView constrainHeight:@(TOP_BAR_HEIGHT).stringValue].firstObject;
    [_topBarShadowView alignTopEdgeWithView:self.view predicate:nil];
    [_topBarShadowView alignCenterXWithView:self.view predicate:nil];
    
    UIView *header = [self mainHeader];
    [header constrainWidthToView:_topBarShadowView predicate:nil];
    [header constrainTopSpaceToView:_topBarShadowView predicate:nil];
    [header alignCenterXWithView:_topBarShadowView predicate:nil];
    _constraintHeaderHeight = [header constrainHeight:@"0"].firstObject;
    
    
    [_mainTv alignLeading:@"0" trailing:@"0" toView:self.view];
    [_mainTv constrainTopSpaceToView:header predicate:nil];
    [_mainTv alignBottomEdgeWithView:self.view predicate:nil];
    
    [_topBarView alignToView:_topBarShadowView];
    
    [_topBarViewSearch alignToView:_topBarShadowView];
    
    [_btnCategory constrainHeightToView:_topBarView predicate:nil];
    [_btnCategory constrainWidthToView:_topBarView predicate:@"*.5"];
    [_btnCategory alignTop:@"0" leading:@"0" toView:_topBarView];
    
    [_vertDevideLine constrainWidth:@"1"];
    [_vertDevideLine constrainLeadingSpaceToView:_btnCategory predicate:@"0"];
    [_vertDevideLine alignTop:@"10" bottom:@"-10" toView:_topBarView];
    
    [_btnReset constrainHeightToView:_topBarView predicate:nil];
    [_btnReset constrainLeadingSpaceToView:_vertDevideLine predicate:@"0"];
    [_btnReset alignTrailingEdgeWithView:_topBarView predicate:@"-10"];
    [_btnReset alignTopEdgeWithView:_topBarView predicate:nil];
    
    [_viewMask alignToView:self.view];
    
    [_cateTv alignTop:@"40" leading:@"1" toView:_viewMask];
    [_cateTv constrainWidth:@"150"];
    _constraintCateTvHeight = [_cateTv constrainHeight:@(_cateTvHeight).stringValue].firstObject;
}

- (void) sendRequest {
    
    if (SharedAppUser) {
        
        __weak TDCardListVC * weakSelf = self;
        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        [HUD show:YES];

        self.u_pre_num = SharedAppUser.u_pre_num;
        self.u_prefix = SharedAppUser.u_prefix;
        self.userinfor = SharedAppUser;
        
        [TDHttpService ShowUtocard:SharedToken completionBlock:^(id responseObject) {
            [HUD hide:YES];
            if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                
                weakSelf.UtoCards= responseObject;
                [weakSelf.mainTv reloadData];
                
                /********************************初始化选中的卡**************************************************************/
                for (UtocardVO * utocard in weakSelf.UtoCards) {
                    if (![self.userinfor.u_pre_num isKindOfClass:[NSNull class]] && [[self.userinfor.u_pre_num stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[[utocard u_card] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
                        _constraintHeaderHeight.constant = 110;
                        [UIView animateWithDuration:.3f animations:^{
                            
                            [_ivActiveCard setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@active/upload/shop/%@",BASEURL,utocard.b_cordimg]] placeholderImage:nil];
                            _lblActiveCardTitle.text = utocard.b_jname;
                            _lblActiveCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",utocard.u_card];
                            _lblActiveCardBalanceValue.text = [NSString stringWithFormat:@"%@",utocard.card_balance];
                            [self mainHeader].alpha = 1;
                            [self.view layoutIfNeeded];
                        }];
                    }
                }
                if ([self.userinfor.u_pre_num isKindOfClass:[NSNull class]] || [[self.userinfor.u_pre_num stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:[NSString stringWithFormat:@"%d",0]]) {
                    [self resetAction:nil];
                }
            }
        }];
    }
}

#pragma mark - actions
-(void)categoryTapAction:(id)sender {
    [UIView animateWithDuration:.2f animations:^{
        _viewMask.alpha =  (_viewMask.alpha ? 0 : 1) ;
    }];
}

-(void)hideCateMenu:(id)sender {
    
    [UIView animateWithDuration:.2f animations:^{
        _viewMask.alpha = 0;
    }];
}

-(void)segSearchChanged:(UISegmentedControl *)aControl {
    _isSearchByName = (aControl.selectedSegmentIndex == 0);
}

#pragma mark - table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _cateTv) {
        return [TDCategoryResource alltypes].count;
    } else {
        return [self.UtoCards count];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _cateTv) {
        static NSString *cellIdStr = @"TDCategoryCell";
        TDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdStr];
        if (cell == nil) {
            cell = [TDCategoryCell new];
        }
        
        [cell.btnCategory setCateType:[([TDCategoryResource alltypes][indexPath.row]) intValue]];
        
        BOOL showCover = (indexPath.row == _cateTVSelectedIndex);
        [cell setItemSelected:showCover];
        
        return cell;
        
    } else if (tableView == _mainTv) {
        static NSString *cellIdStr = @"TDCardCell";
        TDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdStr];
        if (cell == nil) {
            cell = [TDCardCell new];
        }
        self.imageCache = [cell UpdateCardInfo:_UtoCards[indexPath.row] addCache:self.imageCache];
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _cateTv) {
        return [TDCategoryCell HEIGHT];
    } else if (tableView == _mainTv) {
        return [TDCardCell HEIGHT];
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _cateTv) {
        
        _cateTVSelectedIndex = indexPath.row;
        [_btnCategory setCateType:[([TDCategoryResource alltypes][_cateTVSelectedIndex]) intValue]];
        [self hideCateMenu:nil];
        [tableView reloadData];
        
    } else if (tableView == _mainTv) {
        
        _selectedCard = _UtoCards[indexPath.row];
        
        [TDHttpService updateUserinfor:_selectedCard.u_card uPrefix:_selectedCard.b_prefilx userToken:SharedToken completionBlock:^(id responseObject) {
            if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
                SharedAppUser.u_pre_num = _selectedCard.u_card;
                SharedAppUser.u_prefix = _selectedCard.b_prefilx;
                UIView *header = [self mainHeader];
                
                _constraintHeaderHeight.constant = 110;
                [header viewWithTag:2014].alpha = .7f;
                
                [UIView animateWithDuration:.2f animations:^{
                    [_ivActiveCard setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@active/upload/shop/%@", BASEURL,_selectedCard.b_cordimg]] placeholderImage:nil];
                    _lblActiveCardTitle.text = _selectedCard.b_jname;
                    _lblActiveCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",_selectedCard.u_card];
                    _lblActiveCardBalanceValue.text = [NSString stringWithFormat:@"%@",_selectedCard.card_balance];
                    header.alpha = 1;
                    [header viewWithTag:2014].alpha = 0;
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    //
                }];
            }
        }];
    }
}

#pragma mark - table header & footer
-(UIView *)mainHeader {
    
    if (_header == nil) {
        _header = [UIView new];
        _header.backgroundColor = [FDColor sharedInstance].clear;
        
        UIView  *bgView = [UIView new];
        bgView.backgroundColor = [FDColor sharedInstance].white;
        [_header addSubview:bgView];
        [bgView alignLeading:@"0" trailing:@"0" toView:_header];
        [bgView alignTopEdgeWithView:_header predicate:nil];
        [bgView constrainHeight:@"109.5"];
        [bgView applyEffectShadow];
        
        _ivActiveCard = [UIImageView new];
        [_ivActiveCard applyEffectRoundRectSilverBorder];
        [_header addSubview:_ivActiveCard];
        
        [_ivActiveCard setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@active/upload/shop/%@",BASEURL,_selectedCard.b_cordimg]] placeholderImage:nil];
        
        [_ivActiveCard constrainWidth:@"125" height:@"85"];
        [_ivActiveCard alignCenterYWithView:_header predicate:nil];
        [_ivActiveCard alignLeadingEdgeWithView:_header predicate:@"10"];
        
        //
        _lblActiveCardTitle = [UILabel new];
        _lblActiveCardTitle.font = [TDFontLibrary sharedInstance].fontLargeBold;
        _lblActiveCardTitle.text = _selectedCard.b_jname;
        _lblActiveCardTitle.textColor = [FDColor sharedInstance].cerulean;
        [_header addSubview:_lblActiveCardTitle];
        
        [_lblActiveCardTitle alignTopEdgeWithView:_ivActiveCard predicate:@"10"];
        [_lblActiveCardTitle constrainLeadingSpaceToView:_ivActiveCard predicate:@"10"];
        
        //
        _lblActiveCardNumber = [UILabel new];
        _lblActiveCardNumber.font = [TDFontLibrary sharedInstance].fontNormal;
        _lblActiveCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",_selectedCard.u_card];
        _lblActiveCardNumber.textColor = [FDColor sharedInstance].cerulean;
        [_header addSubview:_lblActiveCardNumber];
        
        [_lblActiveCardNumber constrainTopSpaceToView:_lblActiveCardTitle predicate:@"15"];
        [_lblActiveCardNumber alignLeadingEdgeWithView:_lblActiveCardTitle predicate:nil];
        
        //
        _lblActiveCardBalanceTitle = [UILabel new];
        _lblActiveCardBalanceTitle.font = [TDFontLibrary sharedInstance].fontNormal;
        _lblActiveCardBalanceTitle.text = @"余额 : ";
        _lblActiveCardBalanceTitle.textColor = [FDColor sharedInstance].cerulean;
        [_header addSubview:_lblActiveCardBalanceTitle];
        
        [_lblActiveCardBalanceTitle constrainTopSpaceToView:_lblActiveCardNumber predicate:@"4"];
        [_lblActiveCardBalanceTitle alignLeadingEdgeWithView:_lblActiveCardTitle predicate:nil];
        
        //
        _lblActiveCardBalanceValue = [UILabel new];
        _lblActiveCardBalanceValue.font = [TDFontLibrary sharedInstance].fontNormal;
        _lblActiveCardBalanceValue.text = [NSString stringWithFormat:@"%@",_selectedCard.card_balance];
        _lblActiveCardBalanceValue.textColor = [FDColor sharedInstance].red;
        [_header addSubview:_lblActiveCardBalanceValue];
        
        [_lblActiveCardBalanceValue alignTopEdgeWithView:_lblActiveCardBalanceTitle predicate:nil];
        [_lblActiveCardBalanceValue constrainLeadingSpaceToView:_lblActiveCardBalanceTitle predicate:@"0"];
        
        //
        UIImageView *ivCheck = [UIImageView new];
        ivCheck.image = [UIImage imageNamed:@"icon_orderReview_checked"];
        [_header addSubview:ivCheck];
        
        [ivCheck alignCenterYWithView:_lblActiveCardTitle predicate:nil];
        [ivCheck constrainLeadingSpaceToView:_lblActiveCardTitle predicate:@"10"];
        
        // splash
        UIView  *splash = [UIView new];
        splash.tag = 2014;
        splash.backgroundColor = [FDColor sharedInstance].white;
        splash.alpha = 0;
        [_header addSubview:splash];
        [splash alignLeading:@"0" trailing:@"0" toView:_header];
        [splash alignTopEdgeWithView:_header predicate:nil];
        [splash constrainHeight:@"109.5"];
    }
    
    return _header;
}

#pragma mark - search bar
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (searchBar.text.length < 1) {
        searchBar.text = kDummyString;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length < 1) {
        searchBar.text = kDummyString;
    }
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range     replacementText:(NSString *)text
{
    BOOL isPreviousTextDummyString = [searchBar.text isEqualToString:kDummyString];
    BOOL isNewTextDummyString = [text isEqualToString:kDummyString];
    if (isPreviousTextDummyString && !isNewTextDummyString && text.length > 0) {
        searchBar.text = @"";
    }
    
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    DLog(@"keyword: %@", searchBar.text);
}

-(void)searchAction:(id)sender {
    _topBarViewSearch.hidden = !_topBarViewSearch.hidden;
    [_searchBar resignFirstResponder];
    
    _constraintTopBarHeight.constant = (_topBarViewSearch.hidden) ? TOP_BAR_HEIGHT : TOP_BAR_HEIGHT_SEARCH;
    [UIView animateWithDuration:.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)rechargeTypeChanged:(UIView *)sender {
    BOOL rechargeOnline = sender.tag;
    _btnCardStatusNormal.selected = !rechargeOnline;
    _btnCardStatusFrozen.selected = rechargeOnline;
}

-(void)resetAction:(id)sender {

    [TDHttpService updateUserinfor:@"0" uPrefix:@"0" userToken:SharedToken completionBlock:^(id responseObject) {
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            SharedAppUser.u_pre_num = @"0";
            SharedAppUser.u_prefix = @"0";
            _selectedCard = nil;
            _constraintHeaderHeight.constant = 0;
            [UIView animateWithDuration:.3f animations:^{
                [self mainHeader].alpha = 0;
                [self.view layoutIfNeeded];
            }];
        }
    }];

}

@end
