//
//  ViewController.m
//  DrawingBoard
//
//  Created by ffm on 16/9/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  9.4更新 完成对画板类的封装
 */

#import "ViewController.h"
#import "DrawingBoardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic, strong) DrawingBoardView *drawView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(changeLineWidth) forControlEvents:UIControlEventValueChanged];
}
- (DrawingBoardView *)drawView
{
    if (!_drawView)
    {
        _drawView = (DrawingBoardView *)self.view;
    }
    return _drawView;
}

- (void)changeLineWidth
{
    [self.drawView changLineWidth:self.slider.value];

}

- (IBAction)clear:(id)sender
{
    [self.drawView clearAll];

    
}

- (IBAction)cancel:(id)sender
{
    [self.drawView cancel];

}

- (IBAction)save:(id)sender
{
    [self.drawView saveToAlbum];
}


@end
