//
//  LRCAnalysis.h
//  PlayMusicWithLRC
//
//  Created by ffm on 16/9/12.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  传入所需要解析的LRC文件的路径
    将会返回一个数组 
    其中数组中每一个元素均为NSString类型, 对应一行歌词
    格式为 timeString&&&lrcString 
    请注意使用时要按&&&切割字符串
 */
#import <Foundation/Foundation.h>

@interface LRCAnalysis : NSObject

- (NSArray *)resolveLRCfile:(NSString *)lrcFilePath;

@end
