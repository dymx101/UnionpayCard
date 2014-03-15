//
//  GNWebVC.m
//  GageinNew
//
//  Created by Dong Yiming on 3/12/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNWebVC.h"

#define WEB_PREFIX_HTTP     @"http://"
#define WEB_PREFIX_HTTPS     @"https://"

#define ZOOM_RATIO          (.6f)


@interface GNWebVC () <UIWebViewDelegate> {
    UIWebView       *_webview;
}

@end



@implementation GNWebVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _showUrlBar = YES;
    }
    return self;
}

-(void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    _webview.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    [self layoutViews];
}

-(void)initViews {
    _webview = [UIWebView new];
    _webview.delegate = self;
    _webview.scalesPageToFit = YES;
    [self.view addSubview:_webview];
    
    [self startRequest];
}

-(void)layoutViews {
    
    [_webview alignToView:self.view];
}

#pragma mark - start request
-(void)startRequest {
    if (_urlStr
        && [_urlStr rangeOfString:WEB_PREFIX_HTTP].location == NSNotFound
        && [_urlStr rangeOfString:WEB_PREFIX_HTTPS].location == NSNotFound)
    {
        _urlStr = [NSString stringWithFormat:@"%@%@", WEB_PREFIX_HTTP, _urlStr];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_webview loadRequest:request];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    DLog(@"webview loading: {%@}", _urlStr);
}

#pragma mark - web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end
