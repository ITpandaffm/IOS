//
//  ViewController.m
//  SealSnowAndRainAnimation
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 * 设置maskView的时候要注意 不能只创建一个ImageView 然后让下雨 下雪两个的maskVIew都等于同一个ImageVIew 这样的话只能一个有效果 
   要分别设置两个ImageView 然后让不同的控件的maskView对应不同的ImageView作为maskView
 */
#import "ViewController.h"
#import "SnowView.h"
#import "RainView.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    maskImageView.image = [UIImage imageNamed:@"alpha"];
    
    UIImageView *maskImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    maskImageView2.image = [UIImage imageNamed:@"alpha"];
    
    SnowView *snowView = [[SnowView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    snowView.maskView = maskImageView;
    [self.view addSubview:snowView];
    snowView.backgroundColor = [UIColor clearColor];
    [snowView show];
    
    RainView *rainView = [[RainView alloc] initWithFrame:CGRectMake(50, 300, 200, 200)];
    rainView.maskView = maskImageView2;
    [self.view addSubview:rainView];
    rainView.backgroundColor = [UIColor clearColor];
    [rainView show];
}

@end
