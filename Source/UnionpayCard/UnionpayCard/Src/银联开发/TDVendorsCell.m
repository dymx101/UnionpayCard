//
//  TDVendorsCell.m
//  UnionpayCard
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDVendorsCell.h"
#import <QuartzCore/QuartzCore.h>
#import "httpRequest.h"
@implementation TDVendorsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 106.0, 62.0)];
        self.imgView.image = [UIImage imageNamed:@"Icon-72"];
        self.imgView.layer.cornerRadius = 5.0;
        [self.contentView addSubview:self.imgView];
        
        self.titleLab = [self createLabel:CGRectMake(124.0, 10.0, 85.0, 21.0) fontSize:17.0];
        self.titleLab.font = [UIFont boldSystemFontOfSize:17.0];
        self.titleLab.text = @"皇家蛋糕店";
        [self.contentView addSubview:self.titleLab];
        
        self.textLab = [self createLabel:CGRectMake(124.0, 29.0, 68.0, 21.0) fontSize:11.0];
        self.textLab.text = @"发卡张数:";
        [self.contentView addSubview:self.textLab];
        
        self.zCountLab = [self createLabel:CGRectMake(173.0, 29.0, 60.0, 21.0) fontSize:11.0];
        self.zCountLab.textColor = [UIColor redColor];
        self.zCountLab.text = @"321";
        [self.contentView addSubview:self.zCountLab];
        
        self.zLab = [self createLabel:CGRectMake(173.0, 29.0, 17.0, 21.0) fontSize:11.0];
        self.zLab.text = @"张";
        [self.contentView addSubview:self.zLab];
        
        self.remainSumTextLab = [self createLabel:CGRectMake(230.0, 29.0, 68.0, 21.0) fontSize:11.0];
        self.remainSumTextLab.text = @"帐户余额:";
        [self.contentView addSubview:self.remainSumTextLab];
        
        self.remainSumLab = [self createLabel:CGRectMake(278.0, 29.0, 60.0, 21.0) fontSize:11.0];
        self.remainSumLab.text = @"800.00";
        self.remainSumLab.textColor = [UIColor redColor];
        [self.contentView addSubview:self.remainSumLab];
        
        self.detailLab = [self createLabel:CGRectMake(123.0, 42.0, 186.0, 34.0) fontSize:11.0];
        self.detailLab.numberOfLines = 0;
        self.detailLab.text = @"张张张张张张张张张张张张张张张张张张张张张张张张张张张";
        [self.contentView addSubview:self.detailLab];
        
        self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.applyBtn setBackgroundImage:[UIImage imageNamed:@"apply"] forState:UIControlStateNormal];
        self.applyBtn.frame = CGRectMake(266.0, 10.0, 50.0, 30.0);
        [self.applyBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.applyBtn];
    }
    return self;
}
-(void)displayCell:(NSDictionary *)tempDic index:(NSInteger)tag{
    _applyBtn.tag = tag;
    self.titleLab.text = [tempDic objectForKey:@"b_name"];
    self.zCountLab.text = [NSString stringWithFormat:@"%@",[tempDic objectForKey:@"cord_num"]];
    CGSize  size = [self.zCountLab.text sizeWithFont:[UIFont systemFontOfSize:11.0]];
    CGRect  labFrame = self.zLab.frame;
    labFrame.origin.x += size.width;
    self.zLab.frame = labFrame;
    NSString * strDetail = [NSString stringWithFormat:@"发卡总数:%@",[tempDic objectForKey:@"b_recharge"]];
    NSData  * imgData = [NSData dataWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent:[tempDic objectForKey:@"b_img"]]];
    if(imgData){
        self.imgView.image = [UIImage imageWithData:imgData];
    }else{
        [httpRequest getImageData:[NSString stringWithFormat:imageUrl,[tempDic objectForKey:@"b_cordimg"]] completionBlock:^(id responseObject) {
            if(responseObject){
                self.imgView.image = [UIImage imageWithData:responseObject];
            }
        }];
    }
    self.detailLab.text = strDetail;
}
-(void)show{
    self.applyBtn.hidden = NO;
    self.remainSumLab.hidden = YES;
    self.remainSumTextLab.hidden = YES;
}
-(void)hide{
    self.applyBtn.hidden = YES;
    self.remainSumLab.hidden = NO;
    self.remainSumTextLab.hidden = NO;
}
-(UILabel*)createLabel:(CGRect)frame fontSize:(CGFloat)size{
    UILabel  * label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:size];
    return label;
}
-(void)click:(UIButton*)btn{
    if([_delegate respondsToSelector:@selector(clickApply:)]){
        [_delegate clickApply:btn.tag];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
