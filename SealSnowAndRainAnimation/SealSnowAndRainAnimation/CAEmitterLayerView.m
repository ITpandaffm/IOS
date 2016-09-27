//
//  CAEmitterLayerView.m
//  SealSnowAndRainAnimation
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "CAEmitterLayerView.h"

@interface CAEmitterLayerView ()
{
    CAEmitterLayer *_emitterLayer;
}
@end

@implementation CAEmitterLayerView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
}
//view的layer属性使其从CALayer变为CAEmitterLayer
+ (Class)layerClass
{
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _emitterLayer = (CAEmitterLayer *)self.layer;
    }
    return self;
}

#pragma mark - setter & getter
- (void)setEmitterLayer:(CAEmitterLayer *)emitterLayer
{
    _emitterLayer = emitterLayer;
}
- (CAEmitterLayer *)emitterLayer
{
    return _emitterLayer;
}

#pragma mark - Methods
- (void)hide
{
    
}
- (void)show
{
    
}
@end
