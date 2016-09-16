//
//  DiscoverViewController.m
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [self.myTableView reloadData];
    // Do any additional setup after loading the view.
}

#pragma mark - myTableView懒加载
- (UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45) style:UITableViewStyleGrouped];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 || section ==3)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self cellSetup:cell cellForRowAtIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    return cell;
}

- (void)cellSetup:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"ff_IconShowAlbum.png"];
        cell.textLabel.text = @"朋友圈";
    } else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"ff_IconQRCode.png"];
            cell.textLabel.text = @"扫一扫";
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"ff_IconShake.png"];
            cell.textLabel.text = @"摇一摇";
        }
    } else if (indexPath.section == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"ff_IconLocationService.png"];
        cell.textLabel.text = @"附近的人";
    } else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            cell.imageView.image = [UIImage imageNamed:@"CreditCard_ShoppingBag.png"];
            cell.textLabel.text = @"购物";
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"MoreGame.png"];
            cell.textLabel.text = @"游戏";
        }
    }
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
