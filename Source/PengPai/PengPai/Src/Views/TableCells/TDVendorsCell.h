//
//  TDVendorsCell.h
//  UnionpayCard
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TDVendorsCellDelegate<NSObject>
-(void)clickApply:(NSInteger)index cell:(UITableViewCell*)cell;
@end

@interface TDVendorsCell : UITableViewCell
@property(nonatomic,assign)id<TDVendorsCellDelegate> delegate;
@property(nonatomic,retain)UIImageView   * imgView;
@property(nonatomic,retain)UILabel       * titleLab;
@property(nonatomic,retain)UILabel       * textLab;
@property(nonatomic,retain)UILabel       * zCountLab;
@property(nonatomic,retain)UILabel       * zLab;
@property(nonatomic,retain)UILabel       * detailLab;
@property(nonatomic,retain)UILabel       * remainSumLab;
@property(nonatomic,retain)UILabel       * remainSumTextLab;
@property(nonatomic,retain)UIButton      * applyBtn;
-(void)displayCell:(NSDictionary *)tempDic index:(NSInteger)tag;
-(void)show;
-(void)hide;
-(void)hideAll;
@end
