//
//  ViewController.m
//  customerCell
//
//  Created by ffm on 16/8/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import "WechatModel.h"
#import "WechatCellTableViewCell.h"
@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *arrPlist;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myTableView];
}

#pragma mark UITableView 懒加载
- (UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _myTableView.dataSource = self;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource
//多少节
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//多少列(每节)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

//具体每一列显示啥
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //高度封装
    WechatCellTableViewCell *cell = [WechatCellTableViewCell creatCell:tableView];
    cell.model = self.arrPlist[indexPath.row];
    return cell;
}


#pragma mark 读取plist的数据并保存在数组arrPlist中
- (NSArray *)arrPlist
{
   NSString *strPath = [[NSBundle mainBundle] pathForResource:@"wechatPlist.plist" ofType:nil];
    NSArray *arr = [[NSArray array] initWithContentsOfFile:strPath];
    WechatModel *model;
    NSMutableArray *arrAll = [NSMutableArray array];
    for (NSDictionary *dict in arr)
    {
        model = [WechatModel wechatModelWithDIct:dict];
        [arrAll addObject:model];
    }
    _arrPlist = arrAll;
    return _arrPlist;
}

#pragma mark 去掉状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
