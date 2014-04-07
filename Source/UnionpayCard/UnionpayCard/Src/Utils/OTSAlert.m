//
//  OTSAlert.m
//  OneStore
//
//  Created by Yim Daniel on 13-1-16.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "OTSAlert.h"

@interface OTSAlert()

@end

@implementation OTSAlert
DEF_SINGLETON(OTSAlert)

- (OTSDataAlertView *)alertViewWithMessage:(NSString *)aMessage delegate:(id)aDelegate buttons:(NSString *)btn,...NS_REQUIRES_NIL_TERMINATION
{
    OTSDataAlertView *alertView = [[OTSDataAlertView alloc] init];
    alertView.title = @"提示";
    alertView.message = aMessage;
    alertView.delegate = aDelegate;
    
    va_list argList;
    
    va_start(argList, btn);
    
    for (NSString *str = btn; str != nil; str = va_arg(argList, NSString *)) {
        [alertView addButtonWithTitle:str];
    }
    va_end(argList);
    
    return alertView;
}

- (void)alert:(NSString *)aMessage
{
    if (!self.alertShowing) {
        self.alertShowing = YES;
        [self alert:aMessage delegate:self];
    }
}

- (void)alert:(NSString *)aMessage andInterfaceName:(NSString *)name
{
    if (!self.alertShowing) {
        self.alertShowing = YES;
#ifdef DEBUG
        NSString *msg = [NSString stringWithFormat:@"(接口:%@)%@",name,aMessage];
        [self alert:msg delegate:self];
#else
        [self alert:aMessage delegate:self];
#endif
    }
}

- (void)alertNetError
{
    [self alert:@"当前网络不可用，请检查你的网络设置..."];
}

- (void)alertNetErrorWithInterfaceName:(NSString *)name
{
    [self alert:@"当前网络不可用，请检查你的网络设置..." andInterfaceName:name];
}

- (void)alertServerError
{
    [self alert:@"系统繁忙，请稍后重试..."];
}

- (void)alertServerErrorWithInterfaceName:(NSString *)name
{
    [self alert:@"系统繁忙，请稍后重试..." andInterfaceName:name];
}

-(void)alertWithServerReturnMessage:(NSString *)aMessage
{
    [self alert:aMessage];
}

- (OTSDataAlertView *)alert:(NSString *)aMessage delegate:(id/*<UIAlertViewDelegate>*/)aDelegate
{
    return [self alert:aMessage title:nil leftBtn:OTSSTRING(@"确定") rightBtn:nil delegate:aDelegate];
}

- (OTSDataAlertView *)alertCancelOK:(NSString *)aMessage delegate:(id)aDelegate
{
    return [self alert:aMessage title:nil leftBtn:@"取消" rightBtn:@"确定" delegate:aDelegate];
}

- (OTSDataAlertView *)alertCancelOK:(NSString *)aMessage title:(NSString *)aTitle delegate:(id)aDelegate
{
    return [self alert:aMessage title:aTitle leftBtn:@"取消" rightBtn:@"确定" delegate:aDelegate];
}

- (OTSDataAlertView *)alert:(NSString *)aMessage title:(NSString *)aTitle leftBtn:(NSString *)aString rightBtn:(NSString *)bString delegate:(id)aDelegate
{
    OTSDataAlertView *alert = [[OTSDataAlertView alloc] initWithTitle:aTitle
                                                    message:aMessage
                                                   delegate:aDelegate
                                          cancelButtonTitle:aString
                                          otherButtonTitles:bString, nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
	[NSString stringWithFormat:@"%2$@ %1$@", @"1st", @"2nd"];
	return alert;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(OTSDataAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.alertShowing = NO;
	NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
	if ([buttonTitle isEqualToString:OTSSTRING(@"确定")]) {
		[self postNotification:OTS_ALERT_ENSURE];
	}else if([buttonTitle isEqualToString:OTSSTRING(@"取消")]){
		[self postNotification:OTS_ALERT_CANCLE];
	}
}

@end
