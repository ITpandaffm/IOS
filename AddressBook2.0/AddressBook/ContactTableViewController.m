//
//  ContactTableViewController.m
//  AddressBook
//
//  Created by ffm on 16/8/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ContactTableViewController.h"
#import "AddContactViewController.h"
#import "UpdateViewController.h"


@interface ContactTableViewController () <AddContactDelegate, UpdateContactDelegate>

@property (nonatomic, strong) NSMutableArray *userInfoArr;

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *numberStr;
@property (nonatomic, copy) NSIndexPath *selectedIndexPath;   //属性定义为copy?

@end

@implementation ContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - AddContactDelegate
- (void)addContactFinish:(NSString *)name userNum:(NSString *)number
{
    NSString *userStr = [NSString stringWithFormat:@"%@&&&%@",name,number];
    [self.userInfoArr addObject:userStr];
    [self.tableView reloadData];
}

#pragma mark - UpdateContactDelegate
- (void)updateFinish:(NSString *)name newNumber:(NSString *)number
{
    NSString *userStr = [NSString stringWithFormat:@"%@&&&%@",name,number];
    [self.userInfoArr replaceObjectAtIndex:self.selectedIndexPath.row withObject:userStr];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    /**
     * 记得设置storyboard里reuse identifier
      不能用下面的方法!!  否则虽然建立了cell与controller之间的segue 也没有左右(因为是新建的~ 不是storyboard新建的
     */
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//    }
    
    NSString *str = self.userInfoArr[indexPath.row];
    NSArray *strArr = [str componentsSeparatedByString:@"&&&"];
    cell.textLabel.text = strArr[0];
    cell.detailTextLabel.text = strArr[1];
    
    if ([cell.textLabel.text isEqualToString:@""])
    {
        cell.textLabel.text = @"nil";  //如果用户没有输入 直接确定就为空
    }
    if ([cell.detailTextLabel.text isEqualToString:@""])
    {
        cell.detailTextLabel.text = @"nil";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = self.userInfoArr[indexPath.row];
    NSArray *strArr = [str componentsSeparatedByString:@"&&&"];
    
    self.nameStr = strArr[0];
    self.numberStr = strArr[1];
    
    self.selectedIndexPath = indexPath;
    
    [self performSegueWithIdentifier:@"cellSegue" sender:nil];
}


#pragma mark - userInfoArr懒加载
- (NSMutableArray *)userInfoArr
{
    if (!_userInfoArr)
    {
        _userInfoArr = [NSMutableArray array];
    }
    return _userInfoArr;
}

- (NSString *)nameStr
{
    if (!_nameStr)
    {
        _nameStr = [[NSString alloc] init];
    }
    return _nameStr;
}

- (NSString *)numberStr
{
    if (!_numberStr)
    {
        _numberStr = [[NSString alloc] init];
    }
    return _numberStr;
}

- (NSIndexPath *)selectedIndexPath
{
    if (!_selectedIndexPath)
    {
        _selectedIndexPath = [[NSIndexPath alloc] init];
    }
    return _selectedIndexPath;
}
#pragma mark - Navigation
//这个sender参数就是点击控件的参数 例如点击button跳转到segue的话 这个sender就是button
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addContactSegue"])
    {
        AddContactViewController *addCon = segue.destinationViewController;
        addCon.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"cellSegue"])
    {
        UpdateViewController *updateCon = segue.destinationViewController;
        updateCon.nameStr = self.nameStr;
        updateCon.numberStr = self.numberStr;
        updateCon.delegate = self;
    }

}


@end
