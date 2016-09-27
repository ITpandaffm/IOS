//
//  CAEmitterLayerView.h
//  SealSnowAndRainAnimation
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAEmitterLayerView : UIView

/**
 *  模仿setter getter方法
 */
- (void)setEmitterLayer:(CAEmitterLayer *)emitterLayer;
- (CAEmitterLayer *)emitterLayer;


- (void)show;
- (void)hide;

@end
