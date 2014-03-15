//
//  TDUtil.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDUtil.h"

@implementation TDUtil

+(void)findFonts {
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSArray* fontFiles = [infoDict objectForKey:@"UIAppFonts"];
    
    for (NSString *fontFile in fontFiles) {

        NSLog(@"file name: %@", fontFile);
        NSURL *url = [[NSBundle mainBundle] URLForResource:fontFile withExtension:NULL];
        NSData *fontData = [NSData dataWithContentsOfURL:url];
        CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)fontData);
        CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
        NSString *fullName = CFBridgingRelease(CGFontCopyFullName(loadedFont));
        CGFontRelease(loadedFont);
        CGDataProviderRelease(fontDataProvider);
        NSLog(@"font name: %@", fullName);
    }

}

+(BOOL)isIOS7 {
    return NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1;
}

+(UIButton *)checkBoxWithTitle:(NSString *)aTitle target:(id)aTarget action:(SEL)anAction {
    UIButton *btn = [UIButton new];
    //btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:aTitle forState:UIControlStateNormal];
    [btn setImage:[TDImageLibrary sharedInstance].boxUnchecked forState:UIControlStateNormal];
    [btn setImage:[TDImageLibrary sharedInstance].boxChecked forState:UIControlStateSelected];
    [btn addTarget:aTarget action:anAction forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [btn setTitleColor:[FDColor sharedInstance].black forState:UIControlStateNormal];
    
    return btn;
}

+(ETDCellStyle)cellStyleWithIndexPath:(NSIndexPath *)aIndexPath tableView:(UITableView *)aTableView tableViewDataSource:(id<UITableViewDataSource>)aTableViewDataSource {
    
    int section = aIndexPath.section;
    int row = aIndexPath.row;
    
    int count = [aTableViewDataSource tableView:aTableView numberOfRowsInSection:section];
    if (count > 1) {
        if (row == 0) {
            return kTDCellStyleTop;
        } else if (row == count - 1) {
            return kTDCellStyleBottom;
        } else {
            return kTDCellStyleMiddle;
        }
    }
    
    return kTDCellStyleRound;
}

@end
