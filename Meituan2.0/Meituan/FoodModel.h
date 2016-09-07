//
//  FoodModel.h
//  Meituan
//
//  Created by ffm on 16/8/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *soldAmount;
@property (nonatomic, copy)NSString *location;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)FoodModelWithDict: (NSDictionary *)dict;
@end
