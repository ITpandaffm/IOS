//
//  MySliderView.m
//  RentCar
//
//  Created by ffm on 16/11/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "MySliderView.h"



@interface MySliderView ()

@property (weak, nonatomic) IBOutlet UIView *sliderWrapperView;
@property (nonatomic, strong)  NSMutableArray *dotsMurArr;
@property (nonatomic, strong) UIButton *carBtn;


@end
@implementation MySliderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initializeView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initializeView];
    }
    return self;
}

- (void)initializeView
{
    UIView *childView = [[[NSBundle mainBundle] loadNibNamed:@"MySliderView" owner:self options:nil] firstObject];
    childView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

    if (childView)
    {
        [self addSubview:childView];
    }
}

//加载子控件的时候会调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    
    UIView *sliderBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sliderWrapperView.frame.size.width, 4)];
    sliderBar.layer.cornerRadius = 2;
    sliderBar.backgroundColor = [UIColor redColor];
    sliderBar.center = self.sliderWrapperView.center;
    [self addSubview:sliderBar];
    
    
    CGFloat dotY = self.sliderWrapperView.frame.size.height / 2 - 4;
    for (int i = 0; i < 4; i++)
    {
        CGFloat dotX = i * (self.sliderWrapperView.frame.size.width / 3) -4;
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotX, dotY, 8, 8)];
        dotView.layer.cornerRadius = 4;
        dotView.backgroundColor = [UIColor redColor];
        [self.sliderWrapperView addSubview:dotView];
        [self.dotsMurArr addObject:dotView];
    }
    [self carBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView *currentDotView;
    for (int i = 0; i < self.dotsMurArr.count; i++)
    {
        currentDotView = self.dotsMurArr[i];
        if ([touches anyObject].view == currentDotView)
        {
            self.carBtn.center = currentDotView.center;
//            [self.sliderDelegate sliderControl:self moveToPosition:i];
            [self.sliderDelegate sliderControlDidMoveTo:i];
            break;
        }
    }
}


#pragma mark 懒加载
- (NSMutableArray *)dotsMurArr
{
    if (!_dotsMurArr)
    {
        _dotsMurArr = [NSMutableArray array];
    }
    return _dotsMurArr;
}

- (UIButton *)carBtn
{
    if (!_carBtn)
    {
        //创建button
        _carBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_carBtn setImage:[UIImage imageNamed:@"car_button"] forState:UIControlStateNormal];
        UIView *currentDot = [self.dotsMurArr firstObject];
        _carBtn.center = currentDot.center;
        [self.sliderWrapperView addSubview:_carBtn];
    }
    return _carBtn;
}

@end
