//
//  WechatTableViewCell.m
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WechatTableViewCell.h"

@interface WechatTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sayLabel;



@end


@implementation WechatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)creatCell:(UITableView *)tableView
{
    static NSString *identifier = @"wechatCell";
    WechatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WechatTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setModel:(WechatModel *)model
{
    if (_model != model)
    {
        _model = model;
        self.iconView.image = [UIImage imageNamed:model.icon];
        self.nameLabel.text = model.name;
        self.sayLabel.text = model.say;
    }
}

@end
