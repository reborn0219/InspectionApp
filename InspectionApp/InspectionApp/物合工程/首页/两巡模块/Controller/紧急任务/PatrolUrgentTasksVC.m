//
//  PatrolUrgentTasksVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define KTopHeight (kStatusBarHeight + kNavBarHeight)
#define KTarbarHeight  (kDevice_Is_iPhoneX ? 83 : 49)
#define KsegmentHeight 45
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KTabbarSafeBottomMargin  (kDevice_Is_iPhoneX ? 34 : 0)
#define KsegmentHeight 45


#import "XXPageTabView.h"
#import "PPViewTool.h"
#import "XXPageTabItemLable.h"
#import "PageOneViewController.h"
#import "PatrolUrgentTasksVC.h"
#import "PPTaskListModel.h"
#import "PatrolPatrolView.h"
#import "PPSelectCarVC.h"
#import "PatrolOrderListVC.h"
#import "PatrolUrgentMapDetailVC.h"
#import "PatrolUrgentOptionDetailVC.h"


@interface PatrolUrgentTasksVC ()<XXPageTabViewDelegate>
{
    CGFloat lastPoit_y;
}
@property (nonatomic, strong) XXPageTabView *pageTabView;
@end

@implementation PatrolUrgentTasksVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:0];
    [self setBarTitle:@"紧急任务"];
    [self pageTabViewDidEndChange];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setHidden:NO];
    [self hiddenNaBar];
}
#pragma mark - 初始化UI    [self pageTabViewDidEndChange];

-(void)creatUI{
    
    lastPoit_y = 0;
    PageOneViewController *test1 = [self makeVC];
    PageOneViewController *test2 = [self makeVC];
    PageOneViewController *test3 = [self makeVC];
    PageOneViewController *test4 = [self makeVC];
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
//    [self.mapView setFrame:CGRectMake(0, 0,KScreenWigth, KScreenHeight/2+NavBar_H)];
//    [self.mapView setAlpha:0];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"全部",@"未执行",@"执行中",@"已结束"]];
    self.pageTabView.frame = CGRectMake(0,NavBar_H, self.view.frame.size.width, self.view.frame.size.height-NavBar_H);
    self.pageTabView.delegate = self;
    //    self.pageTabView.bodyEnableScroll = NO;
    //    self.pageTabView.bodyBounces = NO;
    //    self.pageTabView.tabSize = CGSizeMake(self.view.frame.size.width, 40);
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleStretch;
    //    self.pageTabView.separatorColor = [UIColor grayColor];
    //    self.pageTabView.minScale = 1.0;
    //    self.pageTabView.selectedTabIndex = 0;
    //    self.pageTabView.selectedTabIndex = -1;
    //    self.pageTabView.selectedTabIndex = 4;
    //    self.pageTabView.maxNumberOfPageItems = 1;
    //    self.pageTabView.maxNumberOfPageItems = 7;
    //    self.pageTabView.tabItemFont = [UIFont systemFontOfSize:18];
    //    self.pageTabView.indicatorHeight = 5;
    self.pageTabView.indicatorWidth = 20;
    //    self.pageTabView.tabBackgroundColor = [UIColor redColor];
    self.pageTabView.unSelectedColor = [UIColor whiteColor];
    self.pageTabView.selectedColor = [UIColor whiteColor];
    
    //    self.pageTabView.tabSize = CGSizeMake(self.view.bounds.size.width-30, 0);
    [self.view addSubview:self.pageTabView];
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestAction:)];
//    [self.view addGestureRecognizer:pan];
    
}

#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    PageOneViewController * selectVC = [self.childViewControllers  objectAtIndex:self.pageTabView.selectedTabIndex];
    [selectVC requestData:self.pageTabView.selectedTabIndex];
}

#pragma mark - Event response
- (void)scrollToLast:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
}

- (void)scrollToNext:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
}

#pragma mark - Setter && Getter


- (PageOneViewController *)makeVC {
    PageOneViewController *vc = [[PageOneViewController alloc]init];
    vc.pageType = PageOneTypeJiJi;
    return vc;
    
}
//-(void)rightBarAction:(NSInteger)type{
//
//    PPSelectCarVC * ppcVC = [[PPSelectCarVC alloc]init];
//    ppcVC.titleStr = @"请选择周期";
//    [ppcVC showInVC:self withArr:@[@"年",@"月",@"周",@"日"]];
//}


//-(void)scrollAnimationUp{
//
//    MJWeakSelf
//    [UIView animateWithDuration:0.5 animations:^{
////        _backView.alpha = 1;
//        weakSelf.mapView.alpha = 0;
//
//        _pageTabView.transform = CGAffineTransformMakeTranslation(0,0);
//        weakSelf.topView.transform = CGAffineTransformMakeTranslation(0,0);
//    } completion:^(BOOL finished) {
//    }];
//
//}
//-(void)scrollAnimationDown{
//    MJWeakSelf
//    [UIView animateWithDuration:0.5 animations:^{
////        _backView.alpha = 0;
//        _pageTabView.transform = CGAffineTransformMakeTranslation(0,KScreenHeight/2);
//        weakSelf.topView.transform = CGAffineTransformMakeTranslation(0,KScreenHeight/2+NavBar_H);
//        weakSelf.mapView.alpha = 1;
//
//    }];
//}

//
//-(void)panGestAction:(UIPanGestureRecognizer *)pan{
//    
//    CGPoint transP = [pan translationInView:self.topView];
//    lastPoit_y = transP.y;
//    if (lastPoit_y>0) {
//        [self scrollAnimationDown];
//    }
//    if (lastPoit_y<0) {
//        [self scrollAnimationUp];
//    }
//    [pan setTranslation:CGPointZero inView:self.topView];
//    
//}

//- (void)refreshPageTabView:(id)sender {

//    for(UIViewController *vc in self.childViewControllers) {
//        [vc removeFromParentViewController];
//    }
//
//    UIViewController *test1 = [self makeVC];
//    UIViewController *test2 = [self makeVC];
//    UIViewController *test3 = [self makeVC];
//    UIViewController *test4 = [self makeVC];
//    UIViewController *test5 = [self makeVC];
//
//    [self addChildViewController:test1];
//    [self addChildViewController:test2];
//    [self addChildViewController:test3];
//    [self addChildViewController:test4];
//    [self addChildViewController:test5];
//
//    [self.pageTabView reloadChildControllers:self.childViewControllers childTitles:@[@"全部",@"未到执行时间",@"未开始执行",@"巡检中",@"已结束"]];
//}
@end


