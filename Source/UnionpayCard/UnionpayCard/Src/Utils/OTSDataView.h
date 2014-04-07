//
//  OTSDataView.h
//  OneStore
//
//  Created by huang jiming on 13-2-21.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSDataView : UIView

@property (strong) id data;
@property (assign) long long idTag;

@end


@interface OTSDataButton : UIButton

@property (strong) id data;
@property (assign) long long idTag;

@end

@interface OTSDataImageView : UIImageView

@property (strong) id data;
@property (assign) long long idTag;

@end

@interface OTSDataAlertView : UIAlertView

@property (strong) id data;
@property (assign) long long idTag;

@end
