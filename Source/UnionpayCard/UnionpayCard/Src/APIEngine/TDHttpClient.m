//
//  TDHttpManager.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDHttpClient.h"

//http://localhost:8000/yscardII/json/Show/{"method":"showBtype"}
//static NSString *const BASEURL = @"http://localhost:8000/yscardII/json/";
// 外网地址
static NSString *const BASEURL = @"http://113.57.133.84:8081/yscardII/json/";

@implementation TDHttpClient

+ (TDHttpClient *)sharedClient {
    static TDHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:BASEURL];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TDHttpClient iOS 1.0"}];
        
        //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[TDHttpClient alloc] initWithBaseURL:baseURL
                                         sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return _sharedClient;
}

-(void)_handleResult:(id)responseObject
                task:(NSURLSessionDataTask *)task
               error:(NSError *)anError
            callback:(TDBlock)aCallback
{
    [self _logRawResponse:task];
    
    if (aCallback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            aCallback(task, responseObject, anError);
        });
    }
}

- (void)processCmd:(TDHttpCmd * ) cmd callback:(TDBlock)aCallback
{
    
    NSURLSessionDataTask * task = nil;
    if(!cmd)
        return;
    
    if ([cmd.method isEqualToString:@"GET"]) {
        task =  [self GET:cmd.path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            
            if (httpResponse.statusCode == 200) {
                [self _handleResult:responseObject task:task error:nil callback:aCallback];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self _handleResult:nil task:task error:error callback:aCallback];
        }];
    }
    else
    {
        task = [self POST:cmd.path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (httpResponse.statusCode == 200) {
                [self _handleResult:responseObject task:task error:nil callback:aCallback];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self _handleResult:nil task:task error:error callback:aCallback];
        }];
    }
    
    [task resume];
}

-(void)_logRawResponse:(NSURLSessionDataTask *) task
{
}

@end
