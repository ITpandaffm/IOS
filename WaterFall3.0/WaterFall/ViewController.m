//
//  ViewController.m
//  WaterFall
//
//  Created by ffm on 16/8/5.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  8.7凌晨4点呕血更新 .
    一行行代码摸索终于找到了问题根源所在
    先回顾一下问题:1.item上下间隙不稳定.. 2.没有插入最短高度的列..3.contentSize不准确,没有显示完全
    归根到底.其实是item的上下间距有问题..经过一行行代码排查.重新理解作者思路(代码几乎都是按着视频打的.所以上述问题教学视频中也有) 还有不断地调试...输出..断点
    终于发现了是cell的frame值没有设置好啊..😭
    在对每一个cell进行布局的时候,顺带定义了一个attribute, 把算好的frame赋!值!给!它!并通过index加入字典中.
    在后来.通过系统传入的rect(推测应该是当前屏幕的frame(显示的部分)
    再匹配好要显示的cell. 再通过index在字典中调取就好了...    //本来想直接返回attribute的数组的.不过为了性能考虑..还是像教学视频那样,,根据rect来选出要显示的cell好了.
    吐了一口老血..不过还是解决了..
 */
/**
 *  8.7号更新. 不把宽度写死 解决适配问题
    把colCount设为全局变量, 其他文件如果想访问的话就导入头文件并使用extern关键字
    (虽然感觉导入ViewController.h不太好..但是这里就懒得再另外开一个头文件保存全局变量了
    #import "ViewController.h"
    extern CGFloat const colCount;

 */

#import "ViewController.h"
#import "WaterFallFlowLayout.h"
#import "WaterFallCollectionViewCell.h"


CGFloat const colCount = 3;
CGFloat const kImgCount = 17;
static NSString *identifier = @"collectionView";
@interface ViewController ()

@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, strong) NSNumber *picWidth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}



#pragma mark UICollectionView懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        //创建UICollectionView之前要先创建布局
        WaterFallFlowLayout *flowLayout = [[WaterFallFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //在创建cell之前要注册单元格
        [_collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}


#pragma mark UICollectionViewDataSource
//一个section里有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgArr.count;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallCollectionViewCell *cell = [WaterFallCollectionViewCell createCell:collectionView cellForItemAtIndexPath:indexPath reuseIdentifier:identifier];
    cell.image = self.imgArr[indexPath.item];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
//item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *img = self.imgArr[indexPath.item];
    float height = [self imgHeight:img.size.height width:img.size.width];
    return CGSizeMake([self.picWidth doubleValue], height);
}

////section里的内容与collectionView框框的边距
- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInsets = {5, 5, 5, 5};
    return edgeInsets;
}
//
//列之间的最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//上下两个item之间最小的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 5;
}

#pragma mark imgArr懒加载
- (NSArray *)imgArr
{
    if (!_imgArr)
    {
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 1; i <= kImgCount; i++)
        {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d.jpg",i]];
            [muArr addObject:img];
        }
        _imgArr = muArr;        //把所有图片存入数组
    }
    return _imgArr;
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

#pragma mark methods
//求图片压缩后的高度
- (float)imgHeight: (float)height width: (float)width
{
    /**
     *  高度/宽度 = 压缩后的高度/压缩后的宽度
        列之间的间隙为5, 先算出宽度(注意适配)
     */
    float newHeight = height / width * [self.picWidth doubleValue];
    return newHeight;
}

@end
