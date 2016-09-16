//
//  AddressBookTableViewCell.h
//  WeChatLayout
//
//  Created by ffm on 16/8/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatModel.h"

@interface AddressBookTableViewCell : UITableViewCell

@property (nonatomic, strong) WechatModel *model;
+ (instancetype)creatCell: (UITableView *)tableView;

@end
