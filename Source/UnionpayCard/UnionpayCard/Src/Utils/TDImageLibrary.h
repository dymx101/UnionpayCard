//
//  TDImageLibrary.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDImageLibrary : NSObject
AS_SINGLETON(TDImageLibrary)

@property (nonatomic, strong) UIImage *logoName;
@property (nonatomic, strong) UIImage *btnBgOrange;
@property (nonatomic, strong) UIImage *mineAccountBg;
@property (nonatomic, strong) UIImage *btnBgWhite;
@property (nonatomic, strong) UIImage *btnBgGrayRound;
@property (nonatomic, strong) UIImage *btnBackArrow;
@property (nonatomic, strong) UIImage *dismiss;
@property (nonatomic, strong) UIImage *bgLoginInput;
@property (nonatomic, strong) UIImage *btnBgGreen;
@property (nonatomic, strong) UIImage *blank;

@property (nonatomic, strong) UIImage *cellGroupTop;
@property (nonatomic, strong) UIImage *cellGroupMiddle;
@property (nonatomic, strong) UIImage *cellGroupBottom;
@property (nonatomic, strong) UIImage *cellGroupRound;
@property (nonatomic, strong) UIImage *cellRightArrow;

@property (nonatomic, strong) UIImage *boxChecked;
@property (nonatomic, strong) UIImage *boxUnchecked;

@end
