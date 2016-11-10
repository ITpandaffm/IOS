//
//  ViewController.m
//  AppInteractionTest1
//
//  Created by ffm on 16/11/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIPasteboard *myPasteBoard = [UIPasteboard pasteboardWithName:@"app1_pasteBoard" create:YES];
    UIPasteboard *myPasteBoard = [UIPasteboard generalPasteboard];
    myPasteBoard.string = @"it'sfucxingexcitingtoseethismessage";
//    pasteBoard.image = [UIImage imageNamed:@"ffm"];
    
}

@end
