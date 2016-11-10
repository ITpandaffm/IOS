//
//  ViewController.m
//  AppInteractionTest2
//
//  Created by ffm on 16/11/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myPic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPasteboard *board2 = [UIPasteboard generalPasteboard];
        self.myLabel.text = board2.string;
//        self.myPic.image = board.image;
    NSLog(@"yoyo %@", board2.string);
}



@end
