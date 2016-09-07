//
//  MeiTuanCell.h
//  Meituan
//
//  Created by ffm on 16/8/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
@interface MeiTuanCell : UITableViewCell

@property (nonatomic, strong) FoodModel *model;

+ (instancetype) createCell:(UITableView *)tabelView;

@end
