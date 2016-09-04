//
//  ViewController.m
//  PicCarousel
//
//  Created by ffm on 16/8/1.
//  Copyright © 2016年 ITPanda. All rights reserved.

/**
 1.添加UIScrollView
 2.添加图片控件
 3.设置UIScrollView属性 （分页）
 4.添加UIControlPage
 5.手动轮播
 6.定时轮播（通过定时器）
 */
/**
 * pageControl是放在self.view， 不能放在scrollview里，不然随着翻页会被翻走（冲走）
 结合代理的知识，scrollview设置代理，当翻页（scrollviewdidscroll）改变self.pagecontrol的currentpage
 = self.scrolView.contentOffSet.x / width ; 利用scrollview的x的偏移计算当前页
 
 换页的的话要改变scrollview的偏移量，就要修改contentOffset属性的x值 但是要修改contentOffset要用CGPoint  scrollview.contentOffset = CGPointMake (scrollview.contentOffset.x - picWidth , 0)
 */
/**
 *  就是如果快速连续点击 没切换完  动画到一半 ，再点击的时候 就会以当前的contentOffset 去加减 picWidth . 出现卡在中间的尴尬
 
 解决： 记录最后一次点击的时间，如果再次点击时两次之间的时间间隔小于这个数，就不响应这次点击
 定义一个属性纪录最后点击的时间，存取每次点击的时间，然后每次点击都判断跟上次点击的时间间隔 如果小于动画切换的时间 就取消这次点击
 
 要实现无限循环 如果要显示图片 0，1，2，3，4  那么实际上就有 4，0，1，2，3，4，0 六张图片
 在“最后一张图片”4号再往后滑时 出现的是第二个0号 ，但实际上scrollview滚到了第一个0号那里
 */
/**
 *  8.2重大更新：1.逻辑的优化，在狂点button的时候，出现卡顿（其实是点击时间间隔太短所以取消了）影响交互体验，所以其实可以改变思路，每次点击先改变currentPage，然后再根据cureentpage去算是第几张 就算到了边界 也先设置偏移移到隐藏图片处 再”清零“currentpage，再进行偷天换日
 2.代码优化，相同类型的尽量放在一起，例如scrollview代理的方法就放一块等等～
 */

#import "ViewController.h"
#define picCount 6
#define picWidth 200
#define picHeight 200



@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDate *lastClick;        //纪录上一次点击button的时间
@property (weak, nonatomic) IBOutlet UIButton *nextButton;  //下一张
@property (weak, nonatomic) IBOutlet UIButton *previousButton;  //上一张
@property (nonatomic, strong) NSTimer *timer;       //计时器


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentOffset = CGPointMake(picWidth, 0);  //初始显示画面
    self.scrollView.delegate = self;   //代理
    self.pageControl.frame = CGRectMake(100, 200+picHeight-20, picWidth , 20);
    self.pageControl.numberOfPages = picCount;
    [self.view addSubview:self.scrollView];
    [self.view bringSubviewToFront:self.pageControl];
    [self addTimer];
    
}

#pragma mark UIScrollView懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 200, picWidth, picHeight) ];
        _scrollView.contentSize = CGSizeMake((picCount+2) * picWidth, picHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = FALSE;
        // _scrollView.bounces = FALSE; //超过contentsize的不显示，因本身就已经另外隐藏了两张图片
        [self initPic];
    }
    return _scrollView;
}

#pragma mark 加载图片
- (void)initPic
{
    NSString *picName;
    UIImageView *img;
    img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.jpg"]];
    img.frame = CGRectMake(0, 0, picWidth, picHeight); //添加最后一张图片到最前面
    [self.scrollView addSubview:img];
    for (int i = 1; i <= picCount; i++)
    {
        picName = [[NSString alloc] initWithFormat:@"%d.jpg",i];
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picName]];
        img.frame = CGRectMake(i*picWidth, 0, picWidth, picHeight);
        [self.scrollView addSubview:img];
    }
    img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    img.frame = CGRectMake(7*picWidth, 0, picWidth, picHeight); //添加第一张照片到最后面
    [self.scrollView addSubview:img];
}


#pragma mark scrollViewWillBeginDragging 当滑动的时候取消计时器 （还有点击button的时候也要取消）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self judgeEgde];
    [self removeTimer];
}

- (void)removeTimer
{
    [self.timer invalidate];
}

#pragma mark scrollViewDidEndDecelerating 滑动结束且减速停止的时候（图片“站稳了”）才改变pageControl的currentPage

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self judgeEgde];
    self.pageControl.currentPage = (self.scrollView.contentOffset.x / picWidth) -1;
    [self addTimer];
    NSLog(@"scrollviewDidEnd:%lu",self.pageControl.currentPage);
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(next:) userInfo:nil repeats:YES];
}


#pragma mark 点击事件
- (IBAction)previous:(id)sender
{
    [self changePic: self.previousButton];
}

- (IBAction)next:(id)sender
{
    [self changePic: self.nextButton];
}

- (void)changePic: (UIButton *)btn
{
    [self removeTimer];//取消计时器
    long currentPage = self.pageControl.currentPage;
    [self judgeEgde];
    if (btn.tag ==10)   //上一张
    {
        if (currentPage-1 < 0)
        {
            self.pageControl.currentPage = (currentPage-1) + picCount;
            [self.scrollView setContentOffset:CGPointZero animated:YES];
            self.pageControl.currentPage = picCount - 1;
        } else
        {
            self.pageControl.currentPage--;
            [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+1) * picWidth, 0) animated:YES];
            
        }
    } else if (btn.tag == 20)
    {
        
        if (currentPage+1 == picCount)
        {
            [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+2) * picWidth, 0) animated:YES];
            self.pageControl.currentPage = (currentPage+1) % picCount;
        } else
        {
            self.pageControl.currentPage =currentPage + 1;
            [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+1) * picWidth, 0) animated:YES];
        }
    }
    [self judgeEgde];
    [self addTimer]; //点击事件结束要把计时器重新安上
}


#pragma mark judgeEdge判断边界
- (void)judgeEgde
{
    if (self.scrollView.contentOffset.x >= (picCount+1)*picWidth)
    {
        self.scrollView.contentOffset = CGPointMake(picWidth, 0);
    }
    else if (self.scrollView.contentOffset.x < picWidth)
    {
        self.scrollView.contentOffset = CGPointMake(picCount * picWidth, 0);
    }
}

@end
