//
//  TDVendorsVC.h
//  UnionpayCard
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDBaseVC.h"
#import "TDVendorsCell.h"
@interface TDVendorsVC : TDBaseVC<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TDVendorsCellDelegate,UISearchBarDelegate>
@property(nonatomic,retain)NSString  * strBC_ID;

@end
