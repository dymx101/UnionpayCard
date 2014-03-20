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
    [_dataSource addObject:[NSMutableDictionary dictionaryWithObject:@"省份证" forKey:KEY_PLACE_HOLDER]];
    
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
    
    if (![TDRegisterStep3VC validatePassword:[(UITextField *)[_dataSource[0] objectForKey:KEY_TEXTFIELD] text]]) { // 密码
        ALERT_MSG(nil, @"密码格式不正确");
        return;
    }

    if (![TDRegisterStep3VC validateEmail:[(UITextField *)[_dataSource[1] objectForKey:KEY_TEXTFIELD] text]]) {  //邮箱
        ALERT_MSG(nil, @"邮箱格式不正确");
        return;
    }
    
    if (![TDRegisterStep3VC validateUserName:[(UITextField *)[_dataSource[2] objectForKey:KEY_TEXTFIELD] text]]) {
        ALERT_MSG(nil, @"输入用户名称不正确")
        return;
    }
    
    if (![TDRegisterStep3VC validateIDCardNumber:[(UITextField *)[_dataSource[3] objectForKey:KEY_TEXTFIELD] text]]) {
        ALERT_MSG(nil, @"身份证格式不正确");
        return;
    }
    
    __block RegistInput * input = [RegistInput new];
    [input setU_log_password:[(UITextField *)[_dataSource[0] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_emil:[(UITextField *)[_dataSource[1] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_realname:[(UITextField *)[_dataSource[2] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_cbcid:[(UITextField *)[_dataSource[3] objectForKey:KEY_TEXTFIELD] text]];
    [input setU_sex:@"1"];
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

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

@end
