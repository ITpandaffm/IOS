//
//  WaterFallFlowLayout.m
//  WaterFall
//
//  Created by ffm on 16/8/5.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "WaterFallFlowLayout.h"
#import "ViewController.h"
extern CGFloat const colCount;

@interface WaterFallFlowLayout ()

//视频中用的是assign ,但是weak比assign多了一个功能，当对象消失后自动把指针变成nil，好处不言而喻。
//但是第二个不可以为weak 会报错..

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout>delegate;
@property (nonatomic, assign) NSInteger cellCount; //cell的个数
@property (nonatomic, strong) NSMutableArray *colHeightArr; //存放列的高度
@property (nonatomic, strong) NSMutableDictionary *cellAttributeDict;//存放cell的位置信息
@property (nonatomic, strong) NSMutableDictionary *attributeDict;  //存放attribute


@end



@implementation WaterFallFlowLayout

#pragma mark prepareLayout准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    _colHeightArr = [NSMutableArray array];
    _cellAttributeDict = [NSMutableDictionary dictionary];
    _attributeDict = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    if (_cellCount == 0)
    {
        return;
    }
    //各列的高度初始化为0 注意在加入数组的时候要转化为NSNumber的对象
    float top = 0;
    for (int i = 0; i < colCount; i++)
    {
        [_colHeightArr addObject:[NSNumber numberWithFloat:top]];
    }
    
    //把i转化为Indx类型传入自定义的 cell的布局方法(因为indexPath可以唯一标记确定一个item 所以传indexPath
    for (int i = 0; i < _cellCount; i++)
    {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}

#pragma mark 为每个cell设置布局
- (void)layoutItemAtIndexPath: (NSIndexPath *)indexPath
{
    //通过协议得到sectoin与collectionView框框之间的间隙 (之前设置了是5,5,5,5)
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:0];
    
    //获取每个item的宽高
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    //找到高度最小的列,把cell放到最小高度的列当中
    float col = 0;
    float minHeightCol = [[_colHeightArr objectAtIndex:col] floatValue];
    for (int i = 0; i < _colHeightArr.count; i++)
    {
        float height = [[_colHeightArr objectAtIndex:i] floatValue];
        if (height < minHeightCol)
        {
            minHeightCol = height;
            col = i;
        }
    }
    if (minHeightCol == 0)
    {
        minHeightCol = edgeInsets.top;
    }
    //确定cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left+itemSize.width), minHeightCol , itemSize.width, itemSize.height);
    //更新列高;
    [_colHeightArr replaceObjectAtIndex:col withObject:
     [NSNumber numberWithFloat:minHeightCol + itemSize.height + edgeInsets.top]]; //这里就当上下item间距跟edgeInsets.top数值相同
    /**
     *  这里就是之前教材视频中代码bug解决办法的点睛之笔!!! (之前没有给每个cell的frame值设好啊! (#吐了一口老血..)
     */
    UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
    attribute.frame = frame;
    [_attributeDict setObject:attribute forKey:indexPath];
    
    //每个cell的frame对应一个IndexPath,放入字典中
    [_cellAttributeDict setObject:indexPath forKey:NSStringFromCGRect(frame)];
    
}


#pragma mark 根据系统传入的rect, 来判定在此rect范围内的cell(通过cell的frame) 来决定应该显示的cell
- (NSArray *)indexPathOfItem: (CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *rectStr in _cellAttributeDict)
    {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect))   //如果两个长方形(frame) 有交集,则为true
        {
            NSIndexPath *indexPath = _cellAttributeDict[rectStr];
            [array addObject:indexPath];
        }
    }
    return array;
}

#pragma mark layoutAttributesForElementsInRect返回cell的布局信息
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *muArr = [NSMutableArray array];
    //indexPathOfItem方法 根据传入的frame值计算当前应该显示的cell们
    NSArray *indexPaths = [self indexPathOfItem:rect];
    for (NSIndexPath *indexPath in indexPaths)
    {
        UICollectionViewLayoutAttributes *attribute = _attributeDict[indexPath];
        [muArr addObject:attribute];
    }
    return muArr;
}

#pragma mark collectionViewContentSize 计算collectionView的内容大小
- (CGSize)collectionViewContentSize
{
    CGSize size = self.collectionView.frame.size;
    //查找最高列的高度
    float maxHeight = [[_colHeightArr objectAtIndex:0] floatValue];
    float colHeight;
    for (int i = 0; i<_colHeightArr.count; i++)
    {
        colHeight = [[_colHeightArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight)
        {
            maxHeight = colHeight;
            
        }
    }
    size.height = maxHeight;
    return size;
}

@end
