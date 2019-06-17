//
//  PatrolPatrolTaskListVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/18.
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
#import "PatrolPatrolTaskListVC.h"
#import "PPTaskListModel.h"
#import "PatrolPatrolView.h"
#import "PPSelectCarVC.h"
#import "PatrolOrderListVC.h"
#import "PatrolHttpRequest.h"
#import "TaskListModel.h"

@interface PatrolPatrolTaskListVC ()<XXPageTabViewDelegate>
@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (nonatomic, strong) PageOneViewController * selectVC;
@property (nonatomic,assign)NSInteger orderCycle;
@property (nonatomic,assign)NSInteger orderIndex;
@end

@implementation PatrolPatrolTaskListVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:1];
    [self setBarTitle:@"巡查任务列表"];
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
    test1.index = 0;
    UIViewController *test2 = [self makeVC];
    UIViewController *test3 = [self makeVC];
    UIViewController *test4 = [self makeVC];
    UIViewController *test5 = [self makeVC];
    
    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"全部",@"未到执行时间",@"未开始执行",@"巡察中",@"已结束"]];
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
    
}

#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    self.selectVC   = [self.childViewControllers  objectAtIndex:self.pageTabView.selectedTabIndex];
    self.orderIndex = self.pageTabView.selectedTabIndex;
    [self.selectVC requestData:self.orderIndex cycle:self.orderCycle];
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
    vc.pageType = PageOneTypeXunJian;
    MJWeakSelf
    vc.viewBlock = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        TaskListModel * model = data;
        if (index == -1) {
            if ([model.task_status intValue] == 2) {
                PPSelectCarVC * ppcVC = [[PPSelectCarVC alloc]init];
                
                ppcVC.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
                    PPCarModel *carModel  = data;
                    [weakSelf selectCarRequest:model.work_id carID:carModel.car_id  taskID:model.task_id];
                    
                };
                ppcVC.task_id = model.task_id;
                ppcVC.titleStr = @"请选择车辆";
                [ppcVC showInVC:weakSelf Type:0];
            }else{
                PatrolOrderListVC * polVC = [[PatrolOrderListVC alloc]init];
                polVC.work_id = model.work_id;
                polVC.task_id = model.task_id;
                polVC.task_status = model.task_status;
                polVC.type = @"1";
                [weakSelf.navigationController pushViewController:polVC animated:YES];
            }
        }
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
        [self.selectVC requestData:self.orderIndex cycle:self.orderCycle];
    };
   
}

#pragma mark - 选车去执行任务
-(void)selectCarRequest:(NSString *)work_id carID:(NSString *)car_id taskID:(NSString *)task_id{
    
    if (car_id.integerValue==0) {
        [PatrolHttpRequest inspecttaskexec:@{@"work_id":work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                PatrolOrderListVC * polVC = [[PatrolOrderListVC alloc]init];
                polVC.work_id = work_id;
                polVC.task_id = task_id;
                polVC.type = @"1";
                [self.navigationController pushViewController:polVC animated:YES];
            }
        }];
    }else{
        
        [PatrolHttpRequest carconfirm:@{@"car_id":car_id,@"task_id":task_id}:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {

                [PatrolHttpRequest inspecttaskexec:@{@"work_id":work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                    
                    if (resultCode == SucceedCode) {
                        PatrolOrderListVC * polVC = [[PatrolOrderListVC alloc]init];
                        polVC.work_id = work_id;
                        polVC.task_id = task_id;
                        polVC.type = @"1";
                        [self.navigationController pushViewController:polVC animated:YES];
                    }
                 }];
            }else{
                NSLog(@"参数=======");
            }
            
        }];
    }
}

@end


