//
//  ViewController.m
//  FrameBoundsCenter
//
//  Created by ffm on 16/7/13.
//  Copyright © 2016年 ITPanda. All rights reserved.
// 7.13更新，把输出的方法封装起来，代码稍微整洁一点，
/*
 7.13重大更新，
    1.对self跟view的概念不清晰，要清晰自己的思路，在printFrameBoundCenter:方法中传入UIView *之后，是想输出这个参数的frame，bound，center属性
    所以一开始输出是 self.view.frame 输出的数据都是一样的 是因为都调用的是self中的属性view，（所以是属性的数据） 应该输出的是 穿进参数.frame 等
    2.上面的概念问题搞清楚之后就顺利实现放进数组的问题。bingo～！main（）代码大大优化简洁许多
 
*/
#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *grandBlueView;
@property (weak, nonatomic) IBOutlet UIView *fatherGreenView;
@property (weak, nonatomic) IBOutlet UIView *sonRedView;
@property (weak, nonatomic) IBOutlet UIView *grandsonWhiteView;
@property (weak, nonatomic) IBOutlet UIView *grandsonPurpleView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *arr = [[NSArray alloc] initWithObjects:self.grandBlueView, self.fatherGreenView,
                                self.sonRedView, self.grandsonWhiteView,
                                  self.grandsonPurpleView, nil];
    for ( UIView *v in arr)
    {
        [self printFrameBoundCenter:v];
    }
}

- (void) printFrameBoundCenter: (UIView *)v
{
    NSLog(@"color:%@, \nframe:%@, \nbounds:%@, \ncenter:%@",self.view.backgroundColor,
                            NSStringFromCGRect(v.frame),
                            NSStringFromCGRect(v.bounds),
                            NSStringFromCGPoint(v.center));
}

@end

/*
 本来想把东西都装进数组里再通过快速枚举，通过自定义print方法方便快捷的打印出数组元素的frame，bounds，center
 */


//    for (int i = 0; i<5; i++)
//    {
//        [arr[i] printInformation];
//    }


//- (void) printInformation
//{
//    NSLog(@"frame is:%@,\n bounds is %@,\n center is %@\n",
//          NSStringFromCGRect(self.grandBlueView.frame),
//          NSStringFromCGRect(self.grandBlueView.bounds),
//          NSStringFromCGPoint(self.grandBlueView.center));
//
//}
