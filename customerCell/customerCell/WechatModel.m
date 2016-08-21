//
//  wechatModel.m
//  customerCell
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WechatModel.h"

@implementation WechatModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)wechatModelWithDIct:(NSDictionary *)dict
{
    return [[WechatModel alloc] initWithDict:dict];
}


@end
