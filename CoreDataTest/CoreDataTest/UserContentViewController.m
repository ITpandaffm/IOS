//
//  UserContentViewController.m
//  CoreDataTest
//
//  Created by ffm on 16/9/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "UserContentViewController.h"

@interface UserContentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation UserContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text = [self.obeject valueForKey:@"name"];
    NSString *age = [self.obeject valueForKey:@"age"];
    self.ageTextField.text = age.description;     //注意这里获取的age 虽然是NSString类型 但是其实是NSNumber强制转换过来的 如果直接赋值诶self.ageTextField.text的话会崩溃!!!  还是要通过description转化为真正的NSString字符串 或者stringwithFormat:"%@", age 也可以
    
}

- (IBAction)clickSumitBtn:(id)sender {
    [self.obeject setValue:self.nameTextField.text forKey:@"name"];
    
    NSNumber *age = [NSNumber numberWithInteger:[self.ageTextField.text integerValue]];
    [self.obeject setValue:age  forKey:@"age"];

    [self.obeject.managedObjectContext save:nil];
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
- (IBAction)clickCancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
