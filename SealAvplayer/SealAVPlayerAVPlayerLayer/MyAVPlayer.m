//
//  MyAVPlayer.m
//  SealAVPlayerAVPlayerLayer
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "MyAVPlayer.h"

@interface MyAVPlayer ()

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation MyAVPlayer

- (instancetype)initAVPlayer:(NSString *)filePath placeView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        if (filePath == nil)
        {
            return 0;
        } else
        {
            NSURL *url = [NSURL fileURLWithPath:filePath];
            self.player = [AVPlayer playerWithURL:url];
            [view.layer addSublayer:self.playerLayer];
        }
    }
    return self;
}
#pragma mark - Methods
- (void)play
{
    [self.player play];
}
- (void)pause
{
    [self.player pause];
}
- (void)stop
{
    self.player.rate = 0;
    [self.player.currentItem seekToTime:kCMTimeZero];
}

- (void)fullScreen
{
    self.playerLayer.bounds = [UIScreen mainScreen].bounds;
    self.playerLayer.position = CGPointZero;
}
- (void)exitFullScreen
{
    self.playerLayer.bounds = CGRectMake(0, 0, 320, 240);
    self.playerLayer.position = CGPointMake(40, 100);
}
#pragma mark - 懒加载
- (AVPlayerLayer *)playerLayer
{
    if (!_playerLayer)
    {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.bounds = CGRectMake(0, 0, 320, 240);
        _playerLayer.position = CGPointMake(40, 100);
        _playerLayer.anchorPoint = CGPointZero;
        _playerLayer.videoGravity = @"AVLayerVideoGravityResize";
    }
    return _playerLayer;
}

@end
