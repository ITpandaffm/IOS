//
//  singerModel.m
//  singerLayout
//
//  Created by ffm on 16/7/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "SingerModel.h"

@implementation SingerModel

- (instancetype)initWithDict: (NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)singerModelWithDict: (NSDictionary *)dict
{
    return [[SingerModel alloc] initWithDict:dict];
}

@end
