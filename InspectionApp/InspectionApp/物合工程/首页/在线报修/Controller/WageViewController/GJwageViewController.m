//
//  GJwageViewController.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJwageViewController.h"
#import "GJNavigationController.h"
#import "GJSliderViewController.h"
#import "GJUnexecutedViewController.h"
#import "GJExecutedViewController.h"
#import "GJWholeViewController.h"
#import "GJLoginViewController.h"
#import "GJFishedViewController.h"
#import "GJCancelViewController.h"
#import "GJUnexeChildViewController.h"
#import "GJExecutedChildViewController.h"
#import "GJOverChildViewController.h"
#import "GJFishChildViewController.h"
#import "GJCancelChildViewController.h"
#import "GJUnexeChildViewController.h"
#import "GJExecutedFishViewController.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "JPUSHService.h"

#import "GJQMViewController.h"
#define Width (self.tableView.bounds.size.width)
#define FZcovertag 100
#define FZLeftMenuW 150
#define FZLeftMenuH 500
#define FZLeftMenuY 60
#define bouns self.view.width
@interface GJwageViewController ()<FJSlidingControllerDelegate,FJSlidingControllerDataSource,UnexeCutedViewDelegate,exeCutedViewDelegate,WholeCutedViewDelegate,FishedWageDelegates,cancelWageDelegates,UNexeChildVCDelegates,exeChildVCDelegates,OverChildVCDelegates,CancelChildVCDelegates,FishChildViewDelegates,EXEFishChildVCDelegates>
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *controllers;
@end

@implementation GJwageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCommunityID) name:@"changeCommunityID" object:nil];
    [self addchildVC];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
-(void)createdUItabBar
{
    //导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:geshi size:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"工单";
    self.navigationItem.titleView = titleLabel;
    self.view.backgroundColor = [UIColor whiteColor];
    //左侧导航栏按钮
    UIImageView *leftbutton = [[UIImageView alloc]init];
    leftbutton.backgroundColor =NAVCOlOUR;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)menuDidClicked:(UIButton *)sender
{
    [[GJSliderViewController sharedSliderController]showLeftViewController];
}

#pragma mark dataSouce
- (NSInteger)numberOfPageInFJSlidingController:(GJFJSlidingController *)fjSlidingController{
    return self.titles.count;
}
- (UIViewController *)fjSlidingController:(GJFJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index{
    return self.controllers[index];
}
- (NSString *)fjSlidingController:(GJFJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index{
    return self.titles[index];
}
#pragma mark delegate
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedIndex:(NSInteger)index{
    // presentIndex
    self.title = [self.titles objectAtIndex:index];
}
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedController:(UIViewController *)controller{
    // presentController
}
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedTitle:(NSString *)title{
    // presentTitle
}
-(void)dealloc{
    NSLog(@"!dealloc!");
}
//获取前一个界面的传值
#pragma mark - childVCdelegates
//待处理工单
-(void)UnexeCellDidClicked:(NSDictionary *)dict Islocation:(NSString *)location
{
    GJUnexeChildViewController *UnexeChildVC = [[GJUnexeChildViewController alloc]init];
    UnexeChildVC.unexeDelegates = self;
    UnexeChildVC.receiveDataDic = [NSDictionary dictionary];
    UnexeChildVC.receiveDataDic = dict;
    UnexeChildVC.ISLOCATION = location;
    UnexeChildVC.STYLE=@"2";
    [self.navigationController pushViewController:UnexeChildVC animated:YES];
}

-(void)WholeCellDidClicked:(NSDictionary *)dict Islocation:(NSString *)location
{
    GJUnexeChildViewController *UnexeChildVC = [[GJUnexeChildViewController alloc]init];
    UnexeChildVC.unexeDelegates = self;
    UnexeChildVC.receiveDataDic = [NSDictionary dictionary];
    UnexeChildVC.receiveDataDic = dict;
    UnexeChildVC.ISLOCATION = location;
    [self.navigationController pushViewController:UnexeChildVC animated:YES];
}

-(void)WholeCellDidClicked:(NSDictionary *)dict wageType:(NSString *)wageTypeStr
{
    NSLog(@"wageTypeStr________%@",wageTypeStr);
    if ([wageTypeStr isEqualToString:@"待验收"] || [wageTypeStr isEqualToString:@"已分配"] || [wageTypeStr isEqualToString:@"已接单"] || [wageTypeStr isEqualToString:@"处理中"] || [wageTypeStr isEqualToString:@"维修中"] ||[wageTypeStr isEqualToString:@"待评价"] ||[wageTypeStr isEqualToString:@"待付款"]) {
        GJExecutedChildViewController *executedchildVC = [[GJExecutedChildViewController alloc]init];
        executedchildVC.exeDelegates = self;
        executedchildVC.receiveDataDic = [NSDictionary dictionary];
        executedchildVC.receiveDataDic = dict;
        [self.navigationController pushViewController:executedchildVC animated:YES];
    }else if ([wageTypeStr isEqualToString:@"已完成"] ||[wageTypeStr isEqualToString:@"已评价"] ||[wageTypeStr isEqualToString:@"已处理"])
    {
        GJFishChildViewController *fishChildVC = [[GJFishChildViewController alloc]init];
        fishChildVC.FishChildDelegates = self;
        fishChildVC.receiveDataDic = [NSDictionary dictionary];
        fishChildVC.receiveDataDic = dict;
        [self.navigationController pushViewController:fishChildVC animated:YES];
    }else if ([wageTypeStr isEqualToString:@"已取消"] || [wageTypeStr isEqualToString:@"已无效"])
    {
        GJCancelChildViewController *canceChildlVC = [[GJCancelChildViewController alloc]init];
        canceChildlVC.CancelDelegates = self;
        canceChildlVC.receiveDataDic = [NSDictionary dictionary];
        canceChildlVC.receiveDataDic = dict;
        [self.navigationController pushViewController:canceChildlVC animated:YES];
    }else
    {
        GJUnexeChildViewController *UnexeChildVC = [[GJUnexeChildViewController alloc]init];
        UnexeChildVC.unexeDelegates = self;
        UnexeChildVC.receiveDataDic = [NSDictionary dictionary];
        UnexeChildVC.receiveDataDic = dict;
        UnexeChildVC.STYLE=@"1";
        [self.navigationController pushViewController:UnexeChildVC animated:YES];
    }
}
//待验收工单
-(void)ExeCutedDidClicked:(NSDictionary *)dicts
{
    GJExecutedChildViewController *executedchildVC = [[GJExecutedChildViewController alloc]init];
    executedchildVC.exeDelegates = self;
    executedchildVC.receiveDataDic = [NSDictionary dictionary];
    executedchildVC.receiveDataDic = dicts;
    [self.navigationController pushViewController:executedchildVC animated:YES];
}
//完成工单
-(void)FishWageDidClicked:(NSDictionary *)FishDict
{
    GJFishChildViewController *fishChildVC = [[GJFishChildViewController alloc]init];
    fishChildVC.FishChildDelegates = self;
    fishChildVC.receiveDataDic = [NSDictionary dictionary];
    fishChildVC.receiveDataDic = FishDict;
    [self.navigationController pushViewController:fishChildVC animated:YES];

}
//取消工单
-(void)cancelWageDidClicked:(NSDictionary *)CancelDict
{
    GJCancelChildViewController *canceChildlVC = [[GJCancelChildViewController alloc]init];
    canceChildlVC.CancelDelegates = self;
    canceChildlVC.receiveDataDic = [NSDictionary dictionary];
    canceChildlVC.receiveDataDic = CancelDict;
    [self.navigationController pushViewController:canceChildlVC animated:YES];
}

//推登录界面
-(void)PushLoginVCDidClicked
{
    GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
    [self presentViewController:LoginViewController animated:YES completion:nil];
}
-(void)QianMing:(NSString *)repair_id
{
    NSLog(@"签名");
    GJQMViewController *qm=[[GJQMViewController alloc]init];
    qm.isAnbao = YES;
    qm.repair_id=repair_id;
    [self.navigationController pushViewController:qm animated:YES];
    
}

//视频播放器
-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;
{
    NSLog(@"PlayvideoStr___%@",PlayvideoStr);
    GJZXVideo *video = [[GJZXVideo alloc] init];
    video.playUrl = PlayvideoStr;
    //video.title = @"Rollin'Wild 圆滚滚的";
    GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
    vc.video = video;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//标记完工
-(void)PushFishWageClicked:(NSString *)repairdIDs
{
    GJExecutedFishViewController *execuFishVC = [[GJExecutedFishViewController alloc]init];
    execuFishVC.exefishChildDelegates = self;
    execuFishVC.repairdIDStr = repairdIDs;
    [self.navigationController pushViewController:execuFishVC animated:YES];
}
//浏览图片
-(void)pushImagebrowserDidClicked:(NSMutableArray *)mutableArray imageTag:(int)imagetag
{
    GJMHPhotoBrowserController *vc = [GJMHPhotoBrowserController new];
    vc.currentImgIndex = imagetag;
    vc.displayTopPage = YES;
    vc.displayDeleteBtn = NO;
    vc.imgArray = mutableArray;
    [self presentViewController:vc animated:NO completion:nil];
}
-(void)changeCommunityID
{
    [self addchildVC];
}
-(void)addchildVC
{
    self.datasouce = self;
    self.delegate = self;

    
    //全部
    GJWholeViewController *WholeVC = [[GJWholeViewController alloc]init];
    WholeVC.parentController = self;
    WholeVC.Wholedelegate = self;
    //待处理
    GJUnexecutedViewController *UnexeVC = [[GJUnexecutedViewController alloc]init];
    UnexeVC.parentController = self;
    UnexeVC.Unexedelegate = self;
    //处理中
    GJExecutedViewController *ExecutVC = [[GJExecutedViewController alloc]init];
    ExecutVC.parentController = self;
    ExecutVC.exeDelegates = self;
    //已处理
    GJFishedViewController *fishVC = [[GJFishedViewController alloc]init];
    fishVC.parentController = self;
    fishVC.fishDelegates = self;
    //已完成
    GJCancelViewController *canlVC = [[GJCancelViewController alloc]init];
    canlVC.parentController = self;
    canlVC.cancelDelegates = self;
    
    self.controllers = @[WholeVC,UnexeVC,ExecutVC,fishVC,canlVC];
    self.titles = @[@"未处理",@"待处理",@"处理中",@"已处理",@"已完成"];
    [self addChildViewController:WholeVC];
    [self addChildViewController:UnexeVC];
    [self addChildViewController:ExecutVC];
    [self addChildViewController:fishVC];
    [self addChildViewController:canlVC];
    self.title = self.titles[0];
    [self reloadData];
    
    
    
    
}


@end
