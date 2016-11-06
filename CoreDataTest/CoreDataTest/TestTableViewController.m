//
//  TestTableViewController.m
//  CoreDataTest
//
//  Created by ffm on 16/9/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "TestTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#import "UserContentViewController.h"
@interface TestTableViewController ()


@property (nonatomic, strong) NSArray *dataArr;



@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    self.dataArr = [context executeFetchRequest:request error:nil];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


#pragma mark - 查询数据
//把数据显示到cell上 相当于查询数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    UILabel *myLabel = [cell viewWithTag:2];
    NSString *name = [self.dataArr[indexPath.row] valueForKey:@"name"];
    NSString *age = [self.dataArr[indexPath.row] valueForKey:@"age"];
    NSString *str = [NSString stringWithFormat:@"name:%@ , age:%@",name, age];
    myLabel.text = str;
    return cell;
}

//选中某行之后 切换到UserViewController 并把数据传过去
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *data = self.dataArr[indexPath.row];
    UserContentViewController * userViewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"UserContent"];
    userViewCon.obeject = data;
    [self presentViewController:userViewCon animated:YES completion:^{
        
    }];

}
#pragma mark - 修改数据
//当修改完数据 tableView界面重新显示的时候 进行数据的刷新
- (void)viewWillAppear:(BOOL)animated
{
    [self refreshData];
}

- (void)refreshData
{
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    self.dataArr = [context executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}


#pragma mark - 删除数据
/**
 *  先设置cell为可编辑的 然后删除掉cell的时候 把数据也从数据库上删掉
 */

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        [context deleteObject:self.dataArr[indexPath.row]];
        [context save:nil];
        [self refreshData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
