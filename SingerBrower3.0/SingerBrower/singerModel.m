//
//  singerModel.m
//  SingerBrower
//
//  Created by ffm on 16/7/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "singerModel.h"

@implementation singerModel

- (instancetype)initWithDict: (NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];     //使用kvc一行代码完成
    }
    return self;
}

+ (instancetype)singerModelWithDict: (NSDictionary *)dict
{
    return [[singerModel alloc] initWithDict:dict];
}

@end
