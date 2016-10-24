//
//  ViewController.m
//  PlayMusicTest
//
//  Created by ffm on 16/9/10.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@property (nonatomic, strong)AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, strong) NSTimer *songTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(changeCurrentTime) forControlEvents:UIControlEventValueChanged];
    
    self.songTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    
}
- (void)updateCurrentTime
{
    self.slider.value = self.player.currentTime / self.player.duration;
}

- (void)changeCurrentTime
{
    self.player.currentTime = self.player.duration * self.slider.value;
    [self.player play];

}

-(AVAudioPlayer *)player
{
    if (!_player)
    {
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"01. ALWAYS" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:strPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [_player prepareToPlay];
    }
    return _player;
}
- (IBAction)playBtn:(id)sender {
    [self.player play];
    self.player.enableRate = YES;
    self.player.rate = 1;
}
- (IBAction)pauseBtn:(id)sender {
    [self.player pause];
}
- (IBAction)stopBtn:(id)sender {
    [self.player stop];
    self.player.currentTime = 0;
}
- (IBAction)quickPlay:(id)sender {
    self.player.enableRate = YES;
    self.player.rate = 2;
}


@end
