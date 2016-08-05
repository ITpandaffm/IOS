//
//  singerModel.h
//  SingerBrower
//
//  Created by ffm on 16/7/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singerModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *songName;
@property (nonatomic, copy) NSString *pic;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)singerModelWithDict: (NSDictionary *)dict;

@end
