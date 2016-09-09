//
//  ViewController.h
//  WaterFall
//
//  Created by ffm on 16/8/5.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

