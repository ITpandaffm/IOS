//
//  ViewController.m
//  AVPlayerTest
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#define itemStatus @"status"
#define itemLoadedTimeRanges @"loadedTimeRanges"
@interface ViewController ()<AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *videoSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playerLayer];
    
    [self.player.currentItem addObserver:self forKeyPath:itemStatus options:NSKeyValueObservingOptionNew context:nil];
    [self.player.currentItem addObserver:self forKeyPath:itemLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:itemStatus])
    {
        AVPlayerItem *item = object;
        if (item.status ==  AVPlayerItemStatusReadyToPlay)
        {
            self.playBtn.enabled = YES;
            long long totalSeconds = item.duration.value / item.duration.timescale;
            NSLog(@"ready 总时长为%lld 秒", totalSeconds);
            self.videoSlider.minimumValue = 0;
            self.videoSlider.maximumValue = totalSeconds;
            [self.videoSlider addTarget:self action:@selector(changeProgressBySliderValue) forControlEvents:UIControlEventValueChanged];
            //在block中使用self会报警告容易导致强引用循环, 所以换成weak类型 (这里相当于定义了一个临时变量
            __weak typeof(self) weakSelf = self;
            [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
                weakSelf.videoSlider.value = item.currentTime.value / item.currentTime.timescale;
            }];
        } else if (item.status == AVPlayerItemStatusUnknown)
        {
            NSLog(@"unknow");
        } else if (item.status == AVPlayerItemStatusFailed)
        {
            NSLog(@"失败了草");
        }
    } else if ([keyPath isEqualToString:itemLoadedTimeRanges])
    {
        AVPlayerItem *item = object;
        NSValue *value = [item.loadedTimeRanges lastObject];
        CMTimeRange range = [value CMTimeRangeValue];
        
        long long totalSecond = item.duration.value/item.duration.timescale;
        long long currentSecond = range.start.value / range.start.timescale + range.duration.value/range.duration.timescale;
        [self.progress setProgress:((float)currentSecond/totalSecond) animated:YES];
    };
}

- (void)changeProgressBySliderValue
{
    [self.player.currentItem seekToTime:CMTimeMake(self.videoSlider.value, 1) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

#pragma mark - 懒加载
- (AVPlayer *)player
{
    if (!_player)
    {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"V50927-192202" ofType:@"mp4"];

        NSURL *url = [NSURL fileURLWithPath:strPath];
//        NSURL *url = [NSURL URLWithString:@"https://pan.baidu.com/play/video#video/path=%2F%E6%88%91%E7%9A%84%E8%B5%84%E6%BA%90%2F%5BW%5D%5BE015(720P)%5D%5BKO_CN%5D.mkv&t=-1"];

        _player = [AVPlayer playerWithURL:url];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer
{
    if (!_playerLayer)
    {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.backgroundColor = [UIColor redColor].CGColor;
        _playerLayer.bounds = CGRectMake(0, 0, 320, 240);
        _playerLayer.position = CGPointMake(50, 110);
        _playerLayer.anchorPoint = CGPointZero;
        _playerLayer.videoGravity = @"AVLayerVideoGravityResize";
        [self.view.layer addSublayer:_playerLayer];
    }
    return _playerLayer;
}

#pragma mark - clickMethods
- (IBAction)clickPlayBtn:(id)sender {
    [self.player play];
}

- (IBAction)clickPauseBtn:(id)sender {
    [self.player pause];
}
- (IBAction)clickStopBtn:(id)sender {
//    self.player.rate = 0;
    [self.player.currentItem seekToTime:kCMTimeZero];
}
- (IBAction)clickPushBtn:(id)sender {
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"非诚勿扰.mp4"ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:strPath];
    AVPlayerViewController *avplayerViewController = [[AVPlayerViewController alloc] init];
    avplayerViewController.player = [AVPlayer playerWithURL:url];
    avplayerViewController.delegate = self;
    
    [self presentViewController:avplayerViewController animated:YES completion:^{
        [avplayerViewController.player play];
    }];
    
}

#pragma mark - AVPlayerViewControllerDelegate
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController
{
    return NO;
}

- (void)dealloc
{
    [self.player.currentItem removeObserver:self forKeyPath:itemStatus];
}

@end
