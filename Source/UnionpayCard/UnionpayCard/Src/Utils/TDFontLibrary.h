//
//  TDFontLibrary.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFontLibrary : NSObject
AS_SINGLETON(TDFontLibrary)

@property (nonatomic, strong) UIFont    *fontTileButton;
@end