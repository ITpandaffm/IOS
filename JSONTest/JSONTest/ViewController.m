//
//  ViewController.m
//  JSONTest
//
//  Created by ffm on 16/9/17.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解析json数据
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"JSONTestData" ofType:@"json"];
    NSURL *url = [NSURL fileURLWithPath:strPath];
    NSJSONSerialization *jsonSer = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:0 error:nil];

    NSString *strJson = [jsonSer valueForKey:@"emoji"];
    NSArray *arr = [jsonSer valueForKey:@"me"];
    for (NSString *str in arr)
    {
        NSLog(str,nil);
    }
    
    //把字典转化为json数据
    
    NSDictionary *dict = @{@"name":@"ffm", @"age":@28};
    NSData *serData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *str = [[NSString alloc] initWithData:serData encoding:NSUTF8StringEncoding];

    NSLog(str, nil);
}



@end
