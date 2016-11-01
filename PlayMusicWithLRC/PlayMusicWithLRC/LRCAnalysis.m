//
//  LRCAnalysis.m
//  PlayMusicWithLRC
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "LRCAnalysis.h"

@interface LRCAnalysis ()

@property (nonatomic, strong) NSMutableArray *lrcMutArr;

@end

@implementation LRCAnalysis


#pragma mark - LRC
- (NSArray *)resolveLRCfile:(NSString *)lrcFilePath
{
    if ([lrcFilePath length])
    {
        NSString *contentStr = [NSString stringWithContentsOfFile:lrcFilePath encoding:kCFStringEncodingUTF8 error:nil];
        NSArray *array = [contentStr componentsSeparatedByString:@"\n"];    //把歌词全部取出 每一行作为一个元素存入数组里
        for (int i = 0; i < array.count; i++)
        {
            NSString *lineString = [array objectAtIndex:i];
            NSArray *lineArray = [lineString componentsSeparatedByString:@"]"];
            if ([lineArray[0] length] > 8)
            {
                NSString *str1 = [lineString substringWithRange:NSMakeRange(3, 1)];
                NSString *str2 = [lineString substringWithRange:NSMakeRange(6, 1)];
                if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."])    //逐行解析 只有旁边配有时间的那些才是真正       有用的 要显示的歌词
                {
                    for (int i = 0; i < lineArray.count - 1; i++)
                    {
                        NSString *lrcString = [lineArray lastObject];
                        //分割区间求歌词时间
                        NSString *timeString = [self timeToSecond:[[lineArray firstObject] substringWithRange:NSMakeRange(1, 5)]];
                        //把时间 和 歌词 加入数组
                        NSString *lrcInfo = [NSString stringWithFormat:@"%@&&&%@",timeString,lrcString];
                        [self.lrcMutArr addObject:lrcInfo];
                    }
                }
            }
        }
    }
    return self.lrcMutArr;
}

//转换时间成秒
- (NSString *)timeToSecond:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@":"];
    int currentTime = [array[0] intValue] * 60 + [array[1] intValue];
    NSString *timeStr = [NSString stringWithFormat:@"%d", currentTime];
    return timeStr;
}

#pragma mark - 懒加载
- (NSMutableArray *)lrcMutArr
{
    if (!_lrcMutArr)
    {
        _lrcMutArr = [NSMutableArray array];
    }
    return _lrcMutArr;
}
@end
