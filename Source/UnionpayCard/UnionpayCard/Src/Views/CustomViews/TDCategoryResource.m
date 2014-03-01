//
//  TDCategoryResource.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/1/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCategoryResource.h"

//
//, kCateTypeMovie
//, kCateTypeLeisure
//, kCateTypeFood
//, kCateTypeHotel
//, kCateTypeLife
//, kCateTypeShopping
//, kCateTypeTravel
//, kCateTypeAuto

@implementation TDCategoryResource

+(UIImage *)imageSelected:(ETDCateType)aCateType {
    switch (aCateType) {
        case kCateTypeAll:
            return [UIImage imageNamed:@"icon_cate_selected_-1.png"];
            
        case kCateTypeMovie:
            return [UIImage imageNamed:@"icon_cate_selected_99.png"];
            
        case kCateTypeLeisure:
            return [UIImage imageNamed:@"icon_cate_selected_2.png"];
            
        case kCateTypeFood:
            return [UIImage imageNamed:@"icon_cate_selected_1.png"];
            
        case kCateTypeHotel:
            return [UIImage imageNamed:@"icon_cate_selected_20.png"];
            
        case kCateTypeLife:
            return [UIImage imageNamed:@"icon_cate_selected_3.png"];
            
        case kCateTypeShopping:
            return [UIImage imageNamed:@"icon_cate_selected_0.png"];
            
        case kCateTypeTravel:
            return [UIImage imageNamed:@"icon_cate_selected_78.png"];
            
        case kCateTypeAuto:
            return [UIImage imageNamed:@"icon_cate_selected_4.png"];
    }
    
    return nil;
}

+(UIImage *)imageNormal:(ETDCateType)aCateType {
    
    switch (aCateType) {
        case kCateTypeAll:
            return [UIImage imageNamed:@"icon_cate_normal_-1.png"];
            
        case kCateTypeMovie:
            return [UIImage imageNamed:@"icon_cate_normal_99.png"];
            
        case kCateTypeLeisure:
            return [UIImage imageNamed:@"icon_cate_normal_2.png"];
            
        case kCateTypeFood:
            return [UIImage imageNamed:@"icon_cate_normal_1.png"];
            
        case kCateTypeHotel:
            return [UIImage imageNamed:@"icon_cate_normal_20.png"];
            
        case kCateTypeLife:
            return [UIImage imageNamed:@"icon_cate_normal_3.png"];
            
        case kCateTypeShopping:
            return [UIImage imageNamed:@"icon_cate_normal_0.png"];
            
        case kCateTypeTravel:
            return [UIImage imageNamed:@"icon_cate_normal_78.png"];
            
        case kCateTypeAuto:
            return [UIImage imageNamed:@"icon_cate_normal_4.png"];
    }
    
    return nil;
}

+(NSString *)title:(ETDCateType)aCateType {
    
    switch (aCateType) {
        case kCateTypeAll:
            return @"全部分类";
            
        case kCateTypeMovie:
            return @"电影";
            
        case kCateTypeLeisure:
            return @"休闲娱乐";
            
        case kCateTypeFood:
            return @"美食";
            
        case kCateTypeHotel:
            return @"酒店";
            
        case kCateTypeLife:
            return @"生活服务";
            
        case kCateTypeShopping:
            return @"购物";
            
        case kCateTypeTravel:
            return @"旅游";
            
        case kCateTypeAuto:
            return @"汽车";
    }
    
    return nil;
}

+(NSArray *)alltypes {
    return @[@(kCateTypeAll), @(kCateTypeMovie), @(kCateTypeLeisure), @(kCateTypeFood)
             , @(kCateTypeHotel), @(kCateTypeLife), @(kCateTypeShopping), @(kCateTypeTravel), @(kCateTypeAuto)];
}

@end
