//
//  ViewController.m
//  AutoLayoutByCodes
//
//  Created by ffm on 16/7/28.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  纯代码实现autoLayout
    先用手工复杂方法实现，再用vfl语言实现
    1.先确保加入父view    
    2.禁用autoresizing
    3.创建约束NSLayoutConstraint
    4.添加约束
 */
/**
 *  要注意增加约束的时候 
    右边距跟下边距 是相对于父view要减的 如下
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:myView1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
    [self.view addConstraint:constraintRight];
 
    设置高度的话可以根据上边距＋所要高度  来设置下边距
 
    这里没有用VFL
 
    变量命名 应该以颜色更好
 
 * */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setup
{
    //1.确保加入父view
    UIView *myView1 = [[UIView alloc] init];
    myView1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:myView1];
    
    UIView *myView2 = [[UIView alloc] init];
    myView2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:myView2];
    
    UIView *smallView = [[UIView alloc] init];
    smallView.backgroundColor = [UIColor greenColor];
    [myView1 addSubview:smallView];
    
    //2.禁用autoresizing
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    myView1.translatesAutoresizingMaskIntoConstraints = NO;
    myView2.translatesAutoresizingMaskIntoConstraints = NO;
    smallView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //3.创建NSLayoutConstraint对象
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:myView1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    
    //4.增加约束
    [self.view addConstraint:constraintLeft];
    
    
    NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:myView1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
    [self.view addConstraint:constraintTop];
    
    NSLayoutConstraint *constraintView1Right = [NSLayoutConstraint constraintWithItem:myView1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:myView2 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-20];
    [self.view addConstraint:constraintView1Right];
    
    //设置myView的高度
    NSLayoutConstraint *constraintBottom = [NSLayoutConstraint constraintWithItem:myView1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200+40];
    [self.view addConstraint:constraintBottom];
    
    NSLayoutConstraint *constraintView2Top = [NSLayoutConstraint constraintWithItem:myView2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:constraintView2Top];
    
    NSLayoutConstraint *constraintView2Right = [NSLayoutConstraint constraintWithItem:myView2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
    [self.view addConstraint:constraintView2Right];
    
    NSLayoutConstraint *constraintView2Left = [NSLayoutConstraint constraintWithItem:myView2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:20];
    [self.view addConstraint:constraintView2Left];
    
    NSLayoutConstraint *constraintView2Bottom = [NSLayoutConstraint constraintWithItem:myView2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:constraintView2Bottom];
    
    /**
     *  设置完各自的上下左右边距 还得设置宽度相等才行 
     */
    NSLayoutConstraint *constraintViewWidth = [NSLayoutConstraint constraintWithItem:myView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.view addConstraint:constraintViewWidth];
    
    
    //设置小的view
    NSLayoutConstraint *smallLeft = [NSLayoutConstraint constraintWithItem:smallView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [myView1 addConstraint:smallLeft];
    
    NSLayoutConstraint *smallTop = [NSLayoutConstraint constraintWithItem:smallView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [myView1 addConstraint:smallTop];
    
    NSLayoutConstraint *smallRight = [NSLayoutConstraint constraintWithItem:smallView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeRight multiplier:0.5 constant:0];
    [myView1 addConstraint:smallRight];
    
    NSLayoutConstraint *smallBottom = [NSLayoutConstraint constraintWithItem:smallView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeBottom multiplier:0.5 constant:0];
    [myView1 addConstraint:smallBottom];
    
}

@end
