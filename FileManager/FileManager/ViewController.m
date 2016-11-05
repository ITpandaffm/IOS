//
//  ViewController.m
//  FileManager
//
//  Created by ffm on 16/9/19.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  [URL absoluteString]的效果与 url.path 是一样的 都是把NSURL类型转化为NSString类型
 
 - (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError * _Nullable *)error
 这个方法 记得目标URL后面要包含所要移动的文件或者文件夹的名字
 */

#import "ViewController.h"
#import "FileManger.h"


@interface ViewController ()

@property (nonatomic, strong) FileManger *manager;
@property (nonatomic, strong) NSURL *tempURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createDirectory:(id)sender {
    //    创建文件夹
    if ([self.manager createDirectoryInURL:self.tempURL directoryName:@"/helloWorld"])
    {
        NSLog(@"成功\n");
    } else
    {
        NSLog(@"创建失败 已经存在相同名字的文件夹或者检查一下你的路径?");
    }
}

- (IBAction)createFIle:(id)sender {
    //创建文件
    if ([self.manager createFileInURL:self.tempURL fileName:@"/test.txt"]) {
        NSLog(@"大师兄文件创建好了\n");
    } else
    {
        NSLog(@"创建失败啦,.. 是不是路径有问题? 还是已经有了相同的文件名?");
    }
}

- (IBAction)readFIle:(id)sender {
    //读取文件
    NSData *data = [self.manager readFileInURL:[NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"test.txt"]]];
    NSDictionary *readDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@",readDict);
}

- (IBAction)writeFile:(id)sender {
    //写文件  把数据都封装成JSON数据 那么就符合题目要求的可写入字符串 数组 字典了
    NSDictionary *dict = @{@"name":@"ffm", @"age":@"38"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    
    NSURL *fileURL = [NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"test.txt"]];
    NSLog([fileURL absoluteString],nil);
    if ([self.manager writeToFileInURL:fileURL withContent:jsonData]) {
        NSLog(@"写入文件成功\n");
    }
    
    
    
}

- (IBAction)listAllFile:(id)sender {
    //获取目录下所有文件
    NSArray *filesArr = [self.manager listAllFilesAtDirectoryInURL:self.tempURL];
    for (NSString *strFileName in filesArr)
    {
        NSLog(strFileName, nil);
    }
}

- (IBAction)fileExist:(id)sender {
    //判断文件是否存在
    NSURL *fileURL = [NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"test.txt"]];
    if ([self.manager fileIsNotExistInURL:fileURL])
    {
        NSLog(@"该文件已经存在!");
    } else
    {
        NSLog(@"该文件不存在!");
    }
    
}

- (IBAction)fileSize:(id)sender {
    //计算某个文件的大小
    NSURL *fileURL = [NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"test.txt"]];
    double length = [self.manager sizeOfFileInURL:fileURL];
    NSLog(@"该文件大小为%f字节", length);
    
}

- (IBAction)directorySize:(id)sender {
    //计算某个目录下所有文件的总大小
    double length = [self.manager sizeOfAllFilesInDirectoryInURL:self.tempURL];
    NSLog(@"该文件夹大小为%f字节", length);
}

- (IBAction)deleteFile:(id)sender {
    //删除文件
    NSURL *fileURL = [NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"test.txt"]];
    if ([self.manager deleteFileInURL:fileURL])
    {
        NSLog(@"成功删除");
    }
}

- (IBAction)moveFile:(id)sender {
    //移动文件
    NSURL *fileURL = [NSURL URLWithString:[[self.tempURL absoluteString] stringByAppendingString:@"/test.txt"]];
    NSURL *DocuURL = [NSURL URLWithString:[self.tempURL.path stringByAppendingString:@"/helloWorld/test.txt"]];
    
    if ([self.manager moveFileToURL:DocuURL fromURL:fileURL])
    {
        NSLog(@"移动成功, 快去看看?");
    } else
    {
        NSLog(@"移动失败..检查一下你的路径..目的路径是否含有文件名");
    }
}

#pragma mark - 懒加载
- (FileManger *)manager
{
    if (!_manager)
    {
        _manager = [[FileManger alloc] init];
    }
    return _manager;
}

- (NSURL *)tempURL
{
    if (!_tempURL)
    {
        //把测试数据存储到程序的tmp文件夹里
        NSString *tmpStrPsth = NSTemporaryDirectory();
        _tempURL = [NSURL URLWithString:tmpStrPsth];
    }
    return _tempURL;
}

@end
