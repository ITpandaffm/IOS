//
//  SnowView.m
//  SealSnowAndRainAnimation
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "SnowView.h"

@implementation SnowView


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
    self.emitterLayer.emitterPosition = CGPointMake(self.frame.size.width / 2, -20);
}

- (void)show
{
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    snowCell.birthRate = 1;
    snowCell.speed = 10;
    snowCell.velocity = 2 ;
    snowCell.velocityRange = 10;
    snowCell.yAcceleration = 10;
    snowCell.emissionRange = 0.5 * M_PI;
    snowCell.spinRange = 0.25 * M_PI;
    snowCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snow"].CGImage);
    snowCell.color = [UIColor redColor].CGColor;
    snowCell.lifetime = 80;
    snowCell.scale = 0.5;
    snowCell.scaleRange = 0.3;
    
    self.emitterLayer.emitterCells = @[snowCell];
}



@end
