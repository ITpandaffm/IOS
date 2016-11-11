//
//  MySliderView.h
//  RentCar
//
//  Created by ffm on 16/11/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SliderControlDelegate <NSObject>

//- (void)sliderControl:(MySliderView *)sliderControlView moveToPosition:(int)position;
- (void)sliderControlDidMoveTo:(int )position;
@end
@interface MySliderView : UIView


@end
