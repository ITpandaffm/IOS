//
//  ViewController.m
//  XMLParser
//
//  Created by ffm on 16/9/19.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
    xml数据来自作业解答提示给的那个博客上的示例数据 
    然后解析完之后写成字符串写在txt文件里了
    发现好像变成了JSON数据格式 哇咔咔
 
 */
#import "ViewController.h"

@interface ViewController ()<NSXMLParserDelegate>

@property(nonatomic, strong) NSMutableDictionary *dataDict;
@property(nonatomic, strong) NSMutableDictionary *currentDict;
@property(nonatomic, strong) NSMutableDictionary *memberDict;
@property(nonatomic, copy) NSString *currentStr;
@property(nonatomic, strong) NSMutableArray *memberMurArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"XMLData" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:strPath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}


#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始检索!");
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"meeting"])
    {
        NSString *num = attributeDict[@"addr"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [self.dataDict setValue:dict forKey:num];
        self.currentDict = dict;
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.currentStr = str;
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{

    if ([elementName isEqualToString:@"meeting"])
    {
        NSArray *arr = [[NSArray alloc] initWithArray:self.memberMurArr];
        [self.currentDict setValue:arr forKey:@"member"];
        [self.memberMurArr removeAllObjects];
        
    } else if ([elementName isEqualToString:@"creator"])
    {
        [self.currentDict setValue:self.currentStr forKey:@"creator"];
    } else if ([elementName isEqualToString:@"member"])
    {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:self.memberDict];
        [self.memberMurArr addObject:dict];
        [self.memberDict removeAllObjects];
        
    } else if ([elementName isEqualToString:@"name"])
    {
        [self.memberDict setValue:self.currentStr forKey:@"name"];
    } else if ([elementName isEqualToString:@"age"])
    {
        [self.memberDict setValue:self.currentStr forKey:@"age"];
    }
    
}



- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"检索完毕!");
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.dataDict options:0 error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *strPath = [NSTemporaryDirectory() stringByAppendingString:@"text.txt"];
    if ([str writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"写入成功!");
    }
    NSLog(@"%@",self.dataDict);
}

#pragma mark - 懒加载
- (NSDictionary *)dataDict
{
    if (!_dataDict)
    {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(NSString *)currentStr
{
    if (!_currentStr)
    {
        _currentStr = [[NSString alloc] init];
    }
    return _currentStr;
}

- (NSMutableArray *)memberMurArr
{
    if (!_memberMurArr)
    {
        _memberMurArr = [NSMutableArray array];
    }
    return _memberMurArr;
}

- (NSMutableDictionary *)currentDict
{
    if (!_currentDict)
    {
        _currentDict = [NSMutableDictionary dictionary];
    }
    return _currentDict;
}

- (NSMutableDictionary *)memberDict
{
    if (!_memberDict)
    {
        _memberDict = [NSMutableDictionary dictionary];
    }
    return _memberDict;
}
@end
