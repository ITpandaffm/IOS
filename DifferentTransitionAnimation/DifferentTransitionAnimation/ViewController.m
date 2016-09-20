//
//  ViewController.m
//  DifferentTransitionAnimation
//
//  Created by ffm on 16/9/6.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

/**
 *  这里存放的数组采用了NSSet 因为NSSet里面的元素是无序的. 每次取出来都是不一样
    所以如果如果需求改成 每次每个view的动画都随机 而且每种动画都必须要出现一次
    那么传入过渡动画方式的枚举类型NSInteger的时候 就不需要随机了, 全都传一次, 每次传给   
    从NSSet取出来的view
 *
 */

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *purpleView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSSet *viewSet;

@property (nonatomic, strong) NSNumber *isAnimationOn;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ((self.isAnimationOn.intValue % 2) == 0)
    {
        [self addTimer];
        [self startAnimation];
    }
    else
    {
        [self removeTimer];
    }
    NSNumber *newValue = [[NSNumber alloc] initWithInt:self.isAnimationOn.intValue+1];
    self.isAnimationOn = newValue;
}

- (void)startAnimation
{
    for (UIView *tempView in self.viewSet)
    {
        int randomNum = (arc4random() % 4) + 1;
        NSInteger number = randomNum;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationTransition:number forView:tempView cache:YES];
        [UIView commitAnimations];
    }
}


#pragma mark - timer Methods
- (void)removeTimer
{
    [self.timer invalidate];
}
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
}

#pragma mark - 懒加载
- (NSSet *)viewSet
{
    if (!_viewSet) {
        _viewSet = [[NSSet alloc] initWithObjects:self.redView, self.greenView, self.blueView, self.purpleView, nil];
    }
    return _viewSet;
}

- (NSNumber *)isAnimationOn
{
    if (!_isAnimationOn)
    {
        _isAnimationOn = [[NSNumber alloc] initWithInt:0];
    }
    return _isAnimationOn;
}
@end
