//
//  ViewController.m
//  UIButton
//
//  Created by ffm on 16/7/13.
//  Copyright © 2016年 ITPanda. All rights reserved.
// 7.14更新，尽量减少viewLoad中的内容，另开函数把控件的初始化这些代码扔到一个函数里
// stroyboard 格式还是默认的格式好 对于适配有帮助

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mainButton;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *disableButton;
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupButton];

}

- (void) setupButton
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80, 50, 150, 150)];
    
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"别点我别点我" forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"🐱1.JPG"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"🐶.JPG"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"🐱2.JPG"] forState:UIControlStateSelected];
    
    btn.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:btn];
    
    //点击选择的时候，mainbutton会变成选中状态
    [self.selectedButton addTarget:self action:@selector(selectButton)
                  forControlEvents:UIControlEventTouchUpInside];
    
    //点击禁用的时候，matinbutton变成禁用状态
    [self.disableButton addTarget:self action:@selector(enableButton) forControlEvents:UIControlEventTouchUpInside];
    
    //点击默认的时候，变成默认状态
    [self.defaultButton addTarget:self action:@selector(normalButton) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selectButton
{
    self.mainButton.selected = true;
    self.mainButton.enabled = true;
    self.mainButton.highlighted = false;
    [self.mainButton setTitle:@"天啦我被选中啦" forState:UIControlStateSelected];
    [self.mainButton setTitle:@"别看了就是你" forState:UIControlStateNormal];

}

- (void)enableButton
{
    self.mainButton.enabled = false;
    self.mainButton.selected = false;
    self.mainButton.highlighted = false;
    
}

- (void)normalButton
{
    self.mainButton.selected = false;
    self.mainButton.highlighted = false;
    self.mainButton.enabled = true;
    [self.mainButton setTitle:@"我是默认" forState:UIControlStateNormal];
}




@end


