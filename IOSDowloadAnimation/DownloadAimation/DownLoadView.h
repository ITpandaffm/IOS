//
//  DownLoadView.h
//  DownloadAimation
//
//  Created by ffm on 16/9/4.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

/**
 *  实现极大限度的模拟ios下载动画
    可以通过拖拉slider来模拟传入进度不同 来改变扇形大小
    但是在下载完成之后会自动移除控件 就得重新运行了
 9.6 更新 给backPic增加了圆角 (通过view的layer属性去设置, 更加贴近app的感觉了~)
 *
 */

#import <UIKit/UIKit.h>

@interface DownLoadView : UIView

@property(nonatomic, strong) NSNumber *schedule;

-(void)setScheduleValue:(CGFloat)value;

@end
