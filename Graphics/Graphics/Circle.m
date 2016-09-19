//
//  Circle.m
//  Graphics
//
//  Created by ffm on 16/8/27.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "Circle.h"

@implementation Circle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, 100);
    CGContextAddArc(context, 50, 100, 50, 0, 1.57, 0);
    CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
    CGContextFillPath(context);
    
    CGContextRef circleContext = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(circleContext, CGRectMake(50, 200, 200, 100));
    CGContextSetStrokeColorWithColor(circleContext, [UIColor yellowColor].CGColor);
    CGContextStrokePath(circleContext);
    
    CGContextRef ellipseContext = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ellipseContext, [UIColor purpleColor].CGColor);
    CGContextFillEllipseInRect(ellipseContext, CGRectMake(50, 450, 100, 100));
    CGContextFillPath(ellipseContext);
}


@end
