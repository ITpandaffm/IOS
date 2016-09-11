//
//  AddContactViewController.h
//  AddressBook
//
//  Created by ffm on 16/8/20.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddContactDelegate <NSObject>

- (void)addContactFinish:(NSString *)name userNum:(NSString *)number;

@end

@interface AddContactViewController : UIViewController

@property (nonatomic, weak) id<AddContactDelegate> delegate;

@end
