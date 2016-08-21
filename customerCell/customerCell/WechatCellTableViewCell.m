//
//  WechatCellTableViewCell.m
//  customerCell
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WechatCellTableViewCell.h"

@interface WechatCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *say;
@property (weak, nonatomic) IBOutlet UILabel *sayTIme;

@end


@implementation WechatCellTableViewCell

+ (instancetype)creatCell: (UITableView *)tableView
{
    static NSString *identifier = @"myCell";
    WechatCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WechatCellTableViewCell" owner:nil options:nil] firstObject];
    }else{
        NSLog(@"hello world");
        
    }
    return cell;
}

- (void)setModel:(WechatModel *)model
{
    //用传入的模型给控件赋值
    if (_model != model)
    {
        _model = model;
        self.icon.image = [UIImage imageNamed:model.icon];
        self.name.text = model.name;
        self.say.text = model.say;
        self.sayTIme.text = model.sayTime;
        self.name.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.say.font = [UIFont fontWithName:@"Helvetica" size:13];
        self.sayTIme.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    
}

@end
