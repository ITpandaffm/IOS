//
//  AddContactViewController.m
//  AddressBook
//
//  Created by ffm on 16/8/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextFiled;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickAddBtn:(id)sender {
    [self.delegate addContactFinish:self.nameTextField.text userNum:self.numberTextFiled.text];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
