//
//  TDCardCell.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/2/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Utocard;


@interface TDCardCell : UITableViewCell
+(float)HEIGHT;
- (NSCache *)UpdateCardInfo:(Utocard *) Utocard addCache:(NSCache *) __cache;
@end
