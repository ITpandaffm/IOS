//
//  DrawingBoardView.h
//  DrawingBoard
//
//  Created by ffm on 16/9/3.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardView : UIView

- (void)changLineWidth:(float )value;   //根据传入数值改变宽度
- (void)cancel;     //撤销
- (void)clearAll;    //清空
- (void)saveToAlbum;   //保存画板到相册




@end
