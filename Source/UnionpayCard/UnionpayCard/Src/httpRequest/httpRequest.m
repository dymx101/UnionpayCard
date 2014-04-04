//
//  httpRequest.m
//  bhtrader
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 InvestGu. All rights reserved.
//

#import "httpRequest.h"

@implementation httpRequest
-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}
-(NSMutableURLRequest *)publicModel:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode{
    strUrl = [strUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    if(strParam == nil){
        strParam = @"";
    }
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
	NSString *msgLen =[[NSString alloc] initWithFormat:@"%d", [strParam length]];
    urlRequest.timeoutInterval=10;
	[urlRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[urlRequest addValue:msgLen forHTTPHeaderField:@"Content-Length"];
	[urlRequest setHTTPMethod:strMethod];
	[urlRequest setHTTPBody:[strParam dataUsingEncoding:NSUTF8StringEncoding]];
    return urlRequest;
}
/**
 *  获取数组数据
 */
+(void)getArrayData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock{
    httpRequest  * http = [httpRequest new];
    NSMutableURLRequest  * urlRequest = [http publicModel:strUrl param:strParam requestMethod:strMethod encodeType:encode];
    [NSURLConnection  sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString  * strResult;
        if(connectionError){
            NSLog(@"发送连接请求失败！");
        }else if(data){
            strResult = [[NSString alloc]initWithData:data encoding:encode];
            if(strResult){
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSData * resultData = [strResult dataUsingEncoding:encode];
                NSArray * resultArray = [NSJSONSerialization  JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completionBlock){
                        completionBlock(resultArray);
                    }
                });
            }
        }
    }];
}
/**
 *  获取字典数据
 */
+(void)getDictionaryData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock{
    httpRequest  * http = [httpRequest new];
    NSMutableURLRequest  * urlRequest = [http publicModel:strUrl param:strParam requestMethod:strMethod encodeType:encode];
    [NSURLConnection  sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString  * strResult;
        if(connectionError){
            NSLog(@"发送连接请求失败！");
        }else if(data){
            strResult = [[NSString alloc]initWithData:data encoding:encode];
            if(strResult){
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSData * resultData = [strResult dataUsingEncoding:encode];
                NSDictionary * resultDictionary = [NSJSONSerialization  JSONObjectWithData:resultData options:NSJSONReadingMutableLeaves error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completionBlock){
                        completionBlock(resultDictionary);
                    }
                });
            }
        }
    }];
}
/**
 *  获取字符串数据
 */
+(void)getStringData:(NSString*)strUrl param:(NSString*)strParam requestMethod:(NSString*)strMethod encodeType:(NSInteger)encode completionBlock:(TDCompletionBlock)completionBlock{
    httpRequest  * http = [httpRequest new];
    NSMutableURLRequest  * urlRequest = [http publicModel:strUrl param:strParam requestMethod:strMethod encodeType:encode];
    [NSURLConnection  sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString  * strResult;
        if(connectionError){
            NSLog(@"发送连接请求失败！");
        }else if(data){
            strResult = [[NSString alloc]initWithData:data encoding:encode];
            if(strResult){
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                strResult = [strResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completionBlock){
                        completionBlock(strResult);
                    }
                });
            }
        }
    }];
}
/**
 *  获取图像数据
 */
+(void)getImageData:(NSString*)strUrl completionBlock:(TDCompletionBlock)completionBlock{
    strUrl = [strUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            NSLog(@"下载图片失败");
        }else if (data){
            NSString  * cachePath = [NSTemporaryDirectory() stringByAppendingPathComponent:strUrl];
            [data writeToFile:cachePath atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(completionBlock){
                    completionBlock(data);
                }
            });
        }
    }];
}
@end
