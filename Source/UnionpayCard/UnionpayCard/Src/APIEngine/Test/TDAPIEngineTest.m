//
//  TDAPIEngineTest.m
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDAPIEngineTest.h"
#import "TDJsonParser.h"
#import "Btype.h"
#import "Post.h"
#import "Userinfor.h"
#import "UtocardVO.h"

@implementation TDAPIEngineTest
+(void)run {
    [self testxxx];
}


+(void)testxxx {
    
    [TDHttpService showBtype:^(id responseObject) {
        if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray  * array = responseObject;
            for (Btype * byt in array) {
                NSLog(@">1 %@",byt);
            }
        }
    }];
    
    
//    __block NSString * token = nil;
//    __block Userinfor * user = nil;
//    [TDHttpService LoginUserinfor:@"s@qq.com" loginPass:@"123456" completionBlock:^(id responseObject) {
//        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]]) {
//            token = [responseObject objectForKey:@"userToken"];
//             [TDHttpService ShowcrrutUser:token completionBlock:^(id responseObject) {
//                 if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
//                     user = [responseObject lastObject];
//                     NSString * userId = [NSString stringWithFormat:@"%d",[user.u_id intValue]];
//                     [TDHttpService ShowUtocard:userId completionBlock:^(id responseObject) {
//                         if (responseObject != nil && [responseObject isKindOfClass:[NSArray class]]) {
//                             NSArray * array = responseObject;
//                             for (UtocardVO * utocard in array) {
//                                 NSLog(@">2 %@",utocard);
//                             }
//                         }
//                     }];
//                 }
//             }];
//        }
//    }];
    
    NSMutableArray * a111 = [NSMutableArray arrayWithArray: @[@2,@7,@4,@1,@5,@9,@3]];
//    @[@3,@4,@2,@1,@5,@7,@9];
    
    [self mergeSort:a111 start:0 end:6];
   NSLog(@"%@",a111);
//    NSLog(@"%@",[self mergeArray:a111 first:0 mid:3 last:6])
    ;
}

+ (void) mergeArray:(NSMutableArray *) aa first:(int)first  mid:(int)mid last:(int) last
{
    int i = first;
    int m = mid;
    
    int j= m;
    int n = last;
    int k = 0;
    
    NSMutableArray * temp = [NSMutableArray new];
    
    while(i < m && j < n )
    {
//        NSLog(@" .1=%d .2=%d",[aa[i] integerValue],[aa[j] integerValue]);
        temp[k++] = @([aa[i] integerValue] < [aa[j] integerValue] ? [aa[i++] integerValue ]:[aa[j++] integerValue]);
//        NSLog(@" temp=%@",temp);
    }
    
    while (i < m) {
        temp[k++] = aa[i++];
    }
    
    while (j < n) {
        temp[k++] = aa[j++];
    }
    
    for (i = 0; i < k; i++) {
        aa[first + i]  = temp[i];
    }
}

+ (NSMutableArray *) mergeSort:(NSMutableArray *)a start:(int) start end:(int) end
{
    int mid=(start+end)/2;
    if(start<end){
        //分解
        [self mergeSort:a start:start end:mid];
        [self mergeSort:a start:mid+1 end:end];

        //合并
        [self mergeArray:a first:start mid:mid last:end];
    }
    return nil;
}

@end
