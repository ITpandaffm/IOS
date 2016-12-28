//
//  ViewController.m
//  UISeachBarTest
//
//  Created by ffm on 16/12/25.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *seacherBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    seacherBar.tintColor = [UIColor redColor];
    seacherBar.placeholder = @"请输入内容";
//    seacherBar.showsScopeBar = YES;
//    seacherBar.showsCancelButton = YES;
//    seacherBar.showsBookmarkButton = YES;
//    seacherBar.showsSearchResultsButton = YES;
    [seacherBar setScopeButtonTitles:@[@"one", @"two", @"three"]];
    
    [self.view addSubview:seacherBar];
}




@end
