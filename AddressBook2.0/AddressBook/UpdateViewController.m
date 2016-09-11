//
//  UpdateViewController.m
//  AddressBook
//
//  Created by ffm on 16/8/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextField.text = self.nameStr;
    self.numberTextField.text = self.numberStr;
}

#pragma mark - 懒加载
- (NSString *)nameStr
{
    if (!_nameStr)
    {
        _nameStr = [[NSString alloc] init];
    }
    return _nameStr;
}

- (NSString *)numberStr
{
    if (!_numberStr)
    {
        _numberStr = [[NSString alloc] init];
    }
    return _numberStr;
}


- (IBAction)clickSureBtn:(id)sender
{
    [self.delegate updateFinish:self.nameTextField.text newNumber:self.numberTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
