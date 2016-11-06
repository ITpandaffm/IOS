//
//  ViewController.m
//  CoreDataTest
//
//  Created by ffm on 16/9/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController


#pragma mark - 插入数据
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    

    //插入一条数据
    NSManagedObject *entityDes = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    [entityDes setValue:@"袁璐大魔王" forKey:@"name"];
    [entityDes setValue:@170 forKey:@"age"];
    [entityDes setValue:@"哈喽哈哈哈" forKey:@"name"];
    [entityDes setValue:@1888 forKey:@"age"];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) saveContext];
//

}


@end
