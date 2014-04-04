//
//  httpRequest.h
//  bhtrader
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 InvestGu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define mainUrl @"http://www.ponpay.com/apps_android.php?%@"
#define imageUrl @"http://www.ponpay.com/active/upload/shop/%@"
typedef void(^TDCompletionBlock)(id responseObject);
@interface httpRequest : NSObject
+(void)getArrayData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock;
+(void)getDictionaryData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock;
+(void)getStringData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock;
+(void)getImageData:(NSString*)strUrl completionBlock:(TDCompletionBlock)completionBlock;
@end
