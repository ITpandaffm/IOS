//
//  studentModel.h
//  UsePlist
//
//  Created by ffm on 16/7/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface studentModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) studentModel *studentFriend;

-(instancetype) initWithDic: (NSDictionary *)dict;
+(instancetype) studentModelWithDic: (NSDictionary *)dict;



@end
