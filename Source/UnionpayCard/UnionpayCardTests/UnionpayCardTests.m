//
//  UnionpayCardTests.m
//  UnionpayCardTests
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnionpayCardTests : XCTestCase

@end

@implementation UnionpayCardTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
       [TDHttpClient processCmd:[TDHttpCmd new] callback:^(NSURLSessionDataTask *task, id responseObject, NSError *anError) {
           NSLog(@">>%@",responseObject);
       }];
}

@end
