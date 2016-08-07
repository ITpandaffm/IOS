//
//  ViewController.m
//  singerLayout
//
//  Created by ffm on 16/7/19.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

/**  7.19随记
 *  NSLog(model.name,model.songName,model.pic,nil);
    上述输出首先要注意加nil结尾，然后都要为NSString类型（目前发现总结的。。）
    而且只会输出第一个的值 中间后面的都被忽略了。。
 */
/**
 *  7.20随记
 *  看了一小点 又来倒腾一下，学会了用循环创建控件进行布局（就是每次都加间距＋控件宽度or高度
    一些相同的常量定义为宏 这样修改也方便一点
 */

/**
 *  7.24 到家重启哈哈
    看完视频之后发现了自己代码跟视频代码中的区别
    视频中的代码是先把上边距（第一行的view的y到屏幕顶部边距）是写死的
    然而我的纵向是跟横向一样，获取了屏幕的总高度之后减去一列view总高度再除以列上view个数
    
    由于在创建的时候要添加model 要对应arrAll的下标  所以放弃了二重循环 还是改用一重
 
    二轮更新 代码规范 模型类首字母大写，一些代码优化，间距的重新调控 还有关于
    使用UIScrollView进行优化
 *
 */
/**
 *  7.25更新
    代码一些细节的优化 本来想按照点评使用UIScrollView  但是折腾了一下午没弄出来 而且时间快到了 所以搁置建议 以后学了之后再回头完善这个。
 */
/**
 *  哇咔咔 按照老师的点评 算是成功使用了scrollView！  原来自己之前是顺序错了 一直把scrollview当做一个滚动条，然后一直想着把它add到view里 其实应该反过来，毕竟scrollview不能忽略后面也有个view 其实是一个可滚动的view而已 是uiview的一个子类
    下一个目标 使用UICollectionView (是UIScrollView的一个字类？（记得uitalbeview好像还要实现协议的一些方法）。因为UICollectionView自带了一套流水布局 所以对于九宫格特别适合。
    同时学习了下面两个课程，决定另起工程 用xib重新实现一遍，并且再实现view类的封装
 */
#import "ViewController.h"
#import "SingerModel.h"

#define Ymargin 70
#define viewWidth 80               //view的宽度高度
#define viewHeight 100
#define viewYmargin 25
#define colum 3

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *arrAll;

@property (nonatomic, retain) UIScrollView *myScrollView;  //这为啥要用retain？ 。。

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.view addSubview:self.myScrollView];
}


#pragma mark 控件的创建

- (void) setup
{
    int xMargin = (self.view.frame.size.width - viewWidth * colum) / (colum + 1);
    for (int i = 0; i < self.arrAll.count ; i++)
    {
        int iColumn = i % colum;
        int iRow = i / colum;
        int x = xMargin + iColumn * (xMargin+viewWidth);
        int y = Ymargin + iRow * (viewHeight+viewYmargin);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
        //        [mainView addSubview:view];
        [self addSubControl:view model:self.arrAll[i]];
        [self.myScrollView addSubview: view];
    }
}

#pragma mark scrollView

- (UIScrollView *)myScrollView
{
    if (!_myScrollView)
    {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    _myScrollView.directionalLockEnabled = YES;  //只能一个方向滑动
    _myScrollView.pagingEnabled = NO;  //是否翻页
    _myScrollView.showsVerticalScrollIndicator = YES;       //垂直方向的滚动指示
    _myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;     //滚动指示的风格
    _myScrollView.showsHorizontalScrollIndicator    = NO;   //水平方向的滚动指示
//    _myScrollView.delegate = self;            //这句会留警告。。不知道为啥
    /**
     *  计算最下面一个控件的最大y值
     */
    int y = Ymargin + (int)(self.arrAll.count / colum) * (viewHeight+viewYmargin) +viewHeight;
    CGSize newSize = CGSizeMake(self.view.frame.size.width, y+1);//这里的y值是要等于最下面的控件的最大的y值（底部） 否则像现在这样 就只能拉到屏幕高度＋1.。拉过了就会弹回来。。
    [_myScrollView setContentSize:newSize];
    return _myScrollView;
}

#pragma mark 给每一格添加内容

- (void)addSubControl: (UIView *)uiviewParent model:(SingerModel *)model
{
    //添加图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, uiviewParent.bounds.size.width, 50)];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [image setImage:[UIImage imageNamed:model.pic]];
    [uiviewParent addSubview:image];
    
    //添加Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, uiviewParent.bounds.size.width, 20)];
    [uiviewParent addSubview:label];
    label.font = [UIFont systemFontOfSize:13];          //改变字体大小
    label.adjustsFontSizeToFitWidth = true;  //无意中发现了这个属性，根据宽度自动调整大小
    label.text = model.songName;
    label.textAlignment = NSTextAlignmentCenter;
    
    //添加下载button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, uiviewParent.bounds.size.width, 20)];
    [button setBackgroundImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"下载" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 14];  //因为button没有font属性，但是button里面的titleLabel有啊
    [button addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    [uiviewParent addSubview:button];
    
}


#pragma mark button点击事件

- (void) download: (UIButton *)btn
{
    int x = (self.view.frame.size.width-100)/2;
    int y = self.view.frame.size.height-50;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 25)];
    tipLabel.backgroundColor  = [UIColor grayColor];
    tipLabel.alpha = 1 ;
    tipLabel.text = @"下载完成";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    
    //UIView 动画函数，动画持续2秒；
    [UIView animateWithDuration:2.0 animations: ^{
        tipLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [tipLabel removeFromSuperview];
    }];
    
    /**
     *  模仿上面 使得点击button也来个动画
     */
    btn.alpha = 0.4;
    [UIView animateWithDuration:0.8 animations: ^{
        btn.highlighted = YES;
        btn.alpha  = 1;
        [btn setBackgroundImage:[UIImage imageNamed:@"hightLighted.png"] forState:UIControlStateHighlighted];
    } completion: ^(BOOL finished) {
        btn.enabled = NO;
        btn.alpha = 0.8;
    }];
    
}
#pragma mark 保存plist所有数据的arrAll数组懒加载

- (NSMutableArray *)arrAll
{
    if (!_arrAll)
    {
        _arrAll = [NSMutableArray array];
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"picList.plist"
                                  ofType:nil];
        NSArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:strPath];
        
        for (NSDictionary *dict in arr)
        {
            SingerModel *model = [SingerModel singerModelWithDict:dict];
            [_arrAll addObject:model];
        }
    }
    return _arrAll;
}

@end
