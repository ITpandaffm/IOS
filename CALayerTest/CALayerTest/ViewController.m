//
//  ViewController.m
//  CALayerTest
//
//  Created by ffm on 16/8/31.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (nonatomic, strong) CALayer *myLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.cornerRadius = 50;
    layer.borderWidth = 10;
    layer.borderColor = [UIColor blueColor].CGColor;
    
    
    
    [self.view.layer addSublayer:layer];
    self.myLayer = layer;
//    self.redView.frame = CGRectMake(100, 100, 100, 100);
//    self.redView.layer.borderColor = [UIColor greenColor].CGColor;
//    self.redView.layer.borderWidth = 5;
//    self.redView.layer.cornerRadius = 50;
//    
//    self.redView.layer.shadowOpacity = 1;
//    self.redView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.redView.layer.shadowOffset = CGSizeMake(10, -10);
//    
//    self.redView.layer.contents = (id)[UIImage imageNamed:@"1.png"].CGImage;
//    self.redView.layer.masksToBounds = YES;
//    
//    self.redView.layer.position = CGPointMake(0, 0);
//    self.redView.layer.anchorPoint = CGPointMake(0, 0);
//    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.redView.layer.position = CGPointMake(100, 200);
//    self.redView.bounds = CGRectMake(0, 0, 200, 200);
//    self.redView.layer.transform = CATransform3DTranslate(self.redView.layer.transform, 20, 20, 200);
    
////    self.redView.layer.transform = CATransform3DScale(self.redView.layer.transform, 2, 2, 2);
//    self.redView.layer.transform = CATransform3DRotate(self.redView.layer.transform, 30, 100, 100, 100);
//    static int value1 ;
//    value1 +=2;
//    
//    [self.redView.layer setValue:[NSNumber numberWithInt:value1] forKeyPath:@"transform.scale.y"];
    if (self.myLayer.bounds.size.width == 100) {
        self.myLayer.bounds = CGRectMake(0, 0, 200, 200);
        self.myLayer.cornerRadius = 100;
    } else
    {
        self.myLayer.bounds = CGRectMake(0, 0, 100, 100);
        self.myLayer.cornerRadius = 50;
    }

    
    
}

@end
