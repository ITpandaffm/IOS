//
//  ViewController.m
//  SealAVPlayerAVPlayerLayer
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  在要点击全屏btn全屏之后 是用layer的动画做的 改变playerLayer的bounds
    但是要在全屏的时候任意点击一下 就恢复到原本size 
    这个用到了还没学到的手势操作实现了
 
     UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnyWhereWhenFullScreen)];
     [self.view addGestureRecognizer:tap];
 */
#import "ViewController.h"
#import "MyAVPlayer.h"
#define ItemStatus @"status"
#define ItemLoadedTimeRanges @"loadedTimeRanges"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UIProgressView *myProgress;
@property (nonatomic, strong) NSTimer *progressTimerForLabel;

@property (nonatomic, strong) MyAVPlayer *myPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myPlayer];
    
    [self.myPlayer.player.currentItem addObserver:self forKeyPath:ItemStatus options:NSKeyValueObservingOptionNew context:nil];
    [self.myPlayer.player.currentItem addObserver:self forKeyPath:ItemLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];
    self.progressTimerForLabel = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateCurrentProgressLabel) userInfo:nil repeats:YES];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnyWhereWhenFullScreen)];
    [self.view addGestureRecognizer:tap];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:ItemStatus])
    {
        AVPlayerItem *item = object;
        if (item.status == AVPlayerItemStatusReadyToPlay)
        {
            self.playBtn.enabled = YES;
            long long totalSeconds = item.duration.value / item.duration.timescale;
            self.mySlider.minimumValue = 0;
            self.mySlider.maximumValue = totalSeconds;
            [self.mySlider addTarget:self action:@selector(changeCurrentBySliderValue) forControlEvents:UIControlEventValueChanged];
            __weak typeof(self) weakSelf = self;
            [self.myPlayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
                weakSelf.mySlider.value = item.currentTime.value / item.currentTime.timescale;
            }];
            
        } else if (item.status == AVPlayerItemStatusFailed)
        {
            NSLog(@"fail");
        } else if (item.status == AVPlayerItemStatusUnknown)
        {
            NSLog(@"unknown");
        }
    } else if ([keyPath isEqualToString:ItemLoadedTimeRanges])
    {
        AVPlayerItem *item = object;
        NSValue *value = [item.loadedTimeRanges lastObject];
        CMTimeRange range = [value CMTimeRangeValue];
        long long totalSecond = item.duration.value/item.duration.timescale;
        long long currentSecond = range.start.value / range.start.timescale + range.duration.value/range.duration.timescale;
        [self.myProgress setProgress:((float)currentSecond/totalSecond) animated:YES];
    }

}
#pragma mark - Timer Methods
- (void)updateCurrentProgressLabel
{
    int totalSecond = (int)self.myPlayer.player.currentItem.duration.value/self.myPlayer.player.currentItem.duration.timescale;
    int currentSecond = self.mySlider.value;
    NSString *totalStr = [self secondToMin:totalSecond];
    NSString *currentStr = [self secondToMin:currentSecond];
    NSString *str = [NSString stringWithFormat:@"%@/%@",currentStr,totalStr];
    self.durationLabel.text = str;
}

- (NSString *)secondToMin:(int )seconds
{
    int min = seconds / 60;
    int sec = seconds % 60;
    NSString *timeStr = [NSString stringWithFormat:@"%d:%d",min,sec];
    return timeStr;
}

#pragma mark - Slider Methods
- (void)changeCurrentBySliderValue
{
    [self.myPlayer.player.currentItem seekToTime:CMTimeMake(self.mySlider.value, 1) completionHandler:^(BOOL finished) {
        [self.myPlayer play];
    }];
}

#pragma mark - 懒加载
- (MyAVPlayer *)myPlayer
{
    if (!_myPlayer)
    {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"5 Delicious Apple Hacks-.mp4" ofType:nil];
        _myPlayer = [[MyAVPlayer alloc] initAVPlayer:strPath placeView:self.view];
    }
    return _myPlayer;
}


#pragma mark - click Methods
- (IBAction)clickPlayBtn:(id)sender {
    if ([self.playBtn.titleLabel.text isEqualToString:@"播放"])
    {
        [self.myPlayer play];
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    } else if ([self.playBtn.titleLabel.text isEqualToString:@"暂停"])
    {
        [self.myPlayer pause];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (IBAction)clickStopBtn:(id)sender {
    [self.myPlayer stop];
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
}

- (IBAction)clickFullScreenBtn:(id)sender {
    [self.myPlayer fullScreen];
}

- (void)tapAnyWhereWhenFullScreen
{
    [self.myPlayer exitFullScreen];
}

#pragma mark - dealloc
- (void)dealloc
{
    [self.myPlayer.player.currentItem removeObserver:self forKeyPath:ItemLoadedTimeRanges];
    [self.myPlayer.player.currentItem removeObserver:self forKeyPath:ItemStatus];
}
@end
