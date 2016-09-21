//
//  DownLoadView.m
//  DownloadAimation
//
//  Created by ffm on 16/9/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "DownLoadView.h"

@implementation DownLoadView

- (void)drawRect:(CGRect)rect {
    self.alpha = 0.8;
    [self drawRectangle];
    if (self.schedule.floatValue > -1.57)
    {
        [self drawMidCircle];
        [self drawMidArr];
    }
}

#pragma mark - drawMethods
- (void)drawRectangle
{
    CGContextRef contextOutsideShadow = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contextOutsideShadow, 0, 0);
    CGContextAddLineToPoint(contextOutsideShadow, self.frame.size.width, 0);
    CGContextAddLineToPoint(contextOutsideShadow, self.frame.size.width, self.frame.size.height);
    CGContextAddLineToPoint(contextOutsideShadow, 0, self.frame.size.height);
    CGContextAddLineToPoint(contextOutsideShadow, 0, 0);
    CGContextSetFillColorWithColor(contextOutsideShadow, [UIColor lightGrayColor].CGColor);
    CGContextFillPath(contextOutsideShadow);
}

- (void)drawMidCircle
{
    CGContextRef contextMidCircle = UIGraphicsGetCurrentContext();
    CGFloat midRectangleWidth = self.frame.size.width * 0.6;
    CGFloat midRectangleHeight = self.frame.size.height * 0.6;
    CGFloat midRectangleX = (self.frame.size.width - midRectangleWidth) / 2;
    CGFloat midRectangleY = (self.frame.size.height - midRectangleHeight) / 2;
    CGContextAddEllipseInRect(contextMidCircle, CGRectMake(midRectangleX, midRectangleY, midRectangleWidth, midRectangleHeight));
    CGContextSetFillColorWithColor(contextMidCircle, [UIColor whiteColor].CGColor);
    CGContextFillPath(contextMidCircle);
}

- (void)drawMidArr
{
    CGContextRef contextMidArc = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contextMidArc, self.frame.size.width/2, self.frame.size.height/2);
    CGContextAddArc(contextMidArc, self.frame.size.width/2, self.frame.size.height/2, ((self.frame.size.width * 0.6)/2)*0.9, -1.57, self.schedule.floatValue, 0);
    CGContextSetFillColorWithColor(contextMidArc, [UIColor lightGrayColor].CGColor);
    CGContextFillPath(contextMidArc);
}

#pragma mark - 根据传入的进度改变扇形弧度
- (void)setScheduleValue:(CGFloat)value
{
    float newSchedule = ((value/100)*6.28-1.57);
    NSNumber *newScheduleInArr = [[NSNumber alloc] initWithFloat:newSchedule];
    self.schedule = newScheduleInArr;
    if (value > 99)
    {
        [self reachMax];
    }
    [self setNeedsDisplay];
}

#pragma mark - 下载完成进行动画
- (void)reachMax
{
    CGFloat width = self.frame.size.width * 0.6;
    CGFloat height = self.frame.size.height * 0.6;
    CGFloat x = (self.frame.size.width - width) / 2;
    CGFloat y = (self.frame.size.height - height) / 2;
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    circleView.backgroundColor = [UIColor whiteColor];
    circleView.alpha = 0.8;
    circleView.layer.cornerRadius = width/2;
    [self addSubview:circleView];
    [UIView animateWithDuration:0.5 animations:^{
        circleView.transform = CGAffineTransformScale(circleView.transform, 2.5, 2.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 懒加载
- (NSNumber *)schedule
{
    if (!_schedule)
    {
        _schedule = [[NSNumber alloc] initWithFloat:-1.57];
    }
    return _schedule;
}

@end
