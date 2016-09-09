//
//  WaterFallCollectionViewCell.m
//  WaterFall
//
//  Created by ffm on 16/8/5.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"
#import "ViewController.h"
extern CGFloat const colCount;

@interface WaterFallCollectionViewCell ()

@property (nonatomic, strong) UIImageView *myPicView;
@property (nonatomic, strong) NSNumber *picWidth;

@end


@implementation WaterFallCollectionViewCell

#pragma mark createCell 创建类方法
+ (instancetype)createCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier
{
        WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[WaterFallCollectionViewCell alloc] init];
    }
    return cell;
}

#pragma mark 重写image的setter方法
- (void)setImage:(UIImage *)image
{
    if (_image != image)
    {
        _image = image;
    }
    self.myPicView.image = _image;
    float newHeight = _image.size.height / _image.size.width * [self.picWidth doubleValue];
    self.myPicView.frame = CGRectMake(0, 0, [self.picWidth doubleValue], newHeight);
    [self.contentView addSubview:_myPicView];
}

#pragma mark myPicView懒加载
- (UIImageView *)myPicView
{
    if (!_myPicView)
    {
        _myPicView = [[UIImageView alloc] init];
    }
    return _myPicView;
}

#pragma mark picWidth懒加载, 根据屏幕宽度算出图片的宽度
- (NSNumber *)picWidth
{
    if (!_picWidth)
    {
        _picWidth = [[NSNumber alloc] initWithDouble: (([UIScreen mainScreen].bounds.size.width - (colCount+1)*5) / 3)];
    }
    return _picWidth;
}


@end
