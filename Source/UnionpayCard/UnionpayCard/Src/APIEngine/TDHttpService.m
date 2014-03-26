//
//  TDHttpService.m
//  UnionpayCard
//
//  Created by towne on 14-3-5.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDHttpService.h"
#import "RegistInput.h"
#import "BinforInput.h"
#import "RecordInput.h"
#import "ConsumptionInput.h"
#import "UtocardInput.h"

@implementation TDHttpService

/**
 *  功能:从SEL获取接口名称
 */
+ (NSString *)interfaceNameFromSelector:(SEL)aSelector
{
    if (aSelector)
    {
        NSString *selStr = NSStringFromSelector(aSelector);
        NSRange range = [NSStringFromSelector(aSelector) safeRangeOfString:@":" options:NSLiteralSearch];
        if (range.location != NSNotFound)
        {
            NSString *retStr = [selStr safeSubstringToIndex:range.location];
            return retStr;
        }
    }
    return nil;
}

/**
 *  功能:命令模式调用
 */
+ (void) postCommand :(TDHttpCommand *) command completionBlock:(TDCompletionBlock)aCompletionBlock {
    
    [[TDHttpClient sharedClient] processCommand:command callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
        if (anError==nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                aCompletionBlock(responseObject);
            });
        }
        else
            NSLog(@"%@",anError);
    }];
}

/**
 *  功能:1.用户登录
 */
+ (void)LoginUserinfor:(NSString * ) loginame loginPass:(NSString *) logpassword
       completionBlock:(TDCompletionBlock)aCompletionBlock {
    
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:loginame forKey:@"u_logname"];
    [input setValue:logpassword forKey:@"u_log_password"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:2.根据tOken 查询用户
 */
+ (void)ShowUserinfor:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:3.商户一级类别
 */
+ (void)showBtype:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：4.展示用户卡片
 *         筛选条件:商户名称，卡号，卡状态，余额排序（由于这里涉及分表且预估数据量不大，做本地筛选）
 */
+ (void)ShowUtocard:(UtocardInput *) utocardinput completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue: [self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:utocardinput.userToken forKey:@"userToken"];
    if (utocardinput.b_jname    != nil && ![utocardinput.b_jname isEqualToString:@""]) [input setValue:utocardinput.b_jname forKeyPath:@"b_jname"];
    if (utocardinput.u_card     != nil && ![utocardinput.u_card isEqualToString:@""]) [input setValue:utocardinput.u_card forKeyPath:@"u_card"];
    if (utocardinput.card_state != nil && ![utocardinput.card_state isEqualToString:@""]) [input setValue:utocardinput.card_state forKeyPath:@"card_state"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:5.选卡后更新用户信息
 *        u_pre_num 当前用户使用卡号
 *        u_prefix  当前用户使用卡柄
 */
+ (void)updateUserinfor:(NSString *) u_pre_num uPrefix:(NSString *) u_prefix userToken:(NSString *)userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:u_pre_num forKey:@"u_pre_num"];
    [input setValue:u_prefix forKey:@"u_prefix"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:6.消费记录
 */
+ (void)ShowConsumption:(ConsumptionInput *) consumptioninput completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:consumptioninput.userToken forKey:@"userToken"];
    if (consumptioninput.b_jname   != nil && ![consumptioninput.b_jname isEqualToString:@""]) [input setValue:consumptioninput.b_jname forKeyPath:@"b_jname"];
    if (consumptioninput.card      != nil && ![consumptioninput.card isEqualToString:@""]) [input setValue:consumptioninput.card forKeyPath:@"card"];
    if (consumptioninput.scon_tmd  != nil && ![consumptioninput.scon_tmd isEqualToString:@""]) [input setValue:consumptioninput.scon_tmd forKeyPath:@"scon_tmd"];
    if (consumptioninput.mcon_tmd  != nil && ![consumptioninput.mcon_tmd isEqualToString:@""]) [input setValue:consumptioninput.mcon_tmd forKeyPath:@"mcon_tmd"];
    if (consumptioninput.con_state != nil && ![consumptioninput.con_state isEqualToString:@""]) [input setValue:consumptioninput.con_state forKeyPath:@"con_state"];
    consumptioninput.frist         != nil?[input setValue:consumptioninput.frist forKeyPath:@"frist"]:[input setValue:@"0" forKeyPath:@"frist"];
    consumptioninput.pageNum       != nil?[input setValue:consumptioninput.pageNum forKeyPath:@"pageNum"]:[input setValue:@"0" forKeyPath:@"pageNum"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：7.充值记录
 */
+ (void)ShowPreRecords:(RecordInput *) recordinput completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:recordinput.userToken forKey:@"userToken"];
    if (recordinput.b_jname     != nil && ![recordinput.b_jname isEqualToString:@""]) [input setValue:recordinput.b_jname forKeyPath:@"b_jname"];
    if (recordinput.card        != nil && ![recordinput.card isEqualToString:@""]) [input setValue:recordinput.card forKeyPath:@"card"];
    if (recordinput.spre_r_tmd  != nil && ![recordinput.spre_r_tmd isEqualToString:@""]) [input setValue:recordinput.spre_r_tmd forKeyPath:@"spre_r_tmd"];
    if (recordinput.mpre_r_tmd  != nil && ![recordinput.mpre_r_tmd isEqualToString:@""]) [input setValue:recordinput.mpre_r_tmd forKeyPath:@"mpre_r_tmd"];
    if (recordinput.acc_state   != nil && ![recordinput.acc_state isEqualToString:@""]) [input setValue:recordinput.acc_state forKeyPath:@"con_state"];
    if (recordinput.pre_type_id != nil && ![recordinput.pre_type_id isEqualToString:@""]) [input setValue:recordinput.pre_type_id forKeyPath:@"pre_type_id"];
    recordinput.frist           != nil?[input setValue:recordinput.frist forKeyPath:@"frist"]:[input setValue:@"0" forKeyPath:@"frist"];
    recordinput.pageNum         != nil?[input setValue:recordinput.pageNum forKeyPath:@"pageNum"]:[input setValue:@"0" forKeyPath:@"pageNum"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：8.查询用户注册手机是否存在
 */
+ (void)checkiphoneUserinfor: (NSString *) uPhone completionBlock:(TDCompletionBlock)aCompletionBlock {
    
    NSString * key = [uPhone encod];
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:uPhone forKey:@"u_iphone"];
    [input setValue:key forKey:@"key"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能：9.校验验证码
 */
+ (void)checkphonemassage: (NSString *) uPhone Code:(NSString *) uCode completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:uPhone forKey:@"u_iphone"];
    [input setValue:uCode forKey:@"Code"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能: 10.注册
 */
+ (void)resaveUserinfor:(RegistInput *) registinput completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:registinput.u_realname forKey:@"u_realname"];
    [input setValue:registinput.u_sex forKey:@"u_sex"];
    [input setValue:registinput.u_cbcid forKey:@"u_cbcid"];
    [input setValue:registinput.u_emil forKey:@"u_emil"];
    [input setValue:registinput.u_emil forKey:@"u_name"];
    [input setValue:registinput.u_log_password forKey:@"u_log_password"];
    [input setValue:registinput.u_iphone forKey:@"u_iphone"];
    [input setValue:registinput.u_v_id forKey:@"u_v_id"];
    [input setValue:registinput.u_code forKey:@"Code"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:11.修改登陆和交易密码
 */
+ (void)ResetUPwd:(NSString *) userToken uTranpassword:(NSString *) utranpassword newuTranpassword:(NSString *) newutranpassword completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:utranpassword forKey:@"u_tran_password"];
    [input setValue:newutranpassword forKey:@"newu_tran_password"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:12.重置密码
 */
+ (void)ResetUPwd:(NSString *) userToken uLogpassword:(NSString *) ulogpassword newuLogpassword:(NSString *) newulogpassword completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:ulogpassword forKey:@"u_log_password"];
    [input setValue:newulogpassword forKey:@"newu_log_password"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:13.挂失
 */
+ (void)updateloss:(NSString *) userToken uRealname:(NSString *)urealname uLossstate:(NSString *) ulossstate uCbcid:(NSString *) ucbcid completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:urealname forKey:@"u_realname"];
    [input setValue:ulossstate forKey:@"u_loss_state"];
    [input setValue:ucbcid forKey:@"u_cbcid"];
    [input setValue:@"" forKey:@"u_loss_datetime"]; //这里需要传空串
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:14.统计用户是否有这商户的预付费卡
 */
+ (void)countcard:(NSString *) userToken bId:(NSString *)bid completionBlock:(TDCompletionBlock) aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:bid forKey:@"b_id"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:15。用户注册新卡
 */
+ (void)Regcard:(NSString *) userToken bId:(NSString *)bid completionBlock:(TDCompletionBlock) aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    [input setValue:bid forKey:@"b_id"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:16.查询商户列表
 */
+ (void)ShowBinfor:(BinforInput *)binforinput completionBlock:(TDCompletionBlock)aCompletionBlock {
    
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    if (binforinput.b_name     != nil) [input setValue:binforinput.b_name forKeyPath:@"b_name"];
    if (binforinput.b_no       != nil) [input setValue:binforinput.b_no forKeyPath:@"b_no"];
    if (binforinput.b_jname    != nil) [input setValue:binforinput.b_jname forKeyPath:@"b_jname"];
    if (binforinput.b_type     != nil) [input setValue:binforinput.b_type forKeyPath:@"b_type"];
    if (binforinput.b_2type    != nil) [input setValue:binforinput.b_2type forKeyPath:@"b_2type"];
    if (binforinput.b_htype    != nil) [input setValue:binforinput.b_htype forKeyPath:@"b_htype"];
    if (binforinput.b_province != nil) [input setValue:binforinput.b_province forKeyPath:@"b_province"];
    if (binforinput.b_city     != nil) [input setValue:binforinput.b_city forKeyPath:@"b_city"];
    if (binforinput.b_district != nil) [input setValue:binforinput.b_city forKeyPath:@"b_district"];
    if (binforinput.b_cbd      != nil) [input setValue:binforinput.b_cbd forKeyPath:@"b_cbd"];
    if (binforinput.b_crcle    != nil) [input setValue:binforinput.b_crcle forKeyPath:@"b_crcle"];
    if (binforinput.b_sort     != nil) [input setValue:binforinput.b_sort forKeyPath:@"b_sort"];
    if (binforinput.b_t_state  != nil) [input setValue:binforinput.b_t_state forKeyPath:@"b_t_state"];
    binforinput.frist          != nil?[input setValue:binforinput.frist forKeyPath:@"frist"]:[input setValue:@"0" forKeyPath:@"frist"];
    binforinput.pageNum        != nil?[input setValue:binforinput.pageNum forKeyPath:@"pageNum"]:[input setValue:@"0" forKeyPath:@"pageNum"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

/**
 *  功能:17.商户总数
 */
+ (void)countbinfor:(BinforInput *)binforinput completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    if (binforinput.b_name     != nil) [input setValue:binforinput.b_name forKeyPath:@"b_name"];
    if (binforinput.b_no       != nil) [input setValue:binforinput.b_no forKeyPath:@"b_no"];
    if (binforinput.b_jname    != nil) [input setValue:binforinput.b_jname forKeyPath:@"b_jname"];
    if (binforinput.b_type     != nil) [input setValue:binforinput.b_type forKeyPath:@"b_type"];
    if (binforinput.b_2type    != nil) [input setValue:binforinput.b_2type forKeyPath:@"b_2type"];
    if (binforinput.b_htype    != nil) [input setValue:binforinput.b_htype forKeyPath:@"b_htype"];
    if (binforinput.b_province != nil) [input setValue:binforinput.b_province forKeyPath:@"b_province"];
    if (binforinput.b_city     != nil) [input setValue:binforinput.b_city forKeyPath:@"b_city"];
    if (binforinput.b_district != nil) [input setValue:binforinput.b_city forKeyPath:@"b_district"];
    if (binforinput.b_cbd      != nil) [input setValue:binforinput.b_cbd forKeyPath:@"b_cbd"];
    if (binforinput.b_crcle    != nil) [input setValue:binforinput.b_crcle forKeyPath:@"b_crcle"];
    if (binforinput.b_sort     != nil) [input setValue:binforinput.b_sort forKeyPath:@"b_sort"];
    if (binforinput.b_t_state  != nil) [input setValue:binforinput.b_t_state forKeyPath:@"b_t_state"];
    binforinput.frist          != nil?[input setValue:binforinput.frist forKeyPath:@"frist"]:[input setValue:@"0" forKeyPath:@"frist"];
    binforinput.pageNum        != nil?[input setValue:binforinput.pageNum forKeyPath:@"pageNum"]:[input setValue:@"0" forKeyPath:@"pageNum"];
    
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}


/**
 *  功能：18.退出登录
 */
+ (void)exitTOKEN:(NSString *) userToken completionBlock:(TDCompletionBlock)aCompletionBlock {
    NSMutableDictionary * input = [NSMutableDictionary new];
    [input setValue:[self interfaceNameFromSelector:_cmd] forKey:@"method"];
    [input setValue:userToken forKey:@"userToken"];
    TDHttpCommand * command = [TDHttpCommand new];
    command.inPut = input;
    [self postCommand:command completionBlock:aCompletionBlock];
}

@end
