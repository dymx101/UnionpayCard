//
//  TDCategoryResource.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kCateTypeAll = 0
}ETDCateType;

@interface TDCategoryResource : NSObject

+(UIImage *)imageSelected:(ETDCateType)aCateType;
+(UIImage *)imageNormal:(ETDCateType)aCateType;
+(NSString *)title:(ETDCateType)aCateType;

@end
