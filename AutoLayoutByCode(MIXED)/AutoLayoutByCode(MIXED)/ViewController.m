//
//  ViewController.m
//  AutoLayoutByCode(MIXED)
//
//  Created by ffm on 16/7/28.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    UIView *green = [[UIView alloc] init];
    green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:green];
    
    UIView *blue = [[UIView alloc] init];
    blue.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blue];
    
    UIView *orange = [[UIView alloc] init];
    orange.backgroundColor = [UIColor orangeColor];
    [green addSubview:orange];
    
    green.translatesAutoresizingMaskIntoConstraints = NO;
    blue.translatesAutoresizingMaskIntoConstraints = NO;
    orange.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *greenAndBLueH = [NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-20-[green]-20-[blue(==green)]-20-|"
          options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
              metrics:nil views:@{@"green":green, @"blue":blue}];
    [self.view addConstraints:greenAndBLueH];
    
    NSArray *greenV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[green(==200)]" options:0 metrics:nil views:@{@"green":green}];
    [self.view addConstraints:greenV];
    
    //设置green的subview ＊orange
    NSArray *orangeH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[orange]" options:NSLayoutFormatAlignAllLeft metrics:nil views:@{@"orange":orange}];
    [green addConstraints:orangeH];
    
    NSArray *orangeV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[orange]" options:NSLayoutFormatAlignAllTop metrics:nil views:@{@"orange":orange}];
    [green addConstraints:orangeV];
    
    NSLayoutConstraint *orangeWidhtCon = [NSLayoutConstraint
          constraintWithItem:orange
              attribute:NSLayoutAttributeWidth
              relatedBy:NSLayoutRelationEqual
              toItem:green
              attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0];
    [green addConstraint:orangeWidhtCon];
    
    NSLayoutConstraint *orangeHeightCon = [NSLayoutConstraint constraintWithItem:orange attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:green attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0];
    [green addConstraint:orangeHeightCon];
    
}

@end
