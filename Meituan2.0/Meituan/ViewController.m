//
//  ViewController.m
//  Meituan
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
/**
 *  设计一个plist文件，用来保存团购信息，至少包括以下项目 团购项目名称 价格 图片 已经购买份数等项目，使用字典转模型及kvc把所有团购信息读到系统，并在UITableview上展示团购信息。要求使用自定义UITableviewCell实现
 */
/**
 *  要定义一个UIView * 属性 来赋值给tableView.tableHeaderView
    不然直接去给tableView.tableHeaderView赋值设置frame的话 会挡住cell..!
 */
/**
 *  为了使用点击某行的方法, 特地搬出来之前歌手浏览器那个 下载完成的小动画,但是好像不灵验了,只灵验一次...有点不爽,不过还没学到那 这口气就先忍了
    8.4更新解决,忽略了透明度的问题, 其实动画是有的  但是只是因为透明度设为0了没有重新设置回来
      二轮更新 , 之前动画如果点击过快会出现问题, 原来是因为第二个block是要在动画完成才进行,所以出现了问题
      但是在这里其实只要透明度改变就可以了 所以其实可以对第二段动画结束后没有执行操作
 */
#import "ViewController.h"
#import "MeiTuanCell.h"
#import "FoodModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)NSArray *arrFoodPlist;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self headerView];
    self.mainTableView.rowHeight = 80;
}

#pragma mark 底层UITableView懒加载
- (UITableView *)mainTableView
{
    if (!_mainTableView)
    {
        _mainTableView = [[UITableView alloc] initWithFrame:self.view.frame
                                style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

//自定义Cell类进行了封装 只暴露部分属性跟一个类方法.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeiTuanCell *cell = [MeiTuanCell createCell:tableView];
    cell.model = self.arrFoodPlist[indexPath.row];
    return cell;
}

//给section设置标题(在header处)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   //因为只有一个section 就不用判断是第几个section了
    return @"欢迎来到美团外卖!";
}

//给section的尾部设置标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"没有合心意的么...?再逛逛吧😉";
}

#pragma mark headerView懒加载(tableHeaderVIew)
- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] init];
        UIImageView *headerPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横幅.jpg"]];
        _headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * (headerPic.image.size.height / headerPic.image.size.width));
        headerPic.frame = _headerView.frame;
        [_headerView addSubview:headerPic];
        self.mainTableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

#pragma mark 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tipLabel.alpha = 1; //每次动画就会把透明度变为0 所以重新开始时要重新设为1
    [UIView animateWithDuration:2.0 animations: ^{
        self.tipLabel.alpha = 0;
    } completion:^(BOOL finished) {
//   [self.view bringSubviewToFront:self.mainTableView];   //其实只要透明度改了就好 没有必要做这操作, 这样就解决了点击过快"闪现"的问题
    }];
}

#pragma mark 隐藏状态条
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark arrFoodPlist懒加载
- (NSArray *)arrFoodPlist
{
    if (!_arrFoodPlist)
    {
        NSString *strpath = [[NSBundle mainBundle] pathForResource:@"meiTuanPlist.plist" ofType:nil];
        NSArray *arrPlist = [[NSArray alloc] initWithContentsOfFile:strpath];
        NSMutableArray *arrTemp = [NSMutableArray array];
        FoodModel *model;
        for (NSDictionary *dict in arrPlist)
        {
            model = [FoodModel FoodModelWithDict:dict];
            [arrTemp addObject:model];
        }
        _arrFoodPlist = arrTemp;
    }
    return _arrFoodPlist;
}

#pragma mark tipLabel懒加载
- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
        _tipLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _tipLabel.backgroundColor  = [UIColor grayColor];
        _tipLabel.text = @"网络好像出了点问题...请稍后再试";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tipLabel];
        self.tipLabel.center = self.view.center;
        [self.view bringSubviewToFront:_tipLabel];
    }
    return _tipLabel;
}
@end
