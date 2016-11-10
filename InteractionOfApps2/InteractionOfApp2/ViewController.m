//
//  ViewController.m
//  InteractionOfApp2
//
//  Created by ffm on 16/11/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPasteboard *myBoard = [UIPasteboard pasteboardWithName:@"app1_pasteBoard" create:NO];
    NSLog(myBoard.string, nil);
    self.myLabel.text = myBoard.string;
}


@end
