//
//  GJhomeViewController.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJhomeViewController.h"
#import "GJhomeView.h"
#import "GJNavigationController.h"
#import "GJSliderViewController.h"
#import "GJLoginViewController.h"
#import "GJSliderViewController.h"
#import "GJFZAccount.h"
#import "GJHomeButton.h"
#import "GJHomeCommuntyViewController.h"
#import "GJrunLabel.h"
#import "GJMViewController.h"
#import "GJRunLablenewsViewController.h"
#import "GJCommunityModel.h"
#import "GJWYScrollView.h"
#import "GJAllWageViewController.h"
#import "PatrolPatrolTaskListVC.h"
#import "PatrolTaskListVC.h"
#import "PatrolMatterSubmitVC.h"
#import "PatrolMemberTaskVC.h"
#import "PtrolMemberTaskListVC.h"
#import "PatrolUrgentTasksVC.h"

#import "GJSMS_Scroll_ImageView.h"
#define FZcovertag 100
#define FZLeftMenuW 150
#define FZLeftMenuH 500
#define FZLeftMenuY 60

@protocol changeHilightsDelegate <NSObject>

-(void)changeHilights:(UIButton *)sender;

@end


@interface GJhomeViewController ()<HomeButtonDelegate,AVSpeechSynthesizerDelegate,workNameIDDelegates,UITextViewDelegate,UITextFieldDelegate,WYScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    GJHomeButton *titlebutton;
    //遮盖button
    UIButton *coverButton;
    //登录标识符
    NSString *state;
    NSString *DataStr;
    UIImageView *ListensingleImageview;
    BOOL Isleft;
    UILabel *ListenLable;
    UIButton *backGroundButton;
    AVSpeechSynthesizer *av;
    UIButton *LISTButton;
    UIButton *RepairButton;
    NSDictionary *ivvDict;
    NSString *ivvStr;
    NSString *VoiceUrl;
    NSDictionary *unexedataArrayDataOne;
    UIView *workOrderListView;
    NSString *RunLableStr;
    NSMutableArray *VoiceWageDataArray;
    NSMutableArray *VoiceWageIDArray;
    NSString *VoiceTime;
    NSString *VocieWageID;
    NSTimer *VoiceTimers;
    BOOL ISVoiceWage;
    int voicetimes;
    BOOL isplaying;
    UIView *apportionView;
    UITextView *opinionView;
    UITextField *placeLables;
    NSString *theworkID;
    NSMutableArray *workIdarray;
    NSString *memberID;
    NSMutableArray *listARR;
    GJrunLabel* label;
    GJCommunityModel *WLBmodel;
    NSMutableArray *workNameArray;

    NSInteger Srow;

}
@property(nonatomic,strong)GJhomeView *homeview;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,assign)id<changeHilightsDelegate>delegates;

@property(nonatomic,strong)UITableView *GRtableview;

@end

@implementation GJhomeViewController

-(void)viewWillAppear:(BOOL)animated
{

    [UIApplication sharedApplication].statusBarHidden = NO;

    [label runlabel];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    listARR=[[NSMutableArray alloc]init];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
    GJFZAccount *acction = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!acction){
        GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
        [self presentViewController:loginVC animated:NO completion:nil];
    }else
    {
        [self GetCommunityID];
        [self getRunlableDatas];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ChangeCommunityIDName) name:@"ChangeCommunityIDName" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAdminHomewageDatas) name:@"ShowAdminSingle" object:nil];
    self.homeview = [[GJhomeView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height)];
    self.view = self.homeview;
    self.homeview.viewController = self;
    //设置导航栏中间的标题按钮
    titlebutton = [[GJHomeButton alloc]init];


    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    // NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *communitName = model.community_name;
    WLBmodel=model;
    VoiceWageDataArray = [NSMutableArray array];
    VoiceWageIDArray = [NSMutableArray array];
    [titlebutton setTitle:communitName forState:UIControlStateNormal];
    //设置图标
    [titlebutton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    titlebutton.titleLabel.font = [UIFont fontWithName:geshi size:18];
    [titlebutton addTarget:self action:@selector(titleDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    //设置尺寸
    titlebutton.width = 150;
    titlebutton.height = 35;
    self.navigationItem.titleView = titlebutton;
    self.tabBarController.tabBar.translucent = NO;
    //导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
    //左侧导航栏按钮
    UIImageView *leftbutton = [[UIImageView alloc]init];
    leftbutton.backgroundColor =NAVCOlOUR;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItems = nil;
    self.homeview.delegates = self;




    //右侧导航栏按钮
    UIButton *rightbutton = [UIButton rightbuttonwithimageName:@"xc_2x03" target:self action:@selector(sweep)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;



}


-(void)getRunlableDatas
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        // return;
    }


    NSString *property_ids = model.property_id;
    NSString *communitID = model.community_id;
    if (property_ids==nil) {

    }else{
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"home" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[property_ids,communitID] andBlock:^(id dictionary)
         {
             NSLog(@"获取广告图%@",dictionary);
             NSLog(@"dictionary___%@",dictionary);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
             }else      if ([state isEqualToString:@"5"]) {
//                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {

                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];

                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];

             }


             else if([state isEqualToString:@"0"])
             {
             }else if ([state isEqualToString:@"-1"])
             {
             }
             else if([state isEqualToString:@"1"])
             {
                 NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                 RunLableStr = dictionary[@"return_data"][@"notice"][@"msg_name"];

                 [userdefault setObject:dictionary[@"return_data"] forKey:@"RunLableData"];
                 [userdefault synchronize];
                 NSArray *arr=dictionary[@"return_data"][@"ad_list"];
                 for (int i=0; i<arr.count; i++) {
                     NSDictionary *dic=arr[i];
                     [listARR addObject:dic[@"img_url"]];
                 }

                 [self noticeUI];
                 [self noticeSCR];
             }
         }];
    }
}

#pragma mark - 创建滚动试图
-(void)noticeSCR
{
    NSArray *arr2 =[NSArray arrayWithArray:listARR];
    ////    @[[UIImage imageNamed:@"111-新"],[UIImage imageNamed:@"444-新"],[UIImage imageNamed:@"banner-金砖640"]];
    //    /**
    //     *  通过代码创建
    //     */
    //    self.homeview.scrollView = [GJWYScrollView scrollViewWithImageArray:arr2 describeArray:nil];
    //    //设置frame
    //   self.homeview.scrollView.frame = CGRectMake(0, 0, W, W * 0.4);
    //    //用代理处理图片点击
    //    self.homeview.scrollView.delegate = self;
    //    //设置每张图片的停留时间，默认值为5s，最少为2s
    //    self.homeview.scrollView.time = 3;
    //    //设置分页控件的图片,不设置则为系统默认
    //    [self.homeview.scrollView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    //    //设置分页控件的位置，默认为PositionBottomCenter
    //    self.homeview.scrollView.pagePosition = PositionBottomCenter;
    //    /**
    //     *  修改图片描述控件的外观，不需要修改的传nil
    //     *
    //     *  参数一 字体颜色，默认为白色
    //     *  参数二 字体，默认为13号字体
    //     *  参数三 背景颜色，默认为黑色半透明
    //     */
    //    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //    UIFont *font = [UIFont systemFontOfSize:15];
    //    UIColor *textColor = [UIColor greenColor];
    //    [self.homeview.scrollView setDescribeTextColor:textColor font:font bgColor:bgColor];

    self.homeview.scrollView=[[GJSMS_Scroll_ImageView alloc]initWithSMS_ImageURLArr:listARR IntervalTime:2.5 Frame:CGRectMake(0,0, W,W*0.4) PageControl:YES Pagenumber:NO TitleFrame:CGRectMake(0, 0, 0, 0)];

    [self.homeview.atableview addSubview:self.homeview.scrollView];


}
//跑马灯lable
-(void)noticeUI
{
    self.homeview.RunLableButton = [[UIButton alloc]initWithFrame:CGRectMake(0,WIDTH * 0.4 + 8, WIDTH, 30)];
    [self.homeview.RunLableButton addTarget:self action:@selector(RunLableButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    uplable.backgroundColor = gycoloers;
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 29.5, W, 0.5)];
    downLable.backgroundColor = gycoloers;
    [self.homeview.RunLableButton addSubview:uplable];
    [self.homeview.RunLableButton addSubview:downLable];
    self.homeview.RunLableButton.backgroundColor = [UIColor whiteColor];
    [self.homeview.RunLableButton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    self.homeview.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 26, 26)];
    self.homeview.imageview.image = [UIImage imageNamed:@"icon_n_20@2x"];
    self.homeview.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(33, 0.5, 70, 29)];
    self.homeview.lable1.text = @"小区通知";
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(103, 8, 2, 14)];
    lineLable.backgroundColor = NAVCOlOUR;
    self.homeview.lable1.font = [UIFont fontWithName:geshi size:17];
    self.homeview.lable1.textColor =NAVCOlOUR;
    //滚动lable



    label = [[GJrunLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineLable.frame) + 5, 0.5, W - CGRectGetMaxX(self.homeview.lable1.frame) - 30, 29) andText:RunLableStr];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:gycolor];
    [self.homeview.RunLableButton addSubview:label];
    [self.homeview.RunLableButton addSubview:lineLable];
    [self.homeview.RunLableButton addSubview:self.homeview.imageview];
    [self.homeview.RunLableButton addSubview:self.homeview.lable1];
    [self.homeview.atableview addSubview:self.homeview.RunLableButton];
}

-(void)RunLableButtonDidClicked
{
    GJRunLablenewsViewController *runVC = [[GJRunLablenewsViewController alloc]init];
    [self.navigationController pushViewController:runVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)menuDidClicked{
    [[GJSliderViewController sharedSliderController]showLeftViewController];
}


-(void)HomeButtonClicked:(UIButton *)button
{

    if (button.tag == 1) {
        GJAllWageViewController *messageVC = [[GJAllWageViewController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }else if(button.tag == 2){

   
        GJAllWageViewController *messageVC = [[GJAllWageViewController alloc] init];
        messageVC.isAnBao = YES;
        [self.navigationController pushViewController:messageVC animated:YES];
        
    
    }else if (button.tag == 3){
       
        if ([UserManager iscaptain].integerValue == 1) {
            
            PatrolPatrolTaskListVC * pptlVC = [[PatrolPatrolTaskListVC alloc]init];
            [self.navigationController pushViewController:pptlVC animated:YES];
            
        }else if ([UserManager iscaptain].integerValue == 0){
            PatrolMemberTaskVC * pmtVC = [[PatrolMemberTaskVC alloc]init];
            [self.navigationController pushViewController:pmtVC animated:YES];
        }else{
            MJWeakSelf
            [PatrolHttpRequest checkcaptain:@{} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                NSLog(@"%@",data);
                NSDictionary * dic = data;
                if (resultCode==SucceedCode) {
                    [UserDefaults setObject:dic[@"iscaptain"] forKey:@"iscaptain"];
                    [UserDefaults setObject:dic[@"user_id"] forKey:@"menber_id"];

                }else{
                    [UserDefaults setObject:@"3" forKey:@"iscaptain"];
                }
                if ([UserManager iscaptain].integerValue == 1) {
                    
                    PatrolPatrolTaskListVC * pptlVC = [[PatrolPatrolTaskListVC alloc]init];
                    [weakSelf.navigationController pushViewController:pptlVC animated:YES];

                }else if ([UserManager iscaptain].integerValue == 0){
                    PatrolMemberTaskVC * pmtVC = [[PatrolMemberTaskVC alloc]init];
                    [weakSelf.navigationController pushViewController:pmtVC animated:YES];
                }else{
                    [GJMBProgressHUD showError:data];
                }
                
            }];
        }
  
        
    }else if (button.tag == 4){
        if ([UserManager iscaptain].integerValue == 1) {
            
            PatrolTaskListVC * pptlVC = [[PatrolTaskListVC alloc]init];
            [self.navigationController pushViewController:pptlVC animated:YES];
            
        }else if ([UserManager iscaptain].integerValue == 0){
            PtrolMemberTaskListVC * pmolVC = [[PtrolMemberTaskListVC alloc]init];
            [self.navigationController pushViewController:pmolVC animated:YES];
        }else{
            MJWeakSelf
            [PatrolHttpRequest checkcaptain:@{} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                NSLog(@"%@",data);
                NSDictionary * dic = data;
                if (resultCode == SucceedCode) {
                    [UserDefaults setObject:dic[@"iscaptain"] forKey:@"iscaptain"];
                    [UserDefaults setObject:dic[@"user_id"] forKey:@"menber_id"];

                }else{
                    [UserDefaults setObject:@"3" forKey:@"iscaptain"];
                }
                if ([UserManager iscaptain].integerValue == 1) {
                    
                    PatrolTaskListVC * pptlVC = [[PatrolTaskListVC alloc]init];
                    [weakSelf.navigationController pushViewController:pptlVC animated:YES];
                    
                }else if ([UserManager iscaptain].integerValue == 0){
                    PtrolMemberTaskListVC * pmolVC = [[PtrolMemberTaskListVC alloc]init];
                    [weakSelf.navigationController pushViewController:pmolVC animated:YES];
                }else{
                    [GJMBProgressHUD showError:data];
                }
                
            }];
        }
       
        //巡查
    }else if (button.tag == 5){
        PatrolUrgentTasksVC * putVC = [[PatrolUrgentTasksVC alloc]init];
        [self.navigationController pushViewController:putVC animated:YES];
        
    }else if(button.tag == 6){
        
        PatrolMatterSubmitVC * pmsVC = [[PatrolMatterSubmitVC alloc]init];
        [self.navigationController pushViewController:pmsVC animated:YES];
        
    }else if(button.tag == 20)
    {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){

            [[[UIAlertView alloc] initWithTitle:nil
                                        message:@"app需要访问您的相机。\n请启用相机-设置/隐私/相机"
                                       delegate:nil
                              cancelButtonTitle:@"关闭"
                              otherButtonTitles:nil] show];
            return;
        }else
        {

           
        }
    }
}
//判断网络状况
-(BOOL) connectedToNetwork
{

    return YES;
}


-(void)titleDidClicked:(UIButton *)sender
{
    GJHomeCommuntyViewController *HomeCoVC = [[GJHomeCommuntyViewController alloc]init];
    [self.navigationController pushViewController:HomeCoVC animated:YES];
}
-(UIButton *)buttonWithCGRect:(CGRect)rect titlename:(NSString *)name target:(id)target action:(SEL)action Tag:(NSInteger)tags
{
    UIButton *abutton = [[UIButton alloc]init];
    abutton.frame = rect;
    [abutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    abutton.tag = tags;
    abutton.backgroundColor = [UIColor whiteColor];
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    leftImage.image = [UIImage imageNamed:@"fktx_2x05"];


    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, WIDTH - 80, 20)];
    titleLable.textColor = gycolor;
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.font = [UIFont fontWithName:geshi size:15];
    titleLable.text = name;

    UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 40, 10, 20, 20)];
    rightImage.image = [UIImage imageNamed:@"sssss"];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, WIDTH, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [abutton addSubview:leftImage];
    [abutton addSubview:lineLable];
    [abutton addSubview:titleLable];
    [abutton addSubview:rightImage];
    [coverButton addSubview:abutton];
    return abutton;
}


-(void)GetCommunityID
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];

    //NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *communitID = model.community_id;
    NSString *communitName= model.community_name;
    if (communitName != nil)
    {
        [titlebutton setTitle:communitName forState:UIControlStateNormal];
        //[userdefault setObject:communitID forKey:@"NowcommunitID"];
    }
    else {
        GJHomeCommuntyViewController *HomeCoVC = [[GJHomeCommuntyViewController alloc]init];
        [self.navigationController pushViewController:HomeCoVC animated:YES];
    }
}

-(void)ChangeCommunityIDName
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];

    //NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *communitName = model.community_name;

    titlebutton = [[GJHomeButton alloc]init];
    [titlebutton setTitle:communitName forState:UIControlStateNormal];
    //设置图标
    [titlebutton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    titlebutton.titleLabel.font = [UIFont fontWithName:geshi size:18];
    [titlebutton addTarget:self action:@selector(titleDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    //设置尺寸
    titlebutton.width = 150;
    titlebutton.height = 35;
    self.navigationItem.titleView = titlebutton;
    self.tabBarController.tabBar.translucent = NO;
    [titlebutton setTitle:communitName forState:UIControlStateNormal];
}

-(void)consultationClicked
{
   
}
-(void)pushLoginVC
{
    GJLoginViewController *LoginVC = [[GJLoginViewController alloc]init];
    [self presentViewController:LoginVC animated:YES completion:nil];
}
//推送语音工单
-(void)getAdminHomewageDatas
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];

    NSString *_id=[userDefaults objectForKey:@"PushMatterID"];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_work_detail" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[_id] andBlock:^(id dictionary)
     {
         NSLog(@"-----======-----%@",dictionary);
         NSLog(@"=====------=====%@",_id);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }else      if ([state isEqualToString:@"5"]) {
//             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {

             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];

             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];

         }

         else if([state isEqualToString:@"0"])
         {
         }else if ([state isEqualToString:@"-1"])
         {
         }
         else if([state isEqualToString:@"1"])
         {
             memberID =[userDefaults objectForKey:@"PushMatterID"];


             [VoiceWageIDArray addObject:memberID];
             NSMutableDictionary *wageVoiceDict = [NSMutableDictionary dictionary];
             [wageVoiceDict setValue:dictionary[@"return_data"] forKey:memberID];
             [VoiceWageDataArray addObject:wageVoiceDict];
             [self VoiceWageArray];


         }
     }];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShowAdminSingle" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAdminHomewageDatas) name:@"ShowAdminSingle" object:nil];


}


-(void)HomeWorkorderList
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    UIWindow *awindow = [UIApplication sharedApplication].keyWindow;

    //黑色背景
    backGroundButton = [[UIButton alloc]initWithFrame:awindow.frame];
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];

    //工单View
    workOrderListView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, WIDTH - 40, HEIGHT - 200)];
    workOrderListView.backgroundColor = [UIColor whiteColor];
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, workOrderListView.width, workOrderListView.width/4)];
    workOrderListView.layer.cornerRadius = 10;
    workOrderListView.clipsToBounds = YES;

    //顶部实时图片
    headImageView.image = [UIImage imageNamed:@"friocn_2x10"];
    headImageView.userInteractionEnabled = YES;

    //关闭按钮


    UIButton *closeButton=[[UIButton alloc]init];
    if (IS_IPAD) {
        closeButton.frame = CGRectMake(workOrderListView.width -workOrderListView.width/8 , 0, workOrderListView.width/8, workOrderListView.width/8);

    }else{

        closeButton.frame = CGRectMake(workOrderListView.width - 40, 0, 40, 40);
    }
    [closeButton addTarget:self action:@selector(CloseButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"orderPlayPageCloseButton_40x40_"] forState:UIControlStateNormal];
    UILabel *distanceLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, headImageView.width - 20, 20)];
    distanceLable.textColor = [UIColor whiteColor];
    distanceLable.font = [UIFont fontWithName:geshi size:20];

    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];

    distanceLable.text = model.community_name;
    distanceLable.textAlignment = NSTextAlignmentCenter;

    UILabel * contentLable = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(distanceLable.frame) + 10,workOrderListView.width - 20,20)];
    contentLable.font = [UIFont fontWithName:geshi size:17];
    contentLable.textAlignment = NSTextAlignmentCenter;
    contentLable.textColor = [UIColor whiteColor];
    contentLable.text = unexedataArrayDataOne[@"parent_class"];
    [headImageView addSubview:distanceLable];
    [headImageView addSubview:contentLable];
    UIImageView *StartPointImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(headImageView.frame) + 20, 30, 30)];
    StartPointImageView.image = [UIImage imageNamed:@"friocn_2x15"];
    UILabel *StartPointLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(StartPointImageView.frame) + 5, CGRectGetMaxY(headImageView.frame) + 20, workOrderListView.width - 50, 30)];
    StartPointLable.textAlignment = NSTextAlignmentLeft;
    StartPointLable.font = [UIFont fontWithName:geshi size:17];
    NSString *RoomAddress;
    StartPointLable.text = unexedataArrayDataOne[@"room_info"][@"room_address"];
    if ([unexedataArrayDataOne[@"room_info"][@"room_address"] isEqualToString:@"--"]) {
        StartPointLable.text = [userdefaults objectForKey:@"totalStringAddress"];
        RoomAddress = [[userdefaults objectForKey:@"totalStringAddress"] stringByReplacingOccurrencesOfString:@"-" withString:@"#"];
    }else
    {
        StartPointLable.text = unexedataArrayDataOne[@"room_info"][@"room_address"];
        RoomAddress = [unexedataArrayDataOne[@"room_info"][@"room_address"] stringByReplacingOccurrencesOfString:@"-" withString:@"#"];
    }
    UILabel *EndPointLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(StartPointImageView.frame)+10, workOrderListView.width - 50, 30)];
    EndPointLable.textAlignment = NSTextAlignmentLeft;
    EndPointLable.font = [UIFont fontWithName:geshi size:17];
    NSString *userName;

    userName=unexedataArrayDataOne[@"name"];

    NSString *EndPointStr = [NSString stringWithFormat:@"报修人 : %@ ",userName];
    EndPointLable.text = EndPointStr;


    //报修电话
    UILabel *EndPhonenumLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPointLable.frame) + 5, workOrderListView.width - 50, 30)];
    EndPhonenumLable.textAlignment = NSTextAlignmentLeft;
    EndPhonenumLable.font = [UIFont fontWithName:geshi size:17];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",unexedataArrayDataOne[@"contact"]];
    NSString *EndPhonenum = [NSString stringWithFormat:@"电话 : %@",phoneNumber];
    EndPhonenumLable.text = EndPhonenum;

    if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
        //公共
        EndPointLable.frame =CGRectMake(10, CGRectGetMaxY(StartPointImageView.frame)+10, workOrderListView.width - 50, 30);
        EndPointLable.text=@"公共区域报事";
        EndPhonenumLable.frame = CGRectMake(10, CGRectGetMaxY(EndPointLable.frame) + 5, workOrderListView.width - 50, 0);



    }else{
        //普通

    }




    NSString *repair_time;
    if ([unexedataArrayDataOne[@"repair_time"] isEqualToString:@""]) {
        repair_time = @"尽快";
    }else{
        repair_time = unexedataArrayDataOne[@"repair_time"];
    }


    //预约时间
    UILabel *orderLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPhonenumLable.frame), workOrderListView.width - 40, 20)];
    orderLable.textAlignment = NSTextAlignmentLeft;
    orderLable.font = [UIFont fontWithName:geshi size:17];
    orderLable.text = [NSString stringWithFormat:@"预约时间 : %@",repair_time];
    orderLable.numberOfLines = 0;
    UIFont * ofont = [UIFont systemFontOfSize:17];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize osize = CGSizeMake(workOrderListView.width - 40,MAXFLOAT);
    //    获取当前文本的属性
    NSDictionary * odic = [NSDictionary dictionaryWithObjectsAndKeys:ofont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  octualsize = [orderLable.text boundingRectWithSize:osize options:NSStringDrawingUsesLineFragmentOrigin  attributes:odic context:nil].size;
    //   更新UILabel的frame
    orderLable.frame = CGRectMake(10, CGRectGetMaxY(EndPhonenumLable.frame) + 5, workOrderListView.width - 40, octualsize.height);

    UILabel *ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(10 ,CGRectGetMaxY(orderLable.frame) + 10, workOrderListView.width - 20 , 20)];
    ContentLable.font = [UIFont fontWithName:geshi size:17];
    ContentLable.textAlignment = NSTextAlignmentLeft;



    UIButton *OrdersButtons = [[UIButton alloc]initWithFrame:CGRectMake(workOrderListView.width/2 - 75, CGRectGetMaxY(ContentLable.frame) + 30, 100, 100)];
    [OrdersButtons setBackgroundImage:[UIImage imageNamed:@"getOrderButton_100x100_@2x"] forState:UIControlStateNormal];
    [OrdersButtons addTarget:self action:@selector(OrdersButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [OrdersButtons setTitle:@"分配工单" forState:UIControlStateNormal];
    [OrdersButtons setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    /*[workOrderListView addSubview:OrdersButtons];*/
    [backGroundButton addSubview:OrdersButtons];
    OrdersButtons.centerX = backGroundButton.centerX;


    [workOrderListView addSubview:StartPointImageView];
    NSArray *videoArray = [NSArray array];
    videoArray = ivvDict[@"video"];
    NSArray *voiceArray = [NSArray array];
    voiceArray = ivvDict[@"voice"];
    NSArray *imageArray = [NSArray array];
    imageArray = ivvDict[@"images"];
    NSString *strssss;
    NSString *wageType;
    if (videoArray.count != 0) {
        wageType = @"工单类型";
        ivvStr = @"视频工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];

        }else{
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
        }
    }else if (voiceArray.count != 0)
    {
        wageType = @"工单内容";
        ivvStr = @"语音工单";
        NSString *voiceStr;
        for (NSDictionary *voice in ivvDict[@"voice"]) {
            voiceStr = voice[@"voice"];
            VoiceTime = voice[@"voice_time"];
        }
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSString *voiceurl = [userdefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@",voiceStr];
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];

        }else{

            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@，%@,预约时间,%@,工单内容",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time];
        }
    }else if (imageArray.count != 0)
    {
        wageType = @"工单类型";

        ivvStr = @"图片工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];

        }else{

            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
        }
    }else
    {
        wageType = @"工单内容";
        ivvStr = @"文字工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];

        }else{

            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,unexedataArrayDataOne[@"description"]];
        }
    }
    if ([ivvStr isEqualToString:@"文字工单"]) {
        ContentLable.text = [NSString stringWithFormat:@"%@ : %@",wageType,unexedataArrayDataOne[@"description"]];
    }else
    {
        ContentLable.text = [NSString stringWithFormat:@"%@ : %@",wageType,ivvStr];
    }
    ContentLable.numberOfLines = 0;
    UIFont * confont = [UIFont systemFontOfSize:17];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize consize = CGSizeMake(workOrderListView.width - 40,MAXFLOAT);
    //    获取当前文本的属性
    NSDictionary * condic = [NSDictionary dictionaryWithObjectsAndKeys:confont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  conctualsize =[ContentLable.text boundingRectWithSize:consize options:NSStringDrawingUsesLineFragmentOrigin  attributes:condic context:nil].size;
    //   更新UILabel的frame
    ContentLable.frame = CGRectMake(10, CGRectGetMaxY(orderLable.frame) + 10, workOrderListView.width - 40, conctualsize.height);

#pragma mark - 静音，手工



    [workOrderListView addSubview:EndPhonenumLable];
    [workOrderListView addSubview:ContentLable];
    [workOrderListView addSubview:StartPointLable];
    [workOrderListView addSubview:EndPointLable];
    [workOrderListView addSubview:orderLable];
    [workOrderListView addSubview:headImageView];
    [workOrderListView addSubview:closeButton];
    [backGroundButton addSubview:workOrderListView];
    [awindow addSubview:backGroundButton];
    av = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:strssss]; //需要转换的文本
    av.delegate = self;
    [av speakUtterance:utterance];
}


- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance
{
    if ([ivvStr isEqualToString:@"语音工单"]) {
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
        [self.audioPlayer playURL:[NSURL URLWithString:VoiceUrl]];
        voicetimes = [VoiceTime intValue];
        VoiceTimers = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVoicetimer) userInfo:nil repeats:YES];
    }else
    {
        isplaying = NO;
        [self VoiceWageArray];
    }
}
-(void)changeVoicetimer
{
    voicetimes -= 1;
    if (voicetimes == 0) {
        [VoiceTimers invalidate];
        isplaying = NO;
        [self VoiceWageArray];
    }
}
-(void)CloseButtonDidClicked
{
    [backGroundButton removeFromSuperview];
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [VoiceTimers invalidate];
    [self.audioPlayer stop];
    if (ISVoiceWage == NO) {
        return ;
    }else
    {
        isplaying = NO;
        [self VoiceWageArray];
    }
}

//分派工单

-(void)OrdersButtonDidClicked:(UIButton *)sender
{
    [GJSVProgressHUD showWithStatus:@"请稍后"];
    NSString *property_ids;
    NSString *community_ids;

    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];

    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        // return;
    }


    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    property_ids = model.property_id;
    community_ids = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_who" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"start_num",@"per_pager_nums"] andValueArr:@[property_ids,community_ids,@"0",@"10"] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
         }
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }else if ([state isEqualToString:@"1"])
         {
             workIdarray = [NSMutableArray array];
             workNameArray = [NSMutableArray array];
             for (NSDictionary *dict in dictionary[@"return_data"]) {
                 NSString *userid = dict[@"user_id"];
                 NSString *turename = dict[@"ture_name"];
                 [workIdarray addObject:userid];
                 [workNameArray addObject:turename];
             }
             [userDefaults setObject:workNameArray forKey:@"UNexeworkNameArray"];
             [userDefaults setObject:workIdarray forKey:@"UNexeworkIDArray"];
             [userDefaults synchronize];
             [GJSVProgressHUD dismiss];
             [self WorkYesButtonDidClicked];
         }

     }];
}


-(void)WorkYesButtonDidClicked
{


    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    workIdarray = [userdefaults objectForKey:@"UNexeworkIDArray"];
    coverButton = [[UIButton alloc]init];
    coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [coverButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    coverButton.frame = window.bounds;


    //    20, 50, WIDTH - 40, HEIGHT - 200
    apportionView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, WIDTH-40 , 438)];
    NSLog(@"%f",KScreenHeight-40-90);

    apportionView.layer.masksToBounds = YES;
    //设置元角度
    apportionView.layer.cornerRadius = 6.0;
    //设置边线
    apportionView.backgroundColor =  [UIColor whiteColor];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, apportionView.size.width, 50)];
    titleLable.text = @"分派工单";
    titleLable.font = [UIFont fontWithName:geshi size:19];
    titleLable.textAlignment = NSTextAlignmentCenter;

    UIButton *dismisButton = [[UIButton alloc]initWithFrame:CGRectMake(apportionView.size.width - 40, 10, 30, 30)];
    [dismisButton setBackgroundImage:[UIImage imageNamed:@"dialog_back"] forState:UIControlStateNormal];
    [dismisButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
    [apportionView addSubview:dismisButton];

    UIView *hengL=[[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, WIDTH-40, 0.5)];
    hengL.backgroundColor=NAVCOlOUR;
    [apportionView addSubview:hengL];


    UILabel *firL=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, apportionView.bounds.size.width-15, 45)];
    firL.text=@"请选择分派人员";
    firL.textColor=gycolor;
    firL.font=[UIFont systemFontOfSize:16];
    firL.textAlignment=NSTextAlignmentLeft;
    [apportionView addSubview:firL];

    UIView *hengL2=[[UIView alloc]initWithFrame:CGRectMake(15, 50+45-0.5, apportionView.bounds.size.width-15, 0.5)];
    hengL2.backgroundColor=gycoloer;
    [apportionView addSubview:hengL2];

    _GRtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 95, apportionView.bounds.size.width, 45*3)];


    _GRtableview.delegate=self;
    _GRtableview.dataSource=self;
    [apportionView addSubview:_GRtableview];





    opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 95+45*3+10,apportionView.size.width, 100)];
    opinionView.backgroundColor =FZColor(245, 245, 245);
    opinionView.font = [UIFont fontWithName:geshi size:15];
    opinionView.delegate = self;
    [opinionView.layer setBorderColor:gycoloers.CGColor];

    placeLables = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
    placeLables.enabled = NO;
    placeLables.delegate = self;
    placeLables.placeholder = @"请在此输入备注...";
    placeLables.font =  [UIFont systemFontOfSize:15];
    placeLables.textColor = gycoloer;
    [opinionView addSubview:placeLables];

    _fenpeiyesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 95+45*3+100+30, apportionView.width - 40, 40)];
    [_fenpeiyesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [_fenpeiyesButton setTitle:@"确定" forState:UIControlStateNormal];
    [_fenpeiyesButton addTarget: self action:@selector(YESButtonVoiceWageDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [apportionView addSubview:opinionView];
    [apportionView addSubview:titleLable];
    [apportionView addSubview:_fenpeiyesButton];
    [coverButton addSubview:apportionView];
    [window addSubview:coverButton];


}

//分派确定
-(void)YESButtonVoiceWageDidClicked:(UIButton *)sender
{
    NSString *repairID = unexedataArrayDataOne[@"repair_id"];
    NSString *servingtime = unexedataArrayDataOne[@"serving_time"];
    NSString *property_ids;

    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }


    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }
    else
    {
        [GJSVProgressHUD showWithStatus:@"分派中"];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[appointed_time]",@"rep[remarks]",@"type"] andValueArr:@[property_ids,repairID,theworkID,servingtime,opinionView.text,@"S"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {

             }
             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }else if ([state isEqualToString:@"1"])
             {
                 [GJSVProgressHUD showSuccessWithStatus:@"分派成功"];
                 [backGroundButton removeFromSuperview];
             }
             [coverButton removeFromSuperview];
         }];
    }
}


-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[worknameID]];
}
-(void)Closebutton
{
    [coverButton removeFromSuperview];
}
//分派确定
-(void)YESButtonWageDidClicked:(UIButton *)sender
{

    NSString *repairID = unexedataArrayDataOne[@"repair_id"];
    NSString *servingtime = unexedataArrayDataOne[@"serving_time"];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *property_ids;

    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }

    NSLog(@"workIdarray__________%@",workIdarray);
    NSLog(@"theworkID___________%@",theworkID);
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }
    else
    {
        [GJSVProgressHUD showWithStatus:@"分派中"];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[appointed_time]",@"rep[remarks]",@"type"] andValueArr:@[property_ids,repairID,theworkID,servingtime,opinionView.text,@"S"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {

             }
             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }else if ([state isEqualToString:@"1"])
             {
                 [GJSVProgressHUD showSuccessWithStatus:@"分派成功"];
                 [backGroundButton removeFromSuperview];
                 [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                 [VoiceTimers invalidate];
                 [self.audioPlayer stop];
                 if (ISVoiceWage == NO) {
                 }else
                 {
                     for (int i = 0 ; i < VoiceWageIDArray.count; i++) {
                         if ([VocieWageID isEqualToString:VoiceWageIDArray[i]]) {
                             [VoiceWageIDArray removeObjectAtIndex:i];
                         }
                     }
                     isplaying = NO;
                     [self VoiceWageArray];
                 }
             }
             [coverButton removeFromSuperview];
         }];
    }

    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
}
-(void)VoiceWageArray
{
    if (VoiceWageIDArray.count != 0) {
        //        if (isplaying == NO) {
        //            isplaying = YES;
        unexedataArrayDataOne = [NSDictionary dictionary];
        NSArray *dataArray = [NSArray arrayWithArray:VoiceWageIDArray];
        VocieWageID = dataArray[0];
        NSLog(@"VocieWageID___%@",VocieWageID);
        NSLog(@"VoiceWageDataArray___%@",VoiceWageDataArray);
        for (NSDictionary *Datadict in VoiceWageDataArray) {
            unexedataArrayDataOne = [Datadict objectForKey:VocieWageID];
        }
        NSLog(@"unexedataArrayDataOne___%@",unexedataArrayDataOne);
        ivvDict = [NSDictionary dictionary];
        ivvDict = unexedataArrayDataOne[@"ivv_json"];
        VoiceWageIDArray = [NSMutableArray arrayWithArray:dataArray];
        [VoiceWageIDArray removeObjectAtIndex:0];
        [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        [workOrderListView removeFromSuperview];
        [backGroundButton removeFromSuperview];
        [VoiceTimers invalidate];
        [self HomeWorkorderList];
        //        }
    }else
    {
        ISVoiceWage = NO;
    }
}
-(void)alertToLoginMsg:(NSString *)str withDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9999;
}

- (void) alertToUpMsg:(NSString *) str withDelegate:(id) delegate{//点击升级
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9996;

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==9999)
    {
        GJLoginViewController *log=[[GJLoginViewController alloc] init];
        [self presentViewController:log animated:YES completion:nil];

    }
    if (alertView.tag==9996) {
        if (buttonIndex==0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO]) {

                NSDictionary *dic=[[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
            }

        }
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return workNameArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {

        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
        UIImageView *quanImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
        if (indexPath.row==Srow) {
            [quanImg setImage:[UIImage imageNamed:@"mlgj_a01"]];

        }else{
            [quanImg setImage:[UIImage imageNamed:@"mlgj_n01"]];
        }
        quanImg.tag=998;

        [cell addSubview:quanImg];

        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(15+20+5, 0, WIDTH-15, 40)];
        nameLab.font=[UIFont systemFontOfSize:16];
        nameLab.text=workNameArray[indexPath.row];
        nameLab.textColor=gycolor;
        nameLab.textAlignment=NSTextAlignmentLeft;
        [cell addSubview:nameLab];

    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    for (UIView *vv in cell.subviews) {
        if (vv.tag==998) {
            UIImageView *bb=(UIImageView *)vv;
            [bb setImage:[UIImage imageNamed:@"mlgj_a01"] ];
            Srow=indexPath.row;

            theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];

        }
    }

    [_GRtableview reloadData];
}
@end
