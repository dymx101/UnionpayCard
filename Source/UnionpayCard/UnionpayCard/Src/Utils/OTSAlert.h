//
//  OTSAlert.h
//  OneStore
//
//  Created by Yim Daniel on 13-1-16.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSDataView.h"

@interface OTSAlert : NSObject
AS_SINGLETON(OTSAlert)

@property(nonatomic, assign) BOOL alertShowing;//是否已弹出alert view

/**
 *  功能:返回一个alert view
 */
- (OTSDataAlertView *)alertViewWithMessage:(NSString *)aMessage delegate:(id)aDelegate buttons:(NSString *)btn,...NS_REQUIRES_NIL_TERMINATION;

/**
 *  功能:弹出一个alert view
 */
- (void)alert:(NSString *)aMessage;

/**
 *  功能:弹出一个alert view
 */
- (void)alert:(NSString *)aMessage andInterfaceName:(NSString *)name;

/**
 *  功能:弹出一个alert view
 */
- (void)alertNetError;

/**
 *  功能:弹出一个alert view
 */
- (void)alertNetErrorWithInterfaceName:(NSString *)name;

/**
 *  功能:弹出一个alert view
 */
- (void)alertServerError;

/**
 *  功能:弹出一个alert view
 */
- (void)alertServerErrorWithInterfaceName:(NSString *)name;

/**
 *  功能:弹出一个alert view
 */
- (void)alertWithServerReturnMessage:(NSString *)aMessage;

/**
 *  功能:返回一个alert view，并弹出
 */
- (OTSDataAlertView *)alert:(NSString *)aMessage delegate:(id)aDelegate;

/**
 *  功能:返回一个alert view，并弹出
 */
- (OTSDataAlertView *)alertCancelOK:(NSString *)aMessage delegate:(id)aDelegate;

/**
 *  功能:返回一个alert view，并弹出
 */
- (OTSDataAlertView *)alertCancelOK:(NSString *)aMessage  title:(NSString *)aTitle  delegate:(id)aDelegate;

/**
 *  功能:返回一个alert view，并弹出
 */
- (OTSDataAlertView *)alert:(NSString *)aMessage title:(NSString *)aTitle leftBtn:(NSString *)aString rightBtn:(NSString *)bString delegate:(id)aDelegate;
@end
