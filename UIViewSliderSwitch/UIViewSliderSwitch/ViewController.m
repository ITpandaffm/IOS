//
//  ViewController.m
//  UIViewSliderSwitch
//
//  Created by ffm on 16/7/13.
//  Copyright © 2016年 ITPanda. All rights reserved.
//完成UIImageView、UISlider、UISwitch课时的代码事例（要求UISlider 范围设置成1到100）
//纯代码！实现控件
/*
 7.14更新
 优化交互细节，调整了一下slider跟switch的初始值。并且用storyboard再写一次
 */


#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView *fmImage;
@property (nonatomic, weak) UISlider *fmSlider;
@property (nonatomic, weak) UISwitch *fmSwitch;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *myImage = [[UIImageView alloc]
                        initWithFrame:CGRectMake(50, 50, 200, 200)];
    [myImage setImage:[UIImage imageNamed:@"🐱2.JPG"]];
    myImage.contentMode=UIViewContentModeScaleAspectFit;
    [myImage setBackgroundColor:[UIColor blueColor]];
    self.fmImage = myImage;
    [self.view addSubview:self.fmImage];
    
    
    UISlider *mySlider = [[UISlider alloc] initWithFrame:CGRectMake(80, 300, 170, 100)];
    [mySlider setMaximumValue:100];
    [mySlider setMinimumValue:0];
    [mySlider setValue:100];                //为了交互体验，初始值要注意一下
    [mySlider addTarget:self action:@selector(slideToAlpha) forControlEvents:UIControlEventValueChanged];
    self.fmSlider = mySlider;
    [self.view addSubview:self.fmSlider];

    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(150, 400, 100, 100)];
    [mySwitch setOn:YES];                  //开关一开始为on
    [mySwitch addTarget:self action:@selector(switchToSlide) forControlEvents:UIControlEventTouchUpInside];
    self.fmSwitch = mySwitch;
    [self.view addSubview:self.fmSwitch];
}

- (void)slideToAlpha
{
    self.fmImage.alpha = self.fmSlider.value/100;
}

- (void)switchToSlide
{
    if (self.fmSwitch.isOn) {
        self.fmSlider.enabled = YES;
    } else {
        self.fmSlider.enabled = NO;
    }
}

@end
