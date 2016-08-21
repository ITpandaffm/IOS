//
//  wechatModel.h
//  customerCell
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WechatModel : UIView

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *say;
@property (nonatomic, copy) NSString *sayTime;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)wechatModelWithDIct: (NSDictionary *)dict;

@end
