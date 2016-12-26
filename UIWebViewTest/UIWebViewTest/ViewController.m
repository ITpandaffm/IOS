//
//  ViewController.m
//  UIWebViewTest
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
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    //1.加载网页
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    //2.加载html字符串
//    NSString *str = @"<html><head><meta charset=\"UTR-8\"><title>主标题|副标题</title></head><body><p>helloWorld</p></body></html>";
//    [webView loadHTMLString:str baseURL:nil];
    //3.用来展示gif
    NSURL *url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1.gif" ofType:nil]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    [self.view addSubview:webView];
}

@end
