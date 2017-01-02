//
//  ViewController.m
//  UIActivityIndicatorViewTest
//
//  Created by ffm on 16/12/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *actView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actView.hidesWhenStopped = NO;
    
    self.view.backgroundColor = [UIColor redColor];
    self.actView.color = [UIColor blueColor];
    
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    stepper.continuous = NO;
    stepper.autorepeat = NO;
    stepper.wraps = NO;
    stepper.stepValue = 1;
    [stepper addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    
 
}

- (void)change:(UIStepper *)stepper {
    NSLog(@"%f",stepper.value);
}
#pragma mark 懒加载
- (UIActivityIndicatorView *)actView
{
    if (!_actView) {
        _actView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
        [self.view addSubview:_actView];
    }
    return _actView;
}
- (IBAction)changeWhiteLar:(id)sender {
    self.actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
}

- (IBAction)changeWhite:(id)sender {
    self.actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
}
- (IBAction)changeGray:(id)sender {
    self.actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}
- (IBAction)start:(id)sender {
    [self.actView startAnimating];
}
- (IBAction)stop:(id)sender {
    [self.actView stopAnimating];
}


@end
