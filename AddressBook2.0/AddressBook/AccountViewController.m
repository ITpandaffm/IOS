//
//  AccountViewController.m
//  AddressBook
//
//  Created by ffm on 16/8/16.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  哈哈开心
 *  把之前的作业推倒重来 很多之前交错打结的思路都解开了
    整体做的非常流畅 又有了自豪的感觉'
    上次总是不敢用tableViewController 这次突然就释怀了 代码量小了很多,其实继承自tableViewController 就是很多关于tableView的初始化还有代理的设置已经设置好了 一些属性直接去storyboard调就好 非常方便  
    1.如果是采用Plain风格,就算没有一个cell 看起来好像也创建了很多的cell 用grouped风格就不会
    2.在cell的创建问题 不要再自己创建了 直接复用就好 (别忘了在storyboard里告诉tableView复用的identifier)
    3.一开始是想用storyboard里 把cell直接跟修改联系人界面 链接建立segue 但是发现didSelectedRowAtSection那个方法会在prepareSegue后面执行, 这边cell上的数据就不可以顺传过去了(因为还没准备好就跳转了) 所以选择了performSegue 在数据准备好之后再进行segue
    4.使用通知时一定要记得在析构时deallc方法中移除
    5.在点击某行cell时 顺传数据直接显示在修改联系人界面的textField中 
    本来想在prepareSegue中直接给 textField.text赋值 但是发现行不通(没初始化?可能)
    所以还是定义了NSString属性 赋值给修改联系人controller中的字符串属性赋值 再在viewDidLoad中初始化textField.text的值
 
    更新: 点击textField是输入电话号码的时候是弹出数字键盘 
 
    期待用block来代替使用代理
 */


#import "AccountViewController.h"

@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputAccountTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tipLabel.alpha = 0;
    self.inputPasswordTextField.clearsOnBeginEditing = YES;
    self.inputPasswordTextField.secureTextEntry = YES;  //设置密码形式~
    
    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.inputAccountTextField];
    
    [notify addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.inputPasswordTextField];
    
    [self textChange];
}

- (void)textChange
{
    if (self.inputAccountTextField.text.length > 0 &&
        self.inputPasswordTextField.text.length > 0)
    {
        self.loginButton.enabled = YES;
    }
    else
    {
        self.loginButton.enabled = NO;
    }
}

- (IBAction)clickLoginBtn:(id)sender {
    if ([_inputAccountTextField.text isEqualToString:@"ffm"] &&
        [_inputPasswordTextField.text isEqualToString:@"ffm"])
    {
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    }
    else
    {
        self.tipLabel.alpha = 1 ;
        //UIView 动画函数，动画持续2秒；
        [UIView animateWithDuration:2.0 animations: ^{
            self.tipLabel.alpha = 0;
        }];
    }
}

//记得析构的时候要移除通知
- (void)dealloc
{
    NSNotificationCenter *nofity = [NSNotificationCenter defaultCenter];
    [nofity removeObserver:self name:UITextFieldTextDidChangeNotification object:self.inputAccountTextField];
    [nofity removeObserver:self name:UITextFieldTextDidChangeNotification object:self.inputPasswordTextField];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *des = segue.destinationViewController;
    des.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录",self.inputAccountTextField.text];
}


@end
