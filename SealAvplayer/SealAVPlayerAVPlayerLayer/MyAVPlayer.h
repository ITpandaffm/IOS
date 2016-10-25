//
//  MyAVPlayer.h
//  SealAVPlayerAVPlayerLayer
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface MyAVPlayer : UIView

@property (nonatomic, strong) AVPlayer *player;

- (instancetype)initAVPlayer:(NSString *)filePath placeView:(UIView *)view;

- (void)play;
- (void)pause;
- (void)stop;
- (void)fullScreen;
- (void)exitFullScreen;
@end
