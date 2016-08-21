//
//  WechatCellTableViewCell.h
//  customerCell
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WechatModel.h"
@interface WechatCellTableViewCell : UITableViewCell

@property (nonatomic, strong) WechatModel *model;
+ (instancetype)creatCell: (UITableView *)tableView;


@end
