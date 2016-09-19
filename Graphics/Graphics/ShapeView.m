//
//  ShapeView.m
//  Graphics
//
//  Created by ffm on 16/8/27.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 100);
    CGContextAddLineToPoint(context, 10, 200);
    CGContextAddLineToPoint(context, 110, 200);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
}


@end
