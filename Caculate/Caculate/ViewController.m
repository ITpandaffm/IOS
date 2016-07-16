//
//  ViewController.m
//  Caculate
//
//  Created by ffm on 16/7/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *add;  //addButton
@property (weak, nonatomic) IBOutlet UIButton *sub;  //subButton
@property (weak, nonatomic) IBOutlet UIButton *mul;  //mulButton
@property (weak, nonatomic) IBOutlet UIButton *div;  //divButton
@property (weak, nonatomic) IBOutlet UILabel *result;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField1.keyboardType = UIKeyboardTypeNumberPad;
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;
    [self.add addTarget:self action:@selector(calculateNum:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.sub addTarget:self action:@selector(calculateNum:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.mul addTarget:self action:@selector(calculateNum:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.div addTarget:self action:@selector(calculateNum:)
       forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)calculateNum: (UIButton *)btn
{
    
    
    //获取用户的输入
    NSString *strInput1 = self.textField1.text;
    NSString *strInput2 = self.textField2.text;
    
    //首先判断输入是否为空
    
    if ([strInput1 isEqualToString:@""] || [strInput2 isEqualToString:@""])
    {
        self.result.text = @"还没输入数字呢！";
        return;
    }
    float fResult = 0;
    
    //判断并计算
    if ([btn.titleLabel.text isEqualToString:@"➕"])
    {
        fResult = [strInput1 floatValue] + [strInput2 floatValue];
    }
    else if ([btn.titleLabel.text isEqualToString:@"➖"])
    {
        fResult = [strInput1 floatValue] - [strInput2 floatValue];
    }
    else if ([btn.titleLabel.text isEqualToString:@"✖️"])
    {
        fResult = [strInput1 floatValue] * [strInput2 floatValue];
    }
    else if ([btn.titleLabel.text isEqualToString:@"➗"])
    {
        if ([strInput2 intValue]==0)
        {
            self.result.text = @"除数不能为0！\n";
            return;
        }
        fResult = [strInput1 floatValue] / [strInput2 floatValue];
    }
    else
    {
        self.result.text = [NSString stringWithFormat:@"oooops"];
    }
    //输出结果
    self.result.text = [NSString stringWithFormat:@"%.2f", fResult];
}

@end
