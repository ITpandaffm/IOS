//
//  ViewController.m
//  SingerBrower
//
//  Created by ffm on 16/7/18.
//  Copyright © 2016年 ITPanda. All rights reserved.
//
/**
 *  7.18更新
    设置了button高亮状态，模拟了点击效果。提高了用户体验，
    同时解决了hightlight设置时间点的逻辑问题，优化了交互细节（如button为禁用时不能有点击效果）
 */
/**
 *  7.19更新
    解决了屏幕适配的问题，图片是居中的 然后根据图片来调整其他控件的位置达到适配不同屏幕的效果
 */

/**
 *  7.19二轮更新
    使用懒加载优化了代码，让各个控件初始化实现懒加载
    对于首页禁用上一张button等button禁用与hightlighted的问题，重新实现了一下，换成课程中那种更好理解的逻辑。
    对于按钮状态的改变，不写在点击函数里 button的状态的改变应该是跟图片内容等一起改变的 所以改写在控件内容切换里
 */

#import "ViewController.h"
#import "singerModel.h"
@interface ViewController ()

//设置一个数组来保存所有数据
@property (nonatomic, strong) NSMutableArray *arrayAll;

@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) UIImageView *myPic;
@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, assign) int iIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  因为使用了懒加载，控件的初始化都写在了getter方法里，所以没有必要另外声明一个setup（）来把所有控件的初始化都放在那里了。
     */
//    [self setup];
    
    [self adjust];        //控件位置调整
    
    [self changePic:0];     //控件内容初始化

}


#pragma mark 数组懒加载

- (NSMutableArray *) arrayAll
{
    if (!_arrayAll)
    {
        _arrayAll = [NSMutableArray array];
        NSString *strPath = [[NSBundle mainBundle] pathForResource:@"picList.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:strPath];
        for (NSDictionary *dict in arr)
        {
            singerModel *model = [singerModel singerModelWithDict:dict];
            [_arrayAll addObject:model];
        }
    }
    return _arrayAll;
}

#pragma mark 各个控件的懒加载初始化

//UILabel（上方显示条）
- (UILabel *) myLabel
{
    if (!_myLabel)
    {
        _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 80, 170, 50)];
        [_myLabel setBackgroundColor:[UIColor redColor]];
        _myLabel.font = [UIFont fontWithName:@"Helvetica" size:28] ;
        _myLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_myLabel];
//        self.myLabel = content;     //这些self.xxx = xxx的代码如果用懒加载的话都可以删掉了，因为本来就是在getter方法里面
    }
    return _myLabel;
}


//中间图片
- (UIImageView *) myPic
{
    if (!_myPic)
    {
        _myPic = [[UIImageView alloc] initWithFrame:CGRectMake(70, 120, 200, 200)];
        _myPic.center = self.view.center;    //使图片的中心点与父视图的中心点相等，从而实现图片的居中
        _myPic.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_myPic];
    }
    return _myPic;
}

//UIButton上一张
- (UIButton *) previousBtn
{
    if (!_previousBtn)
    {
        _previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 350, 80, 50)];
        [_previousBtn setTitle:@"上一张" forState:UIControlStateNormal];
        [_previousBtn setBackgroundColor:[UIColor blueColor]];
        _previousBtn.tag = 1;
        [_previousBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];  //添加点击事件
        [_previousBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.view addSubview:_previousBtn];
    }
    return _previousBtn;
}


//UIButton下一张
- (UIButton *) nextBtn
{
    if (!_nextBtn)
    {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 350, 80, 50)];
        [_nextBtn setTitle:@"下一张" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:[UIColor blueColor]];
        _nextBtn.tag = 2;
        [_nextBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];    //添加点击事件
        [_nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

#pragma mark 点击事件

- (void)click: (UIButton *) btn
{
    if (btn.tag == 1)       //上一张
    {
        
        if (self.iIndex > 0)
        {
            self.iIndex--;
            [self changePic:self.iIndex];
        }

    }
    else if (btn.tag == 2)      //下一张
    {
        if (self.iIndex < self.arrayAll.count-1)
        {
            self.iIndex++;
            [self changePic:self.iIndex];
        }

        
    }
}

#pragma mark 控件内容的切换

- (void)changePic: (int) index
{
    if (index >= 0 || index < self.arrayAll.count) {                 //对合法性进行判断
        singerModel *model = self.arrayAll[index];
        NSString *strInfo = [[NSString alloc] initWithFormat:@"%@ %d/%lu", model.name, index+1, (unsigned long)self.arrayAll.count];
        self.myLabel.text = strInfo;
        self.myPic.image = [UIImage imageNamed:model.pic];
    }
    
    //根据特定情况改变button的状态 以提高用户体验
    if (index == 0)
    {
        self.previousBtn.backgroundColor = [UIColor grayColor];
        self.previousBtn.enabled = NO;
    }
    else
    {
        self.previousBtn.backgroundColor = [UIColor blueColor];
        self.previousBtn.enabled = YES;
    }
    if (index == self.arrayAll.count-1) {
        self.nextBtn.backgroundColor = [UIColor grayColor];
        self.nextBtn.enabled = NO;
    }
    else
    {
        self.nextBtn.backgroundColor = [UIColor blueColor];
        self.nextBtn.enabled = YES;
    }
    
}


#pragma mark 控件位置调整

- (void)adjust
{
    /**
     *  调整控件间的坐标 解决屏幕适配问题
     已知中间图片是居中的 可以根据图片来调整其他控件
     */
    
    CGFloat picY = CGRectGetMinY(self.myPic.frame);
    
    //调整label的位置
    CGFloat labelX = (CGRectGetWidth(self.view.frame)-self.myLabel.frame.size.width) / 2;
    CGFloat labelY = (picY - self.myLabel.frame.size.height - 30);
    self.myLabel.frame = CGRectMake(labelX, labelY, self.myLabel.frame.size.width, self.myLabel.frame.size.height);
    
    //调整上一张button的位置
    CGFloat preBtnY = picY + self.myPic.frame.size.height + 30;
    CGFloat preBtnX = (CGRectGetWidth(self.view.frame)-self.previousBtn.frame.size.width) / 2 - 50;
    self.previousBtn.frame = CGRectMake(preBtnX, preBtnY, self.previousBtn.frame.size.width, self.previousBtn.frame.size.height);
    
    //调整下一张button的位置（y坐标跟上一张button的是一样的）
    CGFloat nextBtnX = (CGRectGetWidth(self.view.frame)-self.previousBtn.frame.size.width) / 2 + 50;
    self.nextBtn.frame = CGRectMake(nextBtnX, preBtnY, self.nextBtn.frame.size.width, self.nextBtn.frame.size.height);
}


@end
