//
//  DrawingBoardView.m
//  DrawingBoard
//
//  Created by ffm on 16/9/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "DrawingBoardView.h"


@interface DrawingBoardView ()

@property (nonatomic, strong) NSNumber *lineWidth;
@property (nonatomic, strong) NSMutableArray *pathsMutarr;

@end


@implementation DrawingBoardView


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSMutableArray *path in self.pathsMutarr)
    {
        for (int i = 0; i < path.count; i++)
        {
            CGPoint point = [path[i] CGPointValue];
            if (i == 0)
            {
                CGContextMoveToPoint(context, point.x, point.y);
            } else
            {
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
    }
    CGContextSetLineWidth(context, [self.lineWidth floatValue]);
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //起始点 加入到一条新路径中
    NSMutableArray *pathPoints = [NSMutableArray array];
    [pathPoints addObject:[NSValue valueWithCGPoint:point]];
    
    //把这条新路径添加到路径数组里
    [self.pathsMutarr addObject:pathPoints];
    [self setNeedsDisplay];

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    //获取到当前的路径
    NSMutableArray *pathPoints = [self.pathsMutarr lastObject];
    [pathPoints addObject:[NSValue valueWithCGPoint:point]];
    
    [self setNeedsDisplay];
}


#pragma mark - 懒加载
- (NSNumber *)lineWidth
{
    if (!_lineWidth)
    {
        _lineWidth = [[NSNumber alloc] initWithFloat:2.0];
    }
    return _lineWidth;
}

- (NSMutableArray *)pathsMutarr
{
    if (!_pathsMutarr)
    {
        _pathsMutarr = [NSMutableArray array];
    }
    return _pathsMutarr;
}

//将画板转化为UIImage
- (UIImage *)getImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, self.layer.contentsScale);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 对外提供的方法

//根据传入数值调整宽度
- (void)changLineWidth:(float )value
{
    NSNumber *width = [[NSNumber alloc] initWithFloat:value];
    self.lineWidth = width;
    [self setNeedsDisplay];
}

//撤销
- (void)cancel
{
    [self.pathsMutarr removeLastObject];
    [self setNeedsDisplay];

}

//清空
- (void)clearAll
{
    [self.pathsMutarr removeAllObjects];
    [self setNeedsDisplay];

}

//保存
- (void)saveToAlbum
{
    UIImage *image = [self getImage];
    // 第三个参数必须要这种格式
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 保存图片对应的selector
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil;
    if(error != NULL){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
