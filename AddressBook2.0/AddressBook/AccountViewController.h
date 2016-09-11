//
//  AccountViewController.h
//  AddressBook
//
//  Created by ffm on 16/8/16.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  1.协议要大写 要声明为weak
    2.push会重新运行controller上的代码 而pop掉当前的 后面上来的controller不会再重新运行
    3.如果用户添加联系人时没有输入任何东西就添加 系统自动对空白项填充nil
 */
/**
 *  好久没交作业了  基本实现作业的要求 修改等. 数据顺传逆传等
    1.还是有bug 是关于didSelected执行后通过performSegue 传参到prepare方法失败的问题
    (点击某一行 跳转到页面 完成更新后跳回页面并且更新相应行的数据 这点没做好)
    2. 没有成功用上block 
 */
#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@end
