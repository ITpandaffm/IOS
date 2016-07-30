//
//  studentModel.m
//  UsePlist
//
//  Created by ffm on 16/7/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "studentModel.h"

@implementation studentModel

- (instancetype)initWithDic:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        self.name = dict[@"name"];
//        self.sex = [dict objectForKey:@"sex"];
//        self.age = [dict[@"age"] intValue];
        
        /**
         *  使用kvc一行代码可以替换上面3行
         */
        [self setValuesForKeysWithDictionary:dict];
    }
    
    
    return self;
}

+ (instancetype)studentModelWithDic:(NSDictionary *)dict
{
    return [[studentModel alloc]initWithDic:dict];
}


@end
