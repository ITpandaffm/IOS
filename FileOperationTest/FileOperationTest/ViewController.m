//
//  ViewController.m
//  FileOperationTest
//
//  Created by ffm on 16/9/15.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *strHome = NSHomeDirectory();
//    NSLog(strHome, nil);
//    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(strDoc,nil);
    NSString *strTmp = NSTemporaryDirectory();
    NSLog(strTmp, nil);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    str = [str stringByAppendingString:@"/test"];
    //写入
//    NSDictionary *dict = @{@"擦":@"擦擦", @"aaa":@"bbb"};
//    [dict writeToFile:str atomically:YES];
    
    //读取
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:str];
//    NSLog(@"%@",dict);
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL exist = [manager fileExistsAtPath:str];
//    if (exist)
//    {
//        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:str];
//        [dict setValue:@"啦啦啦啦" forKey:@"啥卡啥卡"];
//        [dict writeToFile:str atomically:YES];
//        NSLog(@"llll");
//    }
//    [manager createDirectoryAtPath:str withIntermediateDirectories:NO attributes:nil error:nil];
    [manager removeItemAtPath:str error:nil];
}

- (IBAction)clickSaveBtn:(id)sender {
    NSUserDefaults *manger = [NSUserDefaults standardUserDefaults];
    [manger setValue:self.myLabel.text forKey:@"userName"];
    [manger setInteger:20 forKey:@"userAge"];
}
- (IBAction)clickLoadBtn:(id)sender {
    NSUserDefaults *manager = [NSUserDefaults standardUserDefaults];
    NSString *str = [NSString stringWithFormat:@"name:%@, age:%@",[manager valueForKey:@"userName"], [manager valueForKey:@"userAge"]];
    self.myLabel.text = str;
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:[manager valueForKey:@"userName"] message:[NSString stringWithFormat:@"your age is %ld",(long)[manager integerForKey:@"userAge"]] delegate:self cancelButtonTitle:@"好啦啦好啦" otherButtonTitles:@"另一个btn的title?什么鬼", nil];
    [view show];
}


@end
