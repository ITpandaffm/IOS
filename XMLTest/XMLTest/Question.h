//
//  Question.h
//  XMLTest
//
//  Created by ffm on 16/9/17.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property(nonatomic, copy)NSString *questionText;
@property(nonatomic, copy)NSString *rightAnswer;
@property(nonatomic, copy)NSString *optionA;
@property(nonatomic, copy)NSString *optionB;
@property(nonatomic, copy)NSString *optionC;
@property(nonatomic, copy)NSString *optionD;


@end
