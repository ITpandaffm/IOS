//
//  ViewController.m
//  UIViewAnimation
//
//  Created by ffm on 16/8/28.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blueView.frame = CGRectMake(20, 20, 50, 50);
}


// UIView属性动画
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [UIView beginAnimations:@"firstAnimation" context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    self.blueView.frame = CGRectMake(0, 0, 100, 100);
//    
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationDelay:1];
//    [UIView setAnimationRepeatCount:0];
//    [UIView setAnimationRepeatAutoreverses:YES];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    
//    self.blueView.transform = CGAffineTransformTranslate(self.blueView.transform, 20, 20);
//    
//    [UIView commitAnimations];
//    
//}

// setAnimationTransition:

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [UIView beginAnimations:@"firstAnimation" context:nil];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.blueView cache:NO];
//    [UIView commitAnimations];
//
//}


// block
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
//        self.blueView.transform = CGAffineTransformTranslate(self.blueView.transform, 50, 50);
//    } completion:^(BOOL finished) {
//        
//    }];
//    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionTransitionCurlUp  animations:^{
//        self.blueView.transform = CGAffineTransformTranslate(self.blueView.transform, 50, 50);
//    } completion:^(BOOL finished) {
//        
//    }];
    [UIView animateKeyframesWithDuration:4 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.9 animations:^{
            self.blueView.transform = CGAffineTransformTranslate(self.blueView.transform, 0, 250);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            self.blueView.transform = CGAffineTransformTranslate(self.blueView.transform, 0, -250);
        }];
        
    } completion:^(BOOL finished) {
        
    }
     ];
}


- (void)animationWillStart:(NSString *)animationID context:(void *)context
{
    NSLog(@"动画开始 %@",animationID);
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSLog(@"动画结束");
}


//typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
//    UIViewAnimationCurveEaseInOut,         // slow at beginning and end
//    UIViewAnimationCurveEaseIn,            // slow at beginning
//    UIViewAnimationCurveEaseOut,           // slow at end
//    UIViewAnimationCurveLinear
//};

@end
