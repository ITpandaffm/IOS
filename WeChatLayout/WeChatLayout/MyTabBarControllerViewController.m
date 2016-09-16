//
//  MyTabBarControllerViewController.m
//  WeChatLayout
//
//  Created by ffm on 16/8/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "MyTabBarControllerViewController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"

@interface MyTabBarControllerViewController ()

@end

@implementation MyTabBarControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupControllers
{
    UIStoryboard *wechatStroyboard = [UIStoryboard storyboardWithName:@"WechatUIStoryboard" bundle:nil];
    UIViewController *wehatNavi = [wechatStroyboard instantiateViewControllerWithIdentifier:@"WechatNavi"];
    
    UIStoryboard *addressStroyboard = [UIStoryboard storyboardWithName:@"AddreeeStoryboard" bundle:nil];
    UIViewController *addressNavi = [addressStroyboard instantiateViewControllerWithIdentifier:@"AddressNavi"];
    
    UIStoryboard *discoverStroyboard = [UIStoryboard storyboardWithName:@"DiscoverStoryboard" bundle:nil];
    UIViewController *discoverNavi = [discoverStroyboard instantiateViewControllerWithIdentifier:@"discoverNavi"];
    
    UIStoryboard *personalStroyboard = [UIStoryboard storyboardWithName:@"PersonalStoryboard" bundle:nil];
    UIViewController *personalNavi = [personalStroyboard instantiateViewControllerWithIdentifier:@"personalNavi"];
    
    self.viewControllers = @[wehatNavi, addressNavi, discoverNavi, personalNavi];
    
    [self tabBarItemSetup:0 picName:@"tabbar_mainframe" titleText:@"微信"];
    [self tabBarItemSetup:1 picName:@"tabbar_contacts" titleText:@"通讯录"];
    [self tabBarItemSetup:2 picName:@"tabbar_discover" titleText:@"发现"];
    [self tabBarItemSetup:3 picName:@"tabbar_me" titleText:@"我的"];
    
}

- (void)tabBarItemSetup:(NSInteger )index picName:(NSString *)picStr titleText:(NSString *)title
{
    UIImage *unselectedPic = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picStr]];
    UIImage *selectedPic = [UIImage imageNamed:[NSString stringWithFormat:@"%@HL.png",picStr]];
    RDVTabBarItem *myTabBarItem = self.tabBar.items[index];
    myTabBarItem.title = title;
    [myTabBarItem setFinishedSelectedImage:selectedPic withFinishedUnselectedImage:unselectedPic];
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
