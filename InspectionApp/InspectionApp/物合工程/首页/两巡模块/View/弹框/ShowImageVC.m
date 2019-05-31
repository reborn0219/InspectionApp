//
//  ShowImageVC.m
//  物联宝管家
//
//  Created by guokang on 2019/4/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "ShowImageVC.h"

@interface ShowImageVC ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView  *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic, assign)int page;
@end

@implementation ShowImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:tap];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)clickToBack
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)setImageWithImageArray:(NSMutableArray *)imageArr withIndex:(int)index
{
    _page = index;
    for (int i = 0; i <imageArr.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*KScreenWigth+SCREEN_WIDTH-80,15+NavBar_H,60, 40)];
        btn.tag = i+100;
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.contentMode =     UIViewContentModeScaleAspectFit;
        [imageV setFrame:CGRectMake(i*KScreenWigth, 0, KScreenWigth, KScreenHeight)];
        id obj = imageArr[i];
        if ([obj isKindOfClass:[NSString class]] ) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:obj]];
            [btn setHidden:YES];
            
        }else if ([obj isKindOfClass:[UIImage class]]){
            [btn setHidden:NO];
            imageV.image = obj;
        }
        [self.scrollView addSubview:imageV];
        [self.scrollView addSubview:btn];
    }
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imageArr.count, SCREEN_HEIGHT);
    _pageControl.numberOfPages = imageArr.count;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index,0)];
    
}
-(void)deleteAction:(UIButton*)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    if (_block) {
        _block(sender.tag-100);
    }
}
-(UIScrollView * )scrollView{
    
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KScreenWigth, KScreenHeight)];
        _scrollView.contentSize = CGSizeMake(KScreenWigth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setBackgroundColor:[UIColor blackColor]];
    }
    return _scrollView;
    
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
        _pageControl.currentPageIndicatorTintColor = HexRGB(0x51BAF4);
        _pageControl.pageIndicatorTintColor = HexRGB(0xF3F3F3);

    }
    return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = sender.contentOffset.x /SCREEN_WIDTH;
    _pageControl.currentPage = page;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
