//
//  ViewController.m
//  UsePlist
//
//  Created by ffm on 16/7/17.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import "studentModel.h"

@interface ViewController ()

@end

@implementation ViewController


/**
 *  
 1.获取路径
 2.读取文件
 3.解析数据
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //可以获取的文件路径
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"student.plist" ofType:nil];
    
    //读取文件
    NSArray *arr = [NSArray arrayWithContentsOfFile:strPath];
//    /**
//     *   NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:strPath]; 如果是NSDictionary类型则用这个
//     */
//    
//    for (NSDictionary *dic in arr) {
////        NSString *name = [dic objectForKey:@"name"];
////        NSString *sex = dic[@"sex"];
////        NSNumber *age = dic[@"age"];
////        NSLog(name,nil);
////        NSLog(sex,nil);
////        NSLog(@"%@",age);
//        studentModel *model = [studentModel studentModelWithDic:dic];
//        NSLog(@"%@%@%d", model.name, model.sex, model.age);
//    }
    
    /**
     通过kvc来设置
     
     -
  
    studentModel *stu = [[studentModel alloc] init];
    [stu setValue:@"张三疯" forKey:@"name"];
    [stu setValue:@"男男男" forKey:@"sex"];
    [stu setValue:@"255" forKey:@"age"];
//    NSLog(stu.name,nil);
//    NSLog(stu.sex,nil);
//    NSLog(@"%d",stu.age);
    
    //
      通过kvc来取值
     
    NSLog(@"%@%@%@", [stu valueForKey:@"name"], [stu valueForKey:@"sex"], [stu valueForKey:@"age"]);
    
    //注意age也是使用％@ 因为返回的是一个对象

    
    //使用kvc中的 setValue forKeyPath & valueForKeyPath方法
    studentModel *stu2 = [[studentModel alloc] init];
    [stu setValue:stu2 forKey:@"studentFriend"];
    [stu setValue:@"王思聪" forKeyPath:@"studentFriend.name"];
    NSLog(@"%@",[stu valueForKeyPath:@"studentFriend.name"]);
    
       */
    
    
    //模型转字典，并实现把字典写入文件。  打开文件发现是像plist一样。标明了key 等等
    for (NSDictionary *dic in arr) {
        studentModel *testModel = [studentModel studentModelWithDic:dic];
    
        NSDictionary *didTest = [testModel dictionaryWithValuesForKeys:@[@"name",@"age"]];
        [didTest writeToFile:@"/Users/fengwenguang/Desktop/text2.txt" atomically:YES];
    }
}

@end
