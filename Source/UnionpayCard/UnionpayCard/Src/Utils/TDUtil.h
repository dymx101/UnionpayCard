//
//  TDUtil.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDUtil : NSObject
+(void)findFonts;
+(BOOL)isIOS7;
+(UIButton *)checkBoxWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)anAction;

+(ETDCellStyle)cellStyleWithIndexPath:(NSIndexPath *)aIndexPath
                            tableView:(UITableView *)aTableView
                  tableViewDataSource:(id<UITableViewDataSource>)aTableViewDataSource;

@end
