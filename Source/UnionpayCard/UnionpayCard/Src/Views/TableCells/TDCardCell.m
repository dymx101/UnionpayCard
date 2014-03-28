//
//  TDCardCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/2/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCardCell.h"
#import "UtocardVO.h"

#define MY_HEIGHT   (75)

@interface TDCardCell () {
    UIView              *_bgView;
    UIImageView         *_ivPhoto;
    UILabel             *_lblTitle;
    UILabel             *_lblCardNumber;
    UILabel             *_lblBalanceTitle;
    UILabel             *_lblBalanceValue;
    UILabel             *_lbl;
}

@end

@implementation TDCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createViews];
        [self layoutViews];
    }
    return self;
}

-(void)createViews {
    //
    _bgView = [UIView new];
    _bgView.backgroundColor = [FDColor sharedInstance].silver;
    [self.contentView addSubview:_bgView];
    [_bgView alignToView:self.contentView];
    _bgView.hidden = YES;
    
    _ivPhoto = [UIImageView new];
//    _ivPhoto.image = [UIImage imageNamed:@"vendor_sample"];
    [self.contentView addSubview:_ivPhoto];
    
    //
    _lblTitle = [UILabel new];
    _lblTitle.font = [TDFontLibrary sharedInstance].fontLargeBold;
    _lblTitle.text = @"仟吉西饼";
    _lblTitle.textColor = [FDColor sharedInstance].darkGray;
    [self.contentView addSubview:_lblTitle];
    
    //
    _lblCardNumber = [UILabel new];
    _lblCardNumber.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblCardNumber.text = @"[卡号] 40088877665544";
    _lblCardNumber.textColor = [FDColor sharedInstance].darkGray;
    [self.contentView addSubview:_lblCardNumber];
    
    
    
    //
    _lblBalanceTitle = [UILabel new];
    _lblBalanceTitle.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblBalanceTitle.text = @"余额 : ";
    _lblBalanceTitle.textColor = [FDColor sharedInstance].darkGray;
    [self.contentView addSubview:_lblBalanceTitle];
    
    
    
    //
    _lblBalanceValue = [UILabel new];
    _lblBalanceValue.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblBalanceValue.text = @"￥250.00";
    _lblBalanceValue.textColor = [FDColor sharedInstance].darkGray;
    [self.contentView addSubview:_lblBalanceValue];
    
    _lbl = [UILabel new];
    _lbl.font = [TDFontLibrary sharedInstance].fontSmall;
    _lbl.text = @"点中即可消费";
    _lbl.textColor = [FDColor sharedInstance].cerulean;
    [self.contentView addSubview:_lbl];
    
    //
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [FDColor sharedInstance].silver;
    [self.contentView addSubview:bottomLine];
    [bottomLine constrainHeight:@"1"];
    [bottomLine alignBottomEdgeWithView:self.contentView predicate:nil];
    [bottomLine alignCenterXWithView:self.contentView predicate:nil];
    [bottomLine constrainWidthToView:self.contentView predicate:nil];
}

-(void)layoutViews {
    [_ivPhoto constrainWidth:@"90" height:@"60"];
    [_ivPhoto alignCenterYWithView:self.contentView predicate:nil];
    [_ivPhoto alignLeadingEdgeWithView:self.contentView predicate:@"10"];
    
    [_lblTitle alignTopEdgeWithView:_ivPhoto predicate:@"0"];
    [_lblTitle constrainLeadingSpaceToView:_ivPhoto predicate:@"10"];
    
    [_lblCardNumber constrainTopSpaceToView:_lblTitle predicate:@"5"];
    [_lblCardNumber alignLeadingEdgeWithView:_lblTitle predicate:nil];
    
    [_lblBalanceTitle constrainTopSpaceToView:_lblCardNumber predicate:@"5"];
    [_lblBalanceTitle alignLeadingEdgeWithView:_lblTitle predicate:nil];
    
    [_lblBalanceValue alignTopEdgeWithView:_lblBalanceTitle predicate:nil];
    [_lblBalanceValue constrainLeadingSpaceToView:_lblBalanceTitle predicate:@"0"];
    
    [_lbl alignTopEdgeWithView:_lblBalanceValue predicate:nil];
    [_lbl constrainLeadingSpaceToView:_lblBalanceValue predicate:@"5"];
}

- (NSCache *)UpdateCardInfo:(UtocardVO *) Utocard addCache:(NSCache *) __cache {
    //1
       __weak UIImageView * weakivphone = _ivPhoto;
    [_ivPhoto setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@active/upload/shop/%@",BASEURL,Utocard.b_cordimg]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [__cache setObject:weakivphone.image forKey:Utocard.b_cordimg];
    }];

    //2
    _lblTitle.text = Utocard.b_jname;
    //3
    _lblCardNumber.text = [NSString stringWithFormat:@"[卡号] %@",Utocard.u_card];
    //4
    _lblBalanceValue.text = [NSString stringWithFormat:@"%@",Utocard.card_balance];
    return __cache;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    _bgView.hidden = !highlighted;
}

#pragma mark - style

+(float)HEIGHT {
    return MY_HEIGHT;
}

@end
