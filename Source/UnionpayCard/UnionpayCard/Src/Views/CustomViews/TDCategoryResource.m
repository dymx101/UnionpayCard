//
//  TDCategoryResource.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCategoryResource.h"

//

@implementation TDCategoryResource

+(UIImage *)imageSelected:(ETDCateType)aCateType {
    switch (aCateType) {
        case kCateTypeAll:
            return [UIImage imageNamed:@"icon_cate_selected_-1.png"];
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

+(UIImage *)imageNormal:(ETDCateType)aCateType {
    switch (aCateType) {
        case kCateTypeAll:
            return [UIImage imageNamed:@"icon_cate_normal_-1.png"];
            break;
            
        default:
            break;
    }
    
    return nil;
}

+(NSString *)title:(ETDCateType)aCateType {
    switch (aCateType) {
        case kCateTypeAll:
            return @"全部分类";
            break;
            
        default:
            break;
    }
    
    return nil;
}

@end
