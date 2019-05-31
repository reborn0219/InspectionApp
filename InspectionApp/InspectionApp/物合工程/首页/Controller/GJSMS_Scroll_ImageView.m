//
//  GJSMS_Scroll_ImageView.m
//  GJSMS_Scroll_ImageView
//
//  Created by dllo on 15/10/16.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "GJSMS_Scroll_ImageView.h"



#define WIDE self.frame.size.width
#define HEIGHT self.frame.size.height
@interface GJSMS_Scroll_ImageView ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) NSTimer *Timer;
@property (nonatomic, retain) UILabel *numberLabel1;
@property (nonatomic, retain) UILabel *numberLabel2;
@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger count1;
@property (nonatomic, assign) NSInteger count2;
@property (nonatomic, assign) CGFloat time;

@end
@implementation GJSMS_Scroll_ImageView

- (instancetype)initWithSMS_ImagePath1:(NSString *)path1 ImagePath2:(NSString *)path2 ImageCount:(NSInteger)count IntervalTime:(CGFloat)time Frame:(CGRect)frame PageControl:(BOOL)pageControl PageNumber:(BOOL)pageNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = count;
        self.count1 = count + 1;
        self.count2 = count + 2;
        self.time = time;
#warning - 创建ScrollView 加入self
        self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HEIGHT)];
        _scroll.contentSize = CGSizeMake(_count2 * WIDE, HEIGHT);
        _scroll.delegate = self;
        //取消水平和垂直滚动条
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        //分页
        _scroll.pagingEnabled = YES;
        //取消弹簧
        _scroll.bounces = NO;
//添加到self
        [self addSubview:_scroll];
#pragma mark - 创建ImgView 附图片 加入scrollView
//如果使用PageNumber标识 创建总数label 加入self上
        if (pageNumber == YES) {
            self.numberLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDE - 30, HEIGHT - 35, 30, 30)];
            _numberLabel2.text = [NSString stringWithFormat:@"/%ld", count];
            [self addSubview:_numberLabel2];
        }
        for (NSInteger i = - 1; i < _count1 ; i++) {
            //第一个位置放最后一个图片
            UIImageView *imgView = [[UIImageView alloc]init];
            [_scroll addSubview:imgView];
//如果使用PageNumber 创建当前页数label 加入imageView
            if (pageNumber == YES) {
                _numberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDE - 50, HEIGHT - 35, 30, 30)];
            }
            if (i == - 1) {
                imgView.frame = CGRectMake(0, 0, WIDE, HEIGHT);
                NSString *path=[NSString stringWithFormat:@"%@4%@",path1,path2];
//                NSString *path = [[NSBundle mainBundle] pathForResource:[path1 stringByAppendingFormat:@"%02ld", count - 1] ofType:path2];
                NSLog(@"%@",path);
                [imgView setImage:[UIImage imageNamed:path]];

                _numberLabel1.text = [NSString stringWithFormat:@"%ld", count];
                [imgView addSubview:_numberLabel1];
            }
            else if ( i < _count) {
                imgView.frame = CGRectMake(WIDE * (i + 1), 0, WIDE, HEIGHT);
                NSString *path=[NSString stringWithFormat:@"%@%ld%@",path1,4,path2];

                
//                NSString *path = [[NSBundle mainBundle] pathForResource:[path1 stringByAppendingFormat:@"%02ld",i] ofType:path2];
                [imgView setImage:[UIImage imageNamed:path]];
                _numberLabel1.text = [NSString stringWithFormat:@"%ld", i + 1];
                [imgView addSubview:_numberLabel1];
            }
            //最后一个位置放第一张图片
            else {
                imgView.frame = CGRectMake(WIDE * (i + 1), 0, WIDE, HEIGHT);
                NSString *path=[NSString stringWithFormat:@"%@4%@",path1,path2];

//                NSString *path = [[NSBundle mainBundle] pathForResource:[path1 stringByAppendingFormat:@"00"] ofType:path2];
                [imgView setImage:[UIImage imageNamed:path]];


                _numberLabel1.text = [NSString stringWithFormat:@"1"];
                [imgView addSubview:_numberLabel1];
            }
            if (pageNumber == YES) {
            }
        }
#pragma mark - 首次scrollView偏移量
        _scroll.contentOffset = CGPointMake(WIDE, 0);
#pragma mark -  创建PageControl
        if (pageControl == YES) {
            self.pageControl = [[UIPageControl alloc] init];
            _pageControl.numberOfPages = _count;
            _pageControl.currentPage = 0;
            CGSize size = [_pageControl sizeForNumberOfPages:count];
            _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
            _pageControl.center = CGPointMake(WIDE-50, HEIGHT - 20);
            //设置颜色
            _pageControl.pageIndicatorTintColor = [UIColor grayColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
            [self addSubview:_pageControl];
            [_pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        }
#pragma mark - 调用定时器方法
        [self startTimer];
    }
        return self;
}

- (void)pageChange:(UIPageControl *)page
{
    [_scroll setContentOffset:CGPointMake((page.currentPage + 1) * WIDE, WIDE) animated:YES];
}
#pragma mark - 定时器开始
- (void)startTimer
{
    self.Timer = [NSTimer timerWithTimeInterval:_time target:self selector:@selector(imageChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_Timer forMode:NSRunLoopCommonModes];
}
#pragma mark - 拖拽开始停止时钟
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止时钟
    [_Timer invalidate];
}
#pragma mark - 拖拽结束开始时钟
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
#pragma mark - 定时器方法 通过偏移量实现切换图片
- (void)imageChange
{
    [self.scroll setContentOffset:CGPointMake(self.scroll.contentOffset.x + WIDE, 0) animated:YES];
    CGPoint temp =  _scroll.contentOffset;
    if (temp.x == 0) {
        self.scroll.contentOffset = CGPointMake(_count * WIDE, 0);
    }
    if (temp.x == _count1 * WIDE) {
        self.scroll.contentOffset = CGPointMake(1 * WIDE, 0);
    }
}
#pragma mark - scrollView偏移量改变 实现图片切换
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint temp = scrollView.contentOffset;
    if (temp.x == _count1 * WIDE) {
        _scroll.contentOffset = CGPointMake(WIDE, 0);
    }
    else if (temp.x == 0){
        self.scroll.contentOffset = CGPointMake(_count * WIDE, 0);
    }
}
#pragma mark - 实现PageControl随着偏移量 改变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger tempPage = _scroll.contentOffset.x  / WIDE - 1;
    if (tempPage == _count) {
        tempPage = 0;
        scrollView.contentOffset = CGPointMake(WIDE, 0);
    }
    _pageControl.currentPage = tempPage;
}

- (instancetype)initWithSMS_ImageURLArr:(NSMutableArray *)URLArr
                           IntervalTime:(CGFloat)time
                                  Frame:(CGRect)frame
                            PageControl:(BOOL)pageControl
                             Pagenumber:(BOOL)pageNumber
                             TitleFrame:(CGRect)titleframe
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = URLArr.count;
        self.count1 = URLArr.count + 1;
        self.count2 = URLArr.count + 2;
        self.time = time;
#pragma mark - 创建scrollView 加到self
        self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDE, HEIGHT)];
//        _scroll.backgroundColor = [UIColor blackColor];
        _scroll.contentSize = CGSizeMake(_count2  * WIDE, 0);
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.bounces = NO;
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
        [self addSubview:_scroll];
#if 1
#pragma mark - 创建ImageView 加到ScrollView
//如果用PageNumber 开辟页码总数label
        if (pageNumber == YES) {
            self.numberLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDE - 20, HEIGHT - 35, 30, 30)];
            _numberLabel2.text = [NSString stringWithFormat:@"/%ld", URLArr.count];
            [self addSubview:_numberLabel2];
        }
        for (NSInteger i = - 1; i < _count1; i++) {
            UIImageView *temp = [[UIImageView alloc] init];
            [_scroll addSubview:temp];
            if (titleframe.size.height != 0 && titleframe.size.width != 0) {
                self.titleLabel = [[UILabel alloc] initWithFrame:titleframe];
//                _titleLabel.backgroundColor = [UIColor blackColor];
            }
            if (pageNumber == YES) {
                _numberLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDE - 30, HEIGHT - 35, 30, 30)];
            }
//创建ImageView 加到 scrollView
            if (i == - 1) {
                temp.frame = CGRectMake(0, 0, WIDE, HEIGHT);
                NSURL *url = [NSURL URLWithString:URLArr.lastObject];
                [temp sd_setImageWithURL:url];
                self.titleLabel.text = _titleArr.lastObject;
                
                _numberLabel1.text = [NSString stringWithFormat:@"%ld", URLArr.count];
//                _titleLabel.frame  =  [self.delegate FrameLabel];
                [temp addSubview:_numberLabel1];
                [temp addSubview:_titleLabel];
            }
            else if (i < _count1 - 1){
                temp.frame = CGRectMake(WIDE * (i + 1), 0, WIDE, HEIGHT);
                NSURL *url = [NSURL URLWithString:URLArr[i]];
                [temp sd_setImageWithURL:url];
                self.titleLabel.text = _titleArr[i];
                _numberLabel1.text = [NSString stringWithFormat:@"%ld", i + 1];
                [temp addSubview:_numberLabel1];
                [temp addSubview:_titleLabel];
            }
            else{
                temp.frame = CGRectMake(WIDE * (i + 1), 0, WIDE, HEIGHT);
                NSURL *url = [NSURL URLWithString:URLArr.firstObject];
                [temp sd_setImageWithURL:url];
                self.titleLabel.text = _titleArr.firstObject;
                _numberLabel1.text = @"1";
                [temp addSubview:_numberLabel1];
                [temp addSubview:_titleLabel];
            }
            if (pageNumber == YES) {
            }
            if (_titleArr.count != 0) {
            }
        }
#endif
//首次scrollView偏移量
        _scroll.contentOffset = CGPointMake(WIDE, 0);
    }
#pragma 创建PageControl 加到self
    if (pageControl == YES) {
        self.pageControl = [[UIPageControl alloc] init];
        [self addSubview:_pageControl];
        _pageControl.numberOfPages = _count;
        _pageControl.currentPage = 0;
        CGSize size = [_pageControl sizeForNumberOfPages:_count];
#warning 可修改PageControl坐标;
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(WIDE/2, HEIGHT - 20);

        //设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        [_pageControl addTarget:self action:@selector(imageChange) forControlEvents:UIControlEventValueChanged];
    }
#pragma mark - 调用定时器方法
    [self startTimer];
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
