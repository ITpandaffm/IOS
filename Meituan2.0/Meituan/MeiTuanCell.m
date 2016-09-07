//
//  MeiTuanCell.m
//  Meituan
//
//  Created by ffm on 16/8/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "MeiTuanCell.h"

@interface MeiTuanCell ()

@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *soldAmount;
@property (weak, nonatomic) IBOutlet UILabel *location;

@end

@implementation MeiTuanCell

- (void)setModel:(FoodModel *)model
{
    if (_model != model)
    {
        _model = model;
        self.pic.image = [UIImage imageNamed:model.pic];
        self.name.text = model.name;
        self.price.text = model.price;
        self.soldAmount.text = model.soldAmount;
        self.location.text = model.location;
    }
}

+ (instancetype)createCell: (UITableView *)tableView
{
    static NSString *identifier = @"myCell";
    MeiTuanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MeiTuanCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
@end
