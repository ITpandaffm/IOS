//
//  ViewController.m
//  PlayMusicWithLRC
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  9.12更新: 
    在button的设置上 再优化了一下
    把播放键跟暂停键合并在一起 (因为播放了之后 就应该只能暂停或者停止, 而相应的反过来也是)
 */
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LRCAnalysis.h"


@interface ViewController ()

@property (nonatomic, strong)AVAudioPlayer *myplayer;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UILabel *lrcTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) NSTimer *lrcTime;
@property (nonatomic, strong) NSArray *lrcArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lrcSetup];
    if (self.lrcArr)
    {
        [self.mySlider addTarget:self action:@selector(changeCurrentBySliderValue) forControlEvents:UIControlEventValueChanged];
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeSliderValueByCurrentTime) userInfo:nil repeats:YES];
        self.lrcTime = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateLrc) userInfo:nil repeats:YES];
    }
}

#pragma mark - 懒加载
- (AVAudioPlayer *)myplayer
{
    if (!_myplayer)
    {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"Immortals.mp3" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:strPath];
        _myplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [_myplayer prepareToPlay];
    }
    return _myplayer;
}


#pragma mark - slider Methods
- (void)changeCurrentBySliderValue
{
    self.myplayer.currentTime = self.mySlider.value * self.myplayer.duration;
    [self.myplayer play];
}

#pragma mark - Timer Methods
- (void)changeSliderValueByCurrentTime
{
    self.mySlider.value = self.myplayer.currentTime / self.myplayer.duration;
}

- (void)updateLrc
{
    for (int i = 0; i < self.lrcArr.count;  i++)
    {
        NSArray *arr = [self.lrcArr[i] componentsSeparatedByString:@"&&&"];
        NSString *timeStr = [arr firstObject];
        NSString *lrcStr = [arr lastObject];
        if ([timeStr intValue] <= self.myplayer.currentTime)
        {
            self.lrcTextLabel.text = lrcStr;
        }
    }
}

#pragma mark - click Methods
- (IBAction)clickPlayBtn:(id)sender {
    if ([self.playBtn.titleLabel.text isEqualToString:@"播放"])
    {
        [self.myplayer play];
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if ([self.playBtn.titleLabel.text isEqualToString:@"暂停"])
    {
        [self.myplayer pause];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
}

- (IBAction)clickStopBtn:(id)sender {
    [self.myplayer stop];
    self.myplayer.currentTime = 0;
    self.lrcTextLabel.text = @"";
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
}

#pragma mark - resolve LRC
- (void)lrcSetup
{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"Immortals.lrc" ofType:nil];
    LRCAnalysis *lrcResolver = [[LRCAnalysis alloc] init];
    self.lrcArr = [lrcResolver resolveLRCfile:strPath];
}

@end
