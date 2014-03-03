//
//  TDRecordCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/3/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRecordCell.h"
#import "UIView+Effect.h"

#define  MY_HEIGHT      (100)

@interface TDRecordCell () {
    
}
@property (nonatomic, strong) UIView   *bgView;

@end

@implementation TDRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createViews];
    }
    return self;
}

-(void)createViews {
    _bgView = [UIView new];
    _bgView.backgroundColor = [FDColor sharedInstance].white;
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.borderWidth = 1;
    _bgView.layer.borderColor = [FDColor sharedInstance].silver.CGColor;
    
    [self addSubview:_bgView];
    [_bgView alignTop:@"2" leading:@"5" bottom:@"-2" trailing:@"-5" toView:self];
}

+(float)HEIGHT {
    return MY_HEIGHT;
}

@end
