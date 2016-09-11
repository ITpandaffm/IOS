//
//  UpdateViewController.h
//  AddressBook
//
//  Created by ffm on 16/8/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateContactDelegate <NSObject>

- (void)updateFinish:(NSString *)name newNumber:(NSString *)number;

@end


@interface UpdateViewController : UIViewController

@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *numberStr;

@property (nonatomic, weak) id<UpdateContactDelegate>delegate;

@end
