//
//  GJAllWageViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/8/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJAllWageViewController.h"
#import "GJVoiceWageViewController.h"
#import "GJwageViewController.h"
#import "GJFZPBusinessTabbarTypeView.h"
#import "MLPoliceWorkOrderVC.h"
#import "MLSecurityListenOrderVC.h"

@interface GJAllWageViewController ()<SunSegmentViewDelegate>
{
    GJwageViewController *wageVC;
    MLPoliceWorkOrderVC *mlwageVC;
    GJVoiceWageViewController *VoiceWageVC;
    MLSecurityListenOrderVC * listenVC;
    UIViewController *currentvc;
    GJFZPBusinessTabbarTypeView *segmentView;
}

@end

@implementation GJAllWageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = NAVCOlOUR;
    self.view.backgroundColor = viewbackcolor;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(displayRedWage) name:@"displayRedWage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HiddenRedWage) name:@"HiddenRedWage" object:nil];
    
    segmentView = [[GJFZPBusinessTabbarTypeView alloc] initWithFrame:CGRectMake(1, 1, KScreenWigth/2, 30) withViewCount:2 withNormalColor:NAVCOlOUR withSelectColor:[UIColor whiteColor] withNormalTitleColor:[UIColor whiteColor] withSelectTitleColor:NAVCOlOUR];
    segmentView.titleArray = @[@"语音播报",@"工单列表"];
    segmentView.selectIndex = 0;
    segmentView.backgroundColor=[UIColor purpleColor];
    segmentView.titleFont=[UIFont systemFontOfSize:17];
    segmentView.segmentDelegate = self;
    
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWigth/2+2, 32)];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:segmentView];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.navigationItem setTitleView:view];
    //把这2个vc交给self管理
    wageVC = [[GJwageViewController alloc] init];
    mlwageVC = [[MLPoliceWorkOrderVC alloc]init];
   
    VoiceWageVC = [[GJVoiceWageViewController alloc] init];
    listenVC = [[MLSecurityListenOrderVC alloc]init];
    //把第一个设为默认视图
    if (_isAnBao) {
        [self addChildViewController:listenVC];
        [self.view addSubview:listenVC.view];
        currentvc = listenVC;
    }else{
        [self addChildViewController:VoiceWageVC];
        [self.view addSubview:VoiceWageVC.view];
        currentvc = VoiceWageVC;
    }
    
    //右侧导航栏按钮
    UIButton *rightbutton = [UIButton rightbuttonwithimageName:@"mlgj-2x32s" target:self action:@selector(lookUpDidClicked)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    if (_isAnBao) {
        self.navigationItem.rightBarButtonItem = nil;
    }


}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

-(void)displayRedWage
{
    segmentView.redButton.hidden = NO;
}
-(void)HiddenRedWage
{
    segmentView.redButton.hidden = YES;
}
-(void)lookUpDidClicked
{
   
}
- (void)SunSegmentClick:(NSInteger)index
{
    //判断 点击 按钮 完成切换
    if( (currentvc == VoiceWageVC || currentvc == listenVC) && index == 0){
        return;
    }
    if ((currentvc == wageVC || currentvc == mlwageVC)&& index == 1)
    {
        return;
        
    }
    switch (index) {
        case 0:{
            if (_isAnBao) {
                [self replaceController:currentvc newController:listenVC];

            }else{
                [self replaceController:currentvc newController:VoiceWageVC];
            }
        }
            break;
        case 1:{
            
            if (_isAnBao) {
                [self replaceController:currentvc newController:mlwageVC];
            }else{
                [self replaceController:currentvc newController:wageVC];
            }
        }
            break;
        default:
            break;
    }
    
}
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            currentvc = newController;
            
        }else{
            currentvc = oldController;
            
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
