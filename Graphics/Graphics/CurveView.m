//
//  CurveView.m
//  Graphics
//
//  Created by ffm on 16/8/27.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "CurveView.h"

@implementation CurveView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, 100);
    CGContextAddQuadCurveToPoint(context, 150, 50 , 250, 100);
    CGContextStrokePath(context);
    
    CGContextRef curveText = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(curveText, 50, 200);
    CGContextAddCurveToPoint(curveText, 125, 150, 175, 250, 250, 200);
    CGContextStrokePath(curveText);
}


@end
