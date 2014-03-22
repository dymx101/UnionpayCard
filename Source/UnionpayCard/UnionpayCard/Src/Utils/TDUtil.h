//
//  TDUtil.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDUtil : NSObject
+(void)findFonts;
+(BOOL)isIOS7;
+(UIButton *)checkBoxWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)anAction;

+(ETDCellStyle)cellStyleWithIndexPath:(NSIndexPath *)aIndexPath
                            tableView:(UITableView *)aTableView
                  tableViewDataSource:(id<UITableViewDataSource>)aTableViewDataSource;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL)validateIDCardNumber:(NSString *)value;

@end
