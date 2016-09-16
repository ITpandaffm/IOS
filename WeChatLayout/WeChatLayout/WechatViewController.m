//
//  WechatViewController.m
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WechatViewController.h"
#import "WechatTableViewCell.h"
#import "WechatModel.h"

@interface WechatViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *plistArr;

@end

@implementation WechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"微信";
    [self myTableView];
    self.myTableView.rowHeight = 60;
    [self.myTableView reloadData];
}

- (UITableView *)myTableView
{
    if (!_myTableView)
    {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plistArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WechatTableViewCell *cell = [WechatTableViewCell creatCell:tableView];
    cell.model = self.plistArr[indexPath.row];
    return cell;
}

#pragma mark - plistArr懒加载
- (NSArray *)plistArr
{
    if (!_plistArr)
    {
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"wechatPlist.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:strPath];
    WechatModel *model;
    NSMutableArray *arrAll = [NSMutableArray array];
    for (NSDictionary *dict in arr)
    {
        model = [WechatModel WechatModelWithDict:dict];
        [arrAll addObject:model];
    }
    _plistArr = arrAll;
    }
    return _plistArr;
}


#pragma mark - UITableViewDelegate




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
