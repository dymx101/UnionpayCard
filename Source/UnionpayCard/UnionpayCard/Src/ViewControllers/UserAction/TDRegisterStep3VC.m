//
//  TDRegisterStep3VC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/15/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRegisterStep3VC.h"
#import "GNTextFieldCell.h"

#define STR_CELL_ID     @"STR_CELL_ID"

typedef enum {
    kTDInputPassword = 0
    , kTDInputEmail
    , kTDInputLastName
    , kTDInputFirstName
    , kTDInputCount
}ETDInputType;

#define KEY_PLACE_HOLDER    @"KEY_PLACE_HOLDER"
#define KEY_TEXTFIELD       @"KEY_TEXTFIELD"

@interface TDRegisterStep3VC () <UITableViewDelegate, UITableViewDataSource> {
    UIImageView     *_ivProgress;
    UITableView     *_tvForm;
    
    UIButton        *_btnGetCode;
    UIView          *_tableFooter;
    
    NSMutableArray  *_dataSource;
    
    UIButton        *_btnMale;
    UIButton        *_btnFemale;
}

@end

@implementation TDRegisterStep3VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    _dataSource = [NSMutableArray arrayWithCapacity:kTDInputCount];
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"设置密码" forKey:KEY_PLACE_HOLDER]];
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"设置邮箱" forKey:KEY_PLACE_HOLDER]];
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"姓" forKey:KEY_PLACE_HOLDER]];
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"名" forKey:KEY_PLACE_HOLDER]];
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivProgress = [UIImageView new];
    _ivProgress.image = [UIImage imageNamed:@"register_step3_banner"];
    [self.view addSubview:_ivProgress];
    
    _tvForm = [UITableView new];
    _tvForm.delegate = self;
    _tvForm.dataSource = self;
    [_tvForm registerClass:[GNTextFieldCell class] forCellReuseIdentifier:STR_CELL_ID];
    _tvForm.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tvForm.backgroundColor = [UIColor clearColor];
    _tvForm.tableFooterView = [self tableFooter];
    [self.view addSubview:_tvForm];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardAction:)];
    [_tvForm addGestureRecognizer:tap];
    
}

#pragma mark - footer
-(UIView *)tableFooter {
    if (_tableFooter == nil) {
        _tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tvForm.frame.size.width, 130)];
        
        UILabel *lblGender = [UILabel new];
        lblGender.font = [TDFontLibrary sharedInstance].fontNormal;
        lblGender.text = @"性别";
        [_tableFooter addSubview:lblGender];
        [lblGender alignTop:@"20" leading:@"30" toView:_tableFooter];
        
        _btnMale = [TDUtil checkBoxWithTitle:@"男" target:self action:@selector(checkMale)];
        [_tableFooter addSubview:_btnMale];
        [_btnMale alignBaselineWithView:lblGender predicate:nil];
        [_btnMale constrainLeadingSpaceToView:lblGender predicate:@"20"];
        _btnMale.selected = YES;
        
        _btnFemale = [TDUtil checkBoxWithTitle:@"女" target:self action:@selector(checkFemale)];
        [_tableFooter addSubview:_btnFemale];
        [_btnFemale alignBaselineWithView:lblGender predicate:nil];
        [_btnFemale constrainLeadingSpaceToView:_btnMale predicate:@"20"];
        
        UIButton *btnSubmit = [self btnSubmit];
        [_tableFooter addSubview:btnSubmit];
        [btnSubmit constrainWidth:@"280"];
        [btnSubmit alignCenterXWithView:_tableFooter predicate:nil];
        [btnSubmit constrainTopSpaceToView:lblGender predicate:@"20"];
    }
    
    return _tableFooter;
}

-(UIButton *)btnSubmit {
    if (_btnGetCode == nil) {
        _btnGetCode = [UIButton new];
        [_btnGetCode setBackgroundImage:[TDImageLibrary sharedInstance].btnBgGreen forState:UIControlStateNormal];
        [_btnGetCode setTitle:@"提交" forState:UIControlStateNormal];
        _btnGetCode.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
        [_btnGetCode addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnGetCode;
}

-(void)layoutViews {
    [_ivProgress alignTopEdgeWithView:self.view predicate:nil];
    [_ivProgress alignCenterXWithView:self.view predicate:nil];
    
    [_tvForm constrainTopSpaceToView:_ivProgress predicate:nil];
    [_tvForm alignLeading:@"0" trailing:@"0" toView:self.view];
    [_tvForm alignBottomEdgeWithView:self.view predicate:@"0"];
}

#pragma mark - actions
-(void)submit:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)hideKeyboardAction:(id)sender {
    for (id dic in _dataSource) {
        UITextField *tf = [dic objectForKey:KEY_TEXTFIELD];
        [tf resignFirstResponder];
    }
}

-(void)checkMale {
    _btnMale.selected = YES;
    _btnFemale.selected = !_btnMale.selected;
}

-(void)checkFemale {
    _btnMale.selected = NO;
    _btnFemale.selected = !_btnMale.selected;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GNTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    int row = indexPath.row;
    NSMutableDictionary *dic = _dataSource[row];
    cell.textField.placeholder = [dic objectForKey:KEY_PLACE_HOLDER];
    cell.textField.secureTextEntry = (row == kTDInputPassword);
    cell.textField.keyboardType = (row == kTDInputEmail ? UIKeyboardTypeEmailAddress : UIKeyboardTypeDefault);
    cell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    ETDCellStyle cellStyle = [TDUtil cellStyleWithIndexPath:indexPath tableView:tableView tableViewDataSource:self];
    [cell setStyle:cellStyle];
    
    [dic setObject:cell.textField forKey:KEY_TEXTFIELD];
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

@end
