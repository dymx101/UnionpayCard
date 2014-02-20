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
@end
