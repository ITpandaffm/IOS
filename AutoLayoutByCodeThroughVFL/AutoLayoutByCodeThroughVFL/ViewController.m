//
//  ViewController.m
//  AutoLayoutByCodeThroughVFL
//
//  Created by ffm on 16/7/28.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  使用vfl  (不可以有包含乘除  所以有的时候还是得用回土方法）
    不过用了vfl代码量还是有很大简化、、
 
    变量命名 应该以颜色更好～
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void) setup
{
    UIView *myView1 = [[UIView alloc] init];
    UIView *myView2 = [[UIView alloc] init];
    UIView *smallView3 = [[UIView alloc] init];
    myView1.backgroundColor = [UIColor purpleColor];
    myView2.backgroundColor = [UIColor greenColor];
    smallView3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:myView1];
    [self.view addSubview:myView2];
    [myView1 addSubview:smallView3];
    
    myView1.translatesAutoresizingMaskIntoConstraints = NO;
    myView2.translatesAutoresizingMaskIntoConstraints = NO;
    smallView3.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *arrH = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-20-[myView1]-20-[myView2(==myView1)]-20-|" options:NSLayoutFormatAlignAllBottom|NSLayoutFormatAlignAllTop metrics:nil views:@{@"myView1":myView1, @"myView2":myView2}];
    [self.view addConstraints:arrH];
    
    NSArray *arrV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[myView1(==200)]" options:0 metrics:nil views:@{@"myView1": myView1}];
    [self.view addConstraints:arrV];
    /**
     *  我是在哪里设置的myView2的高度＝myView1的高度？
        在V: 垂直布局中， myView1(==200) 就是设置myView1的高度为200 放在水平布局的话就变成了宽度＝200   而在水平布局里面已经设置了top跟bottom相等 所以获得了想要的效果～
     */
    NSLayoutConstraint *smallLeft = [NSLayoutConstraint constraintWithItem:smallView3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *smallRight = [NSLayoutConstraint constraintWithItem:smallView3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeRight multiplier:0.5 constant:0];
    NSLayoutConstraint *smallTop = [NSLayoutConstraint constraintWithItem:smallView3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *smallBottom = [NSLayoutConstraint constraintWithItem:smallView3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:myView1 attribute:NSLayoutAttributeBottom multiplier:0.5 constant:0];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:
                    (NSLayoutConstraint *)smallTop,
                    (NSLayoutConstraint *)smallRight,
                    (NSLayoutConstraint *)smallLeft,
                    (NSLayoutConstraint *)smallBottom, nil];
    [myView1 addConstraints:arr];
//    [myView1 addConstraint: smallBottom];
//    [myView1 addConstraint: smallLeft];
//    [myView1 addConstraint: smallRight];
//    [myView1 addConstraint: smallTop];
    
}

@end
