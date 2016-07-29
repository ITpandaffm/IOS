//
//  ViewController.m
//  UIImageSlideSwitch(storyboard)
//
//  Created by ffm on 16/7/14.
//  Copyright © 2016年 ITPanda. All rights reserved.
// 用storyboard又写了一遍，很多感悟深了很多，同时果然快捷，然后还顺便探索了一些属性，乐在其中😄
// 还设置了一个全局变量i ，通过自加来控制button点击事件的次数，从而实现多次点击button有不同效果，而不是一次性的button

// 7.14更新，取消设置静态全局变量，直接利用setlighted的getter方法
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myView;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self action];
}

- (void)action
{
    [self.infoButton addTarget:self action:@selector(showRealFace) forControlEvents:UIControlEventTouchUpInside];
    [self.mySlider addTarget:self action:@selector(slideToAlpha) forControlEvents:UIControlEventValueChanged];
    [self.mySwitch addTarget:self action:@selector(switchToEnableSlide) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showRealFace
{
    if ( ![self.myView isHighlighted] )
    {
        [self.myView setHighlighted:YES];
    } else
    {
        [self.myView setHighlighted:NO];
    }
    
}

- (void)slideToAlpha
{
    self.myView.alpha = self.mySlider.value/100;
}

- (void)switchToEnableSlide
{
    if (self.mySwitch.isOn)
    {
        self.mySlider.enabled = YES;
    } else
    {
        self.mySlider.enabled = NO;
    }
}
@end
