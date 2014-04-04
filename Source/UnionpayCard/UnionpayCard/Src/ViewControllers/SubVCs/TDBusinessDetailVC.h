//
//  TDBusinessDetailVC.h
//  UnionpayCard
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDBaseVC.h"

@interface TDBusinessDetailVC : TDBaseVC
@property(nonatomic,retain)NSString * strBName;
@property(nonatomic,retain)NSArray  * imageArr;
@property(nonatomic,retain)NSString * strTitle;
@property(nonatomic,retain)NSString * strDetail;
@property(nonatomic,retain)NSString * strBusinessDetail;
@property(nonatomic,retain)NSString * strZCount;
@property(nonatomic,retain)NSString * strImageName;
@property(nonatomic,retain)NSString * strFullDetail;
@property(nonatomic,retain)NSString * strRemainSum;
@property(nonatomic,retain)NSString * strB_id;
@property(nonatomic,assign)BOOL       isShowApplyBtn;
@property(nonatomic,assign)BOOL       isRemainSum;
@end
