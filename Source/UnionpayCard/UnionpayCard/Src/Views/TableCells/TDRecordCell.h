//
//  TDRecordCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/3/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDRecordCell : UITableViewCell
@property (nonatomic, strong) UILabel   *lblVendorName;
@property (nonatomic, strong) UILabel   *lblCardNumber;
@property (nonatomic, strong) UILabel   *lblAmount;
@property (nonatomic, strong) UILabel   *lblFlowNumber;
@property (nonatomic, strong) UIButton  *btnFreeze;

+(float)HEIGHT;

@end
