//
//  ViewController.m
//  DownloadAimation
//
//  Created by ffm on 16/9/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (nonatomic, strong)DownLoadView *downView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(100, 100, 200, 200);
    UIImage *image = [UIImage imageNamed:@"1.png"];
    UIImageView *backPicView = [[UIImageView alloc] initWithImage:image];
    backPicView.frame = rect;
    
    backPicView.layer.cornerRadius = 10;
    backPicView.layer.masksToBounds = YES;
    
    [self.view addSubview:backPicView];
    
    DownLoadView *downloadView = [[DownLoadView alloc] initWithFrame:rect];
    downloadView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:downloadView];
    
    self.downView = downloadView;
    
    [self.mySlider addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChange
{
    [self.downView setScheduleValue:self.mySlider.value];
}


@end
