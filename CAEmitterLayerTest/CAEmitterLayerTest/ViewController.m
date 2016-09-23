//
//  ViewController.m
//  CAEmitterLayerTest
//
//  Created by ffm on 16/9/9.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建出Layer
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    //设置边框宽度
    emitterLayer.borderWidth = 5;
    //设定尺寸
    emitterLayer.frame = CGRectMake( 100, 100, 300, 300);
    //设定发射点
    emitterLayer.emitterPosition = CGPointMake(100, 100);
    
    //发射模式
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射形状
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    
    [self.view.layer addSublayer: emitterLayer];
    
    //创建粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    
    //粒子产生率
    cell.birthRate = 4;
    
    //粒子生命周期
    cell.lifetime = 120;
    
    //速度值
    cell.velocity = 20;
    
    //速度值的微调值 (误差范围)
    cell.velocityRange = 10;
    
    cell.xAcceleration = 20;
    
    //y轴加速度
    cell.yAcceleration = 50;
    
    //发射角度
    cell.emissionRange = 1 *M_1_PI ;
    
    //设置粒子颜色
    cell.color = [UIColor blackColor].CGColor;
    
    
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snow@2x.png"].CGImage);
    
    emitterLayer.emitterCells = @[cell];
    
}


@end
