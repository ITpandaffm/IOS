//
//  RainView.m
//  SealSnowAndRainAnimation
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "RainView.h"

@implementation RainView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.emitterLayer.masksToBounds = YES;
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize = self.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(self.frame.size.width/2, -20);
}

- (void)show
{
    CAEmitterCell *rainCell = [CAEmitterCell emitterCell];
    rainCell.birthRate = 25;
    rainCell.speed = 10;
    rainCell.velocity = 10;
    rainCell.velocityRange = 10;
    rainCell.yAcceleration = 1000;
    rainCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rain"].CGImage);
    rainCell.color = [UIColor blackColor].CGColor;
    rainCell.lifetime = 7;
    rainCell.scaleRange = 0.1;
    rainCell.scale = 0.2;
    
    self.emitterLayer.emitterCells = @[rainCell];
}


@end
