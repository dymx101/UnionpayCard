//
//  TDJsonParser.m
//  UnionpayCard
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDJsonParser.h"
#import "NSObject+JsonToVO.h"

@implementation TDJsonParser

/**
 *  功能:对json数据进行解析
 */
+ (NSObject *)parseData:(id)aJsonData;
{
    //将dictionary转成vo
    return [TDJsonParser toVOWithDictionary:aJsonData];
}

/**
 *  将服务器返回的数据型映射为本地VO对象
 */
+ (id)toVOWithDictionary:(NSDictionary *)dic
{
    //本地VO实体类的名称
    NSString *voName;
    id dataDic = [dic objectForKey:@"showtable"];
    
    //不跟VO实体类关联
    if (dataDic == nil) {
        return dic;
    }
    
    //返回的data键所对应的value数据类型的判断
    if ([dataDic isKindOfClass:[NSDictionary class]])
    {
        voName = [NSObject classNameWithDictionary:dataDic];
        if (voName)
        {
            id theVO = [[NSClassFromString(voName) alloc] initWithMyDictionary:dataDic];
            return theVO;
        }
        else
        {
            return dataDic;
        }
    }
    else if([dataDic isKindOfClass:[NSArray class]])
    {
        return [NSObject setListWithArray:dataDic];
    }
    else
    {
        return dataDic;
    }
}

@end
