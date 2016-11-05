//
//  FileManger.h
//  FileManager
//
//  Created by ffm on 16/9/19.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManger : NSObject

- (BOOL)createDirectoryInURL:(NSURL *)url directoryName:(NSString *)directoryName;    //创建文件夹
- (BOOL)createFileInURL:(NSURL *)url fileName:(NSString *)fileName;       //创建文件
- (BOOL)writeToFileInURL:(NSURL *)url withContent:(NSData *)data; //写文件
- (NSData *)readFileInURL:(NSURL *)url;        //读文件
- (NSArray *)listAllFilesAtDirectoryInURL:(NSURL *)url;  //获取目录下所有文件
- (BOOL)fileIsNotExistInURL:(NSURL *)url;     //判断文件是否存在
- (double)sizeOfFileInURL:(NSURL *)url;      //计算某个文件的大小
- (double)sizeOfAllFilesInDirectoryInURL:(NSURL *)url;   //计算某个目录下所有文件的总大小
- (BOOL)deleteFileInURL:(NSURL *)url;        //删除文件
- (BOOL)moveFileToURL:(NSURL *)destinURL fromURL:(NSURL *)loactionURL; //移动文件
@end
