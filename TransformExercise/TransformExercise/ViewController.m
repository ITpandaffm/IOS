//
//  ViewController.m
//  TransformExercise
//
//  Created by ffm on 16/7/14.
//  Copyright © 2016年 ITPanda. All rights reserved.
//  利用button来对一图片实现平移，缩放，旋转等功能，先用朴素方法，原始思路通过frame，bounds修改来实现，再通过transform来实现。
// *给图片增加了个父视图，从而在平移的时候增加边界判断

/*
 version2  使用以下方法实现
CGAffineTransformTranslate 平移
CGAffineTransformScale  缩放
CGAffineTransformTotate 旋转
 */

#import "ViewController.h"

@interface ViewController ()
                                        //     tag
@property (weak, nonatomic) IBOutlet UIImageView *myPic;          //图片  1
@property (weak, nonatomic) IBOutlet UIButton *upBtn;            //向上键 2
@property (weak, nonatomic) IBOutlet UIButton *downBtn;          //向下键  3
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;           //向左键  4
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;          //向右键  5
@property (weak, nonatomic) IBOutlet UIButton *aButtonForBig;       //放大键  6
@property (weak, nonatomic) IBOutlet UIButton *bButtonForSmall;      //缩小键  7
@property (weak, nonatomic) IBOutlet UIButton *rollLeftBtn;         //左旋转键 8
@property (weak, nonatomic) IBOutlet UIButton *rollRightBtn;        //右旋转键 9

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImgaViewSize];
    [self setup];
}

//初始化
- (void)setImgaViewSize
{
    UIImageView *image = [[UIImageView alloc]
                          initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.myPic.frame = image.frame;
}

- (void)setup
{
    [self addEvent:self.upBtn];
    [self addEvent:self.downBtn];
    [self addEvent:self.leftBtn];
    [self addEvent:self.rightBtn];
    [self addEvent:self.aButtonForBig];
    [self addEvent:self.bButtonForSmall];
    [self addEvent:self.rollLeftBtn];
    [self addEvent:self.rollRightBtn];
}


//增加事件
- (void)addEvent: (UIButton *)btn
{
    switch (btn.tag) {
        case 2:
        case 3:
        case 4:
        case 5:
            [btn addTarget:self action:@selector(move:) forControlEvents:         UIControlEventTouchUpInside];
            break;
        case 6:
        case 7:
            [btn addTarget:self action:@selector(totate:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
        case 9:
            [btn addTarget:self action:@selector(roll:) forControlEvents:UIControlEventTouchUpInside];
        default:
            break;
    }
}


//移动
- (void)move: (UIButton *)btn
{
    CGRect cgRect = self.myPic.frame;
    switch (btn.tag) {
        case 2:
            if ((cgRect.origin.y-10)>55)
            {
                cgRect.origin.y -=10;
            }
            break;
        case 3:
            if ((cgRect.origin.y+10)<170)
            {
                cgRect.origin.y +=10;
            }
            break;
        case 4:
            if ((cgRect.origin.x-10)>20)
            {
                cgRect.origin.x -=10;
            }
            break;
        case 5:
            if ((cgRect.origin.x+10)<140)
            {
                cgRect.origin.x +=10;
            }
        default:
            break;
    }
    self.myPic.frame = cgRect;
}


//缩放
- (void)totate: (UIButton *)btn
{
    CGRect temp = self.myPic.bounds;
    if (btn.tag == 6)
    {
        if (temp.size.height*1.2<250) {
            temp.size.height *= 1.2;
            temp.size.width *= 1.2;
        }
        
    } else if (btn.tag == 7)
    {
        if (temp.size.width/1.2>50)
        {
            temp.size.height /= 1.2;
            temp.size.width /= 1.2;
        }
    }
    self.myPic.bounds = temp;
}


//旋转
- (void)roll: (UIButton *)btn
{
    if (btn.tag == 8)
    {
        self.myPic.transform = CGAffineTransformRotate(self.myPic.transform, M_PI_2);
    } else if (btn.tag == 9)
    {
        self.myPic.transform = CGAffineTransformRotate(self.myPic.transform, -(M_PI_2));
    }
}

@end
