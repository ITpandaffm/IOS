//
//  FileManger.m
//  FileManager
//
//  Created by ffm on 16/9/19.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "FileManger.h"


@interface FileManger ()

@property (nonatomic, strong) NSFileManager *manger;

@end


@implementation FileManger

//创建文件夹
- (BOOL)createDirectoryInURL:(NSURL *)url directoryName:(NSString *)directoryName
{
    NSString *strPath = [[url absoluteString] stringByAppendingString:directoryName];
    return  [self.manger createDirectoryAtPath:strPath withIntermediateDirectories:NO attributes:nil error:nil];;
   
}
//创建文件
- (BOOL)createFileInURL:(NSURL *)url fileName:(NSString *)fileName
{
    NSString *strPath = [[url absoluteString] stringByAppendingString:fileName];
    return [self.manger createFileAtPath:strPath contents:nil attributes:nil];
}

//写文件
- (BOOL)writeToFileInURL:(NSURL *)url withContent:(NSData *)data
{
    NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(strData,nil);
    return [strData writeToFile:url.path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

//读取文件
- (NSData *)readFileInURL:(NSURL *)url
{
    NSData *data  = [NSData dataWithContentsOfFile:url.path];
    return data;
}

//获取目录下所有文件
- (NSArray *)listAllFilesAtDirectoryInURL:(NSURL *)url
{
    return [self.manger contentsOfDirectoryAtPath:url.path error:nil];
}

//判断文件是否存在
- (BOOL)fileIsNotExistInURL:(NSURL *)url
{
    return [self.manger fileExistsAtPath:[url absoluteString]];
}

//计算某个文件的大小
- (double)sizeOfFileInURL:(NSURL *)url
{
    //使用NSData
//    NSData *data = [NSData dataWithContentsOfFile:[url absoluteString]];
//    NSLog(@"%lu",(unsigned long)data.length);
//    return data.length;
    
    return [[self.manger attributesOfItemAtPath:url.path  error:nil] fileSize] ;
}

//计算某个目录下所有文件的总大小
- (double)sizeOfAllFilesInDirectoryInURL:(NSURL *)url
{
    return [self sizeOfFileInURL:url];
}

//删除文件
- (BOOL)deleteFileInURL:(NSURL *)url
{
    return [self.manger removeItemAtPath:url.path error:nil];
}

//移动文件
- (BOOL)moveFileToURL:(NSURL *)destinURL fromURL:(NSURL *)loactionURL
{
    return [self.manger moveItemAtPath:loactionURL.path toPath:destinURL.path error:nil];
//    return [self.manger moveItemAtURL:loactionURL toURL:destinURL error:nil];
}




#pragma mark - 懒加载
- (NSFileManager *)manger
{
    if (!_manger)
    {
        _manger = [NSFileManager defaultManager];
    }
    return _manger;
}

@end
