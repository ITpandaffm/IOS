//
//  AppDelegate.m
//  WeChatLayout
//
//  Created by ffm on 16/8/21.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 * 1.一开始不厌其烦地每个tabBar都对应一个navigationController 然后都有各自默认的RootViewController(默认是tableViewController) 同时有调好的navigationItem在上面 (自己拖拉去的话可能有偏差文本不是居中)
    结果在设置tableViewController对应的文件中 ViewDidLoad中设置tabBarItem的title的话 就不是self.tabBarItem了 .是self.navigationController.tabBarItem.title了 
    但是这样有个缺点,  是二级childController 一开始不会加载 点击之后 navigationController才加载自己的RootViewController 所以才会改变tabBarItem.title
    错了.. 写在viwdidLoad的话 点击跳转到当前的controller才会运行ViewDidLoad才会改变tabBarItem.title
 *
   2.tabBar上的图片系统会默认帮你渲染 普通状态就帮你渲染成灰色 选中状态就渲染成蓝色
    用imageWithRenderingMode这个方法设成alwaysOriginal可以关闭渲染
    3.终于学会了用代码创建UINavigationBar 不同于UIView的控件 是要先创建UINavigationBar 设定frame
 然后创建UINavigationItem 设定title等 然后通过pushNavigationItem:animated:方法加入到UINaviationBar中
    4.学会了使用UILocalizedIndexedCollation类 是tableView的辅助类 里面的三个方法跟两个属性可以整理tableView里的数据 并在右方生成一个检索条快速跳到所在区域
    5.通讯录中 一开始是先按照model的name属性把model都分好类并排序好
    所以在创建cell的时候 是按要求取得相应的model 并且赋值给相应的cell
    6.学习了怎么在一个页面使用两个tableView 在代理方法实现的时候 先判断传入参数tableView isEaqual:
    来判断是否所想的对象
 
 
 
 *  不足
 *
 *  通讯录的右侧快速检索栏那一块 感觉还没能对应得上
    (因为过滤了数组为空的那些section 所以感觉那个地方还有个瑕疵 没好好调一番
 
 
 *  8.24更新
 *  1.换了一种思路 一般像通讯录的这种 都是在后台排好之后发过来 然后直接显示的 所以直接在plist里弄好
    2.原来UITableViewDelegate里的heightForHeaderSection heightForFootSection这两个方法 如果想尽量让它小 不能直接返回0 反而适得其反 返回一些值比较小的数就好
    3.加上了UINavigationController, 之前总是死脑筋了 不知道怎么加UINavigationController, 想着如果给tabBar每次都转到一个UINavigationController 然后再跳到viewCONTRoller感觉非常不好 所以就直接给上面拖上navigationItemBar 但是这只是一个装饰 不能有管理controller的功能 
        突然开窍 UINavigationController应该有一个就够了  直接把他作为root启动就阔以了 
        不过因为tabBarController下面的viewController不是直接被navigationController管理 所以在第三层的viewController中设置navigationItem的时候 要self.UITabBarController.navigationItem来获取
    4.由于上面的问题 所以viewController实际上跟navigationController隔了一层
    导致在切换的时候  一开始还算正常 但是往回操作的时候navigationBar改不回来
    目前想到的办法是自定义TabBar 自定义下方tabBarItem的点击函数 每次点击的时候,所有页面都直接交由 navigationController处理 , 就可以完美解决了 同时也可以完全弃用了storyboard.
    但是这样大改的话感觉又工程量太大....以后有空再回头改善吧
    5.通讯录那里 定义了两个数组属性,一个是存储"有效"的section, 一个是存储有效的section对应的IndexTitle
    这样弄了之后就方便了很多.
    6.通讯录右侧栏的indexTitle 点击实现快速跳转到对应的section'应该是通过计算scrollView的偏移量来实现的
    但是这里我把通讯录上面那块作为了一个tableHeaderView来实现 所以点击的时候会有偏差
 */
/**
 *  使用了RDVTabBarController这个第三方库 来实现分storyboard管理
 在使用- (__kindof UIViewController *)instantiateViewControllerWithIdentifier:(NSString *)identifier 这个方法来获取Storyboard里面的viewController时 要在stordboard中设置identifyID (选项就在设置对应类的下面)
 *
 
    8.25更新
    终于!!!!搞掂了header悬停的问题!!! 
    其实悬停效果是苹果官方自带的 但是要把tableView的样式设为plain才可以有(妈的))
    然后就解决了....激动.
    然后导入第三方库的时候最好还是通过cocoapods那个什么鬼
 */

#import "AppDelegate.h"
#import "MyTabBarControllerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MyTabBarControllerViewController *tabBarCon = [[MyTabBarControllerViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBarCon;
    [tabBarCon setupControllers];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
