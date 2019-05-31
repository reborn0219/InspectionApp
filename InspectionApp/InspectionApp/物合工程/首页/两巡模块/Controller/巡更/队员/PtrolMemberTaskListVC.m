//
//  PtrolMemberTaskListVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PtrolMemberTaskListVC.h"

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
#import "PatrolPatrolTaskListVC.h"
#import "PPTaskListModel.h"
#import "PatrolPatrolView.h"
#import "PPSelectCarVC.h"
#import "PatrolOrderListVC.h"
#import "PtrolMemberOrderListVC.h"
#import "TaskListModel.h"

@interface PtrolMemberTaskListVC ()<XXPageTabViewDelegate>
@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (nonatomic,assign)NSInteger orderCycle;
@property (nonatomic,strong)PageOneViewController * selectVC;

@end

@implementation PtrolMemberTaskListVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:1];
    [self setBarTitle:@"巡查任务"];
    [self pageTabViewDidEndChange];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setHidden:NO];
    [self hiddenNaBar];
}
#pragma mark - 初始化UI
-(void)creatUI{
    
    
    PageOneViewController *test1 = [self makeVC];
    UIViewController *test2 = [self makeVC];
    UIViewController *test3 = [self makeVC];
    UIViewController *test4 = [self makeVC];
    UIViewController *test5 = [self makeVC];
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"全部",@"巡查中",@"已结束"]];
    self.pageTabView.frame = CGRectMake(0,NavBar_H, self.view.frame.size.width, self.view.frame.size.height-60);
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
    
}

#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    _selectVC = [self.childViewControllers  objectAtIndex:self.pageTabView.selectedTabIndex];
    [_selectVC requestData:self.pageTabView.selectedTabIndex  cycle:self.orderCycle];
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
    vc.pageType = PageOneTypeXunChaMember;
    MJWeakSelf
    vc.viewBlock = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        
        TaskListModel *taskModel = data;
        PtrolMemberOrderListVC * pmoVC = [[PtrolMemberOrderListVC alloc]init];
        pmoVC.work_id = taskModel.work_id;
        [weakSelf.navigationController pushViewController:pmoVC animated:YES];
        
    };
    return vc;
    
    
}
-(void)rightBarAction:(NSInteger)type{
    
    PPSelectCarVC * ppcVC = [[PPSelectCarVC alloc]init];
    ppcVC.titleStr = @"请选择周期";
    [ppcVC showInVC:self Type:1];
    ppcVC.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        PPCarModel *carModel = data;
        self.orderCycle = [carModel.car_id integerValue];
        [self.selectVC requestData:self.pageTabView.selectedTabIndex cycle:self.orderCycle];
    };
}

@end
