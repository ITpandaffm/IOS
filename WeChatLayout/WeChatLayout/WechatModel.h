//
//  WechatModel.h
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WechatModel : UIView

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *say;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)WechatModelWithDict:(NSDictionary *)dict;

@end
