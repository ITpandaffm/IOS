//
//  RectangleView.m
//  Graphics
//
//  Created by ffm on 16/8/26.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "RectangleView.h"

@implementation RectangleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //用点连线的方式创建矩形;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 100, 200);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 200, 100);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(context, 20);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
    CGContextStrokePath(context);
    
    //直接用相关api创建一个矩形
    CGContextRef anotherContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(anotherContext, [[UIColor orangeColor] CGColor]);
    CGContextSetLineWidth(anotherContext, 20);
    CGContextSetStrokeColorWithColor(anotherContext, [[UIColor greenColor] CGColor]);
    CGContextStrokeRect(anotherContext, CGRectMake(30, 230, 200, 200));
    CGContextFillRect(anotherContext, CGRectMake(30, 230, 200, 200));

    
}

@end
