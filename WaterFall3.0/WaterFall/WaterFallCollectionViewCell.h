//
//  WaterFallCollectionViewCell.h
//  WaterFall
//
//  Created by ffm on 16/8/5.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

+ (instancetype)createCell: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier;

@end
