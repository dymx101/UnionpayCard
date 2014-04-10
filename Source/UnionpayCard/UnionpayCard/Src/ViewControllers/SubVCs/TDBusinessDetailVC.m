//
//  TDBusinessDetailVC.m
//  UnionpayCard
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDBusinessDetailVC.h"
#import "httpRequest.h"
#import "TDJsonToDictionary.h"
@interface TDBusinessDetailVC (){
    UIScrollView   * sv;
    UIScrollView   * imageSv;
    UIImageView    * imgView;
    CGFloat  Y;
    NSMutableArray * imageDataArr;
}
@property (nonatomic,strong)IBOutlet  UILabel * numLab1;
@property (nonatomic,strong)IBOutlet  UILabel * numLab2;
@property (nonatomic,strong)IBOutlet  UILabel * numLab5;
@property (nonatomic,strong)IBOutlet  UILabel * labRemainSun;
@property (nonatomic,strong)IBOutlet  UILabel * labRemainSunText;
@property (nonatomic,strong)IBOutlet  UILabel * labFullDetail;;
@property (nonatomic,strong)IBOutlet  UILabel * labZ;
@property (nonatomic,strong)IBOutlet  UILabel * labZCount;
@property (nonatomic,strong)IBOutlet  UILabel * labTitle;
@property (nonatomic,strong)IBOutlet  UILabel * labDetail;
@property (nonatomic,strong)IBOutlet  UILabel * labBusinessDetail;
@property (nonatomic,strong)IBOutlet  UIView  * openCardView;
@property (nonatomic,strong)IBOutlet  UIView  * useCardView;
@property (nonatomic,strong)IBOutlet  UIView  * businessDetailView;
@property (nonatomic,strong)IBOutlet  UIView  * fullCardView;
@property (nonatomic,strong)IBOutlet  UIButton * applyBtn;
-(IBAction)clickApplyBtn:(UIButton*)sender;
@end

@implementation TDBusinessDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageDataArr = [NSMutableArray array];
        self.navigationItem.title = @"商户详情";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _numLab1.text = [NSString stringWithFormat:@"本卡请在<%@>指定地点现场充值。",_strBName];
    _numLab2.text = [NSString stringWithFormat:@"如在用卡过程中有疑问请与<%@>联系，解决疑问时如出现分歧，可通过本平台进行协商处理。",_strBName];
    _numLab5.text = [NSString stringWithFormat:@"该预付费卡最终解释权归<%@>所有。",_strBName];
    self.applyBtn.hidden = _isShowApplyBtn;
    _labTitle.text = _strTitle;
    _labDetail.text = _strDetail;
    _labZCount.text = [NSString stringWithFormat:@"%@",_strZCount];
    CGSize  size = [_labZCount.text sizeWithFont:[UIFont systemFontOfSize:11.0]];
    CGRect  frame =  _labZ.frame ;
    frame.origin.x += size.width;
    _labZ.frame = frame;
    _labBusinessDetail.text = _strBusinessDetail;
    _labFullDetail.text = _strFullDetail;
    
    if(!_isRemainSum){
        _labRemainSun.text = [NSString stringWithFormat:@"%@",_strRemainSum];
    }else{
        _labRemainSun.hidden = YES;
        _labRemainSunText.hidden = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat  svHeight = 0;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0){
        svHeight = KSCREEN_HEIGHT - 44 - 50 - 20;
    }else{
        svHeight = KSCREEN_HEIGHT - 44 - 50;
    }
    sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0, 0.0, KSCREEN_WIDTH, svHeight)];
    sv.showsVerticalScrollIndicator = YES;
    sv.pagingEnabled = NO;
    [self.view addSubview:sv];
    
    CGRect  rect = _labTitle.frame;
    rect.origin.x = 5.0 , rect.origin.y = 5.0;
    _labTitle.frame = rect;
    [sv addSubview:_labTitle];
    imageSv = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0,rect.origin.y + rect.size.height , KSCREEN_WIDTH, 120.0)];
    imageSv.pagingEnabled = YES;
    imageSv.showsVerticalScrollIndicator = NO;
    imageSv.showsHorizontalScrollIndicator = NO;
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, KSCREEN_WIDTH, imageSv.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"icon-120"];
    [imageSv addSubview:imgView];
    [sv addSubview:imageSv];
    
    Y = imageSv.frame.origin.y + imageSv.frame.size.height;
    
    rect =  _labDetail.frame;
    rect.origin.x = 5.0,rect.origin.y = Y;
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2, FLT_MAX);
    CGSize  newSize = [_strDetail sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:maxSize];
    rect.size.height = newSize.height + 20;
    _labDetail.frame = rect;
    [sv addSubview:_labDetail];
    Y = _labDetail.frame.origin.y + _labDetail.frame.size.height;
    [sv addSubview:[self getLine:CGPointMake(0.0, Y)]];
    
    rect = _openCardView.frame;
    rect.origin.x = 0.0 , rect.origin.y = Y + 1;
    _openCardView.frame = rect;
    [sv addSubview:_openCardView];
    Y = _openCardView.frame.size.height + _openCardView.frame.origin.y;
    [sv addSubview:[self getLine:CGPointMake(0.0, Y)]];
    
    rect = _useCardView.frame;
    rect.origin.x = 0.0 , rect.origin.y = Y + 1;
    _useCardView.frame = rect;
    [sv addSubview:_useCardView];
    Y = _useCardView.frame.origin.y + _useCardView.frame.size.height;
    [sv addSubview:[self getLine:CGPointMake(0.0, Y)]];
    
    rect = _businessDetailView.frame;
    CGSize maxSize1 = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2, FLT_MAX);
    CGSize  newSize1 = [_strBusinessDetail sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:maxSize1];
    rect.size.height = newSize1.height + 30;
    rect.origin.x = 0.0 , rect.origin.y = Y + 1;
    _businessDetailView.frame = rect;
    CGRect  frame1 =  _labBusinessDetail.frame;
    frame1.size.height = rect.size.height;
    _labBusinessDetail.frame = frame1;
    [sv addSubview:_businessDetailView];
    Y = _businessDetailView.frame.origin.y + _businessDetailView.frame.size.height;
    [sv addSubview:[self getLine:CGPointMake(0.0, Y)]];
    
    rect = _fullCardView.frame;
    CGSize maxSize2 = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2, FLT_MAX);
    CGSize  newSize2 = [_strBusinessDetail sizeWithFont:[UIFont systemFontOfSize:11.0] constrainedToSize:maxSize2];
    rect.size.height = newSize2.height + 30;
    rect.origin.x = 0.0 ,rect.origin.y = Y + 1;
    CGRect  frame2 =  _labFullDetail.frame;
    frame2.size.height = rect.size.height;
    _labFullDetail.frame = frame1;
    _fullCardView.frame = rect;
    [sv addSubview:_fullCardView];
    Y = _fullCardView.frame.origin.y + _fullCardView.frame.size.height;
    sv.contentSize = CGSizeMake(0.0, Y);
    [self showBusinessImage];
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UILabel*)getLine:(CGPoint)point{
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, KSCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    return line;
}
-(IBAction)clickApplyBtn:(UIButton*)sender{
    NSDictionary * strParamDic = @{@"method":@"Regcard",@"b_id":_strB_id,@"userToken":SharedToken};
    NSString  * strParam = [NSString stringWithFormat:@"url=%@",[TDJsonToDictionary jsonStringFromDictionary:strParamDic]];
    [httpRequest getDictionaryData:[NSString stringWithFormat:mainUrl,strParam] param:nil requestMethod:@"GET" encodeType:NSUTF8StringEncoding completionBlock:^(id responseObject) {
        if(responseObject){
            NSDictionary  * tempDic = (NSDictionary*)responseObject;
            NSString  *strResult = [tempDic objectForKey:@"State"];
            if([strResult isEqualToString:@"error"]){
                [self.view makeToast:@"申请失败"];
            }else if([strResult intValue] == 0){
                [self.view makeToast:@"申请成功"];
                _applyBtn.hidden = YES;
            }else if([strResult intValue] == 1){
                [self.view makeToast:@"已经申请了一张卡"];
            }else{
                [self.view makeToast:@"未知异常"];
            }
        }
    }];

}
#pragma mark - httpRquest
-(void)showBusinessImage{
#if 0
    NSInteger  count = _imageArr.count;
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [hud show:YES];
    for (int i = 0;i < count; i++) {
        NSString * imageName = [_imageArr objectAtIndex:i];
        [httpRequest getImageData:[NSString stringWithFormat:imageUrl,imageName] completionBlock:^(id responseObject) {
            if(responseObject){
                [imageDataArr addObject:[UIImage imageWithData:responseObject]];
                if(i == count -1){
                    for (int j =0 ; j < imageDataArr.count; j++) {
                        UIImageView  * tempIV = [[UIImageView alloc]initWithFrame:CGRectMake(j * KSCREEN_WIDTH, 0.0, KSCREEN_WIDTH, imageSv.frame.size.height)];
                        tempIV.image = [imageDataArr objectAtIndex:j];
                        [imageSv addSubview:tempIV];
                    }
                    imageSv.contentSize = CGSizeMake(imageDataArr.count * KSCREEN_WIDTH, 0.0);
                }
            }
            [hud hide:YES];
            [hud removeFromSuperview];
        }];
    }
#else
    MBProgressHUD * hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:hud];
    [hud show:YES];
    NSData  * imgData = [NSData dataWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent:_strImageName]];
    if(imgData){
        imgView.image = [UIImage imageWithData:imgData];
        [hud hide:YES];
    }else{
        [httpRequest getImageData:[NSString stringWithFormat:imageUrl,_strImageName] completionBlock:^(id responseObject) {
            if(responseObject){
                imgView.image = [UIImage imageWithData:responseObject];
            }
            [hud hide:YES];
            [hud removeFromSuperview];
        }];
    }


#endif
}

@end
