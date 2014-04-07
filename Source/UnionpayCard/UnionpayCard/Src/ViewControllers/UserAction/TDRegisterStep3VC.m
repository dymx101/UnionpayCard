//
//  TDRegisterStep3VC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/15/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRegisterStep3VC.h"
#import "GNTextFieldCell.h"
#import "RegistInput.h"

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
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"姓名" forKey:KEY_PLACE_HOLDER]];
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"身份证" forKey:KEY_PLACE_HOLDER]];
    
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
    
    if (![TDUtil validatePassword:[(UITextField *)[_dataSource[0] objectForKey:KEY_TEXTFIELD] text]]) { // 密码
        ALERT_MSG(nil, @"密码格式不正确");
        return;
    }

    if (![TDUtil validateEmail:[(UITextField *)[_dataSource[1] objectForKey:KEY_TEXTFIELD] text]]) {  //邮箱
        ALERT_MSG(nil, @"邮箱格式不正确");
        return;
    }
    
//    if (![TDUtil validateUserName:[(UITextField *)[_dataSource[2] objectForKey:KEY_TEXTFIELD] text]]) {
//        ALERT_MSG(nil, @"输入用户名称不正确")
//        return;
//    }
    
    if (![TDUtil validateIDCardNumber:[(UITextField *)[_dataSource[3] objectForKey:KEY_TEXTFIELD] text]]) {
        ALERT_MSG(nil, @"身份证格式不正确");
        return;
    }
    
    __block RegistInput * input = [RegistInput new];
    [input setU_log_password:[(UITextField *)[_dataSource[0] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_emil:[(UITextField *)[_dataSource[1] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_realname:[(UITextField *)[_dataSource[2] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_cbcid:[(UITextField *)[_dataSource[3] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_sex:_btnMale.selected?@"1":@"0"];
    [input setU_iphone:_phoneNUM];
    [input setU_code:_phoneCode];
    __weak TDRegisterStep3VC * weakSelf = self;
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD show:YES];
    
    [TDHttpService resaveUserinfor:input completionBlock:^(id responseObject) {
        [HUD hide:YES];
        if ([[responseObject objectForKey:@"State"] isEqualToString:@"error"]||[[responseObject objectForKey:@"State"] isEqualToString:@"error1"]) {
            ALERT_MSG(nil, @"注册失败");
            return;
        }
        if ([[responseObject objectForKey:@"State"] integerValue] == 2) {
            ALERT_MSG(nil, @"用户名重复");
            return;
        }
        if ([[responseObject objectForKey:@"State"] integerValue] == 3) {
            ALERT_MSG(nil, @"手机重复");
            return;
        }
        if ([[responseObject objectForKey:@"State"] integerValue] == 4) {
            ALERT_MSG(nil, @"邮箱重复");
            return;
        }
        
        if ([[responseObject objectForKey:@"State"] integerValue] == 0) {
            MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            [HUD show:YES];
            [TDHttpService LoginUserinfor:input.u_iphone loginPass:input.u_log_password completionBlock:^(id responseObject) {
                if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]) {
                    SharedToken = [responseObject objectForKey:@"userToken"];
                    [TDHttpService ShowUserinfor:SharedToken completionBlock:^(id responseObject) {
                        [HUD hide:YES];
                        if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
                            SharedAppUser = [responseObject lastObject];
                            [self postNotification:OTS_NOTE_LOGIN_OK];
                            [weakSelf.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                        }
                    }];
                }
            }];

        }

    }];

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
