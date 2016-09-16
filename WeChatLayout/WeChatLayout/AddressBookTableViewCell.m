//
//  AddressBookTableViewCell.m
//  WeChatLayout
//
//  Created by ffm on 16/8/22.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "AddressBookTableViewCell.h"

@interface AddressBookTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation AddressBookTableViewCell

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
    static NSString *myidentifier = @"AddressCell";
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myidentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressBookTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setModel:(WechatModel *)model
{
    if (_model != model)
    {
        _model = model;
        self.picView.image = [UIImage imageNamed:model.icon];
        self.userNameLabel.text = model.name;
    }
}



@end
