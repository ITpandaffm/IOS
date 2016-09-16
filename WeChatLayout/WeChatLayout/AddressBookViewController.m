//
//  AddressBookViewController.m
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "AddressBookViewController.h"
#import "WechatModel.h"
#import "AddressBookTableViewCell.h"


@interface AddressBookViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSArray *indexTitlesArray;
@property (nonatomic, strong) NSArray *userInfoPlistArray;

@property (nonatomic, strong) UITableView *firstTableView;

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通讯录";
    self.myTableView.rowHeight = 60;
    [self useUILoaclized];
    self.firstTableView.rowHeight = 50;
    [self.myTableView reloadData];
}


#pragma mark - firstTableView
- (UITableView *)firstTableView
{
    if (!_firstTableView)
    {
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220) style:UITableViewStylePlain];
        _firstTableView.dataSource = self;
        _firstTableView.delegate = self;
        self.myTableView.tableHeaderView = _firstTableView;
    }
    return _firstTableView;
}




#pragma mark - myTableView懒加载
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
    if ([tableView isEqual:self.myTableView])
    {
        return self.sectionArray.count;
    }
    else
    {
        return 1;
    }
}

//获取那个section对应的数组 返回那个数组的长度即为section中的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.myTableView]) {
        NSArray *arr = [self.sectionArray objectAtIndex:section];
        return arr.count;
    }
    else
    {
        return 4;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.myTableView])
    {
        AddressBookTableViewCell *cell = [AddressBookTableViewCell creatCell:tableView];
        //这里不能再通过行号来选取model 因为很多section都是只有一行 所以第一个元素会出现好几遍
        //一开始是按照model的name属性 把model都排好并放到数组里了
        //所以是先取出model 再赋值给相应的cell
        NSArray *modelInSection = [self.sectionArray objectAtIndex:indexPath.section];
        WechatModel *model = [modelInSection objectAtIndex:indexPath.row];
        cell.model = model;
        return cell;
    }
    else
    {
        return [self headerTableViewSetup:indexPath];
    }
}

- (UITableViewCell *)headerTableViewSetup: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row == 0)
    {
        cell.imageView.image = [UIImage imageNamed:@"plugins_FriendNotify.png"];
        cell.textLabel.text = @"新的朋友";
    } else if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"add_friend_icon_addgroup.png"];
        cell.textLabel.text = @"群聊";
    } else if (indexPath.row == 2)
    {
        cell.imageView.image = [UIImage imageNamed:@"Contact_icon_ContactTag.png"];
        cell.textLabel.text = @"标签";
    } else if (indexPath.row == 3)
    {
        cell.imageView.image = [UIImage imageNamed:@"plugins_FriendNotify.png"];
        cell.textLabel.text = @"公众号";
    }
    return cell;
}

#pragma mark - UILocalizedIndexedCollation methods
- (void)useUILoaclized
{
    UILocalizedIndexedCollation *myCollation = [UILocalizedIndexedCollation currentCollation];
    
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitleCount = [[myCollation sectionTitles] count];
    
    //初始化一个数组newSectionsArray用来存放最终的数据，我们最终要得到的数据模型应该形如@[@[以A开头的数据数组], @[以B开头的数据数组], @[以C开头的数据数组], ... @[以#(其它)开头的数据数组]]
    //这里的数组有27 所以容量为27;
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] initWithCapacity:sectionTitleCount];
    
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitleCount; index++)
    {
        NSMutableArray *array = [NSMutableArray array];
        [newSectionArray addObject:array];
    }
    
    //将每个人按name分到某个section下
    for (int i = 0; i < self.userInfoPlistArray.count; i++)
    {
        WechatModel *model = self.userInfoPlistArray[i];
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [myCollation sectionForObject:model
                                        collationStringSelector:@selector(name)];     //通过属性来排序
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray *sectionNames = newSectionArray[sectionNumber];
        [sectionNames addObject:model];
    }
    
    
    //对每个section中的数组按照name属性排序
    for (NSInteger index = 0; index < sectionTitleCount; index++)
    {
        NSMutableArray *modelArrayForSection = newSectionArray[index];
        NSArray *sortedModelArrayForSection = [myCollation sortedArrayFromArray:modelArrayForSection collationStringSelector:@selector(name)];
        newSectionArray[index] = sortedModelArrayForSection;
    }
    
    //过滤掉没有元素的空数组 (把sectionTitle也顺便过滤了
    NSMutableArray *activeIndexTitleArr = [NSMutableArray array];
    NSMutableArray *activeArr = [NSMutableArray array];
    NSArray *tempIndexArr = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    for (int i = 0; i< newSectionArray.count; i++)
    {
        NSArray *array  = newSectionArray[i];
        if (array.count > 0)
        {
            [activeArr addObject:array];
            NSString *indexTitle = tempIndexArr[i];
            [activeIndexTitleArr addObject:indexTitle];
        }
    }
    self.sectionArray = activeArr;
    self.indexTitlesArray = activeIndexTitleArr;
}


//设置section的Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.myTableView])
    {
        return self.indexTitlesArray[section];
    }
    else
    {
        return nil;
    }
}
//设置索引标题
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.myTableView])
    {
        return self.indexTitlesArray;
    }
    else
    {
        return nil;
    }
}
//关联搜索
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([tableView isEqual:self.myTableView])
    {
        return index;
    }
    else
    {
        return 0;
    }
}

/**
 *  本来以为好像是实现这个方法就能实现那种 index保留在屏幕上方 可是好像..并没有?
    只是每个section的header变大了 然而并没有保留在屏幕上方
    (注意实现这个之后就要把heightForHeaderInSection 调大点
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.myTableView])
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 300, 25)];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 25)];
        [view addSubview:title];
        title.text = self.indexTitlesArray[section];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;
    }
    else{
        return nil;
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.02;
}

#pragma mark - userInfoPlistArray懒加载
- (NSArray *)userInfoPlistArray
{
    if (!_userInfoPlistArray)
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
        _userInfoPlistArray = arrAll;
    }
    return _userInfoPlistArray;
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
