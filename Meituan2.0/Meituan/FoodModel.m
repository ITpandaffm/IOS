//
//  FoodModel.m
//  Meituan
//
//  Created by ffm on 16/8/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "FoodModel.h"

@implementation FoodModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)FoodModelWithDict:(NSDictionary *)dict
{
    return [[FoodModel alloc] initWithDict:dict];
}


@end
