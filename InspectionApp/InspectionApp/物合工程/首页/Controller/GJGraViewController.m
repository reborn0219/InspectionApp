//
//  GJGraViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/21.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJGraViewController.h"
#import "GJFZAccount.h"
#import "GJHomeButton.h"

//切换小区controller
#import "GJHomeCommuntyViewController.h"
//报失

#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "GJCommunityModel.h"

#import "GJAllWageViewController.h"
#import "PatrolPatrolTaskListVC.h"
#import "PatrolMemberTaskVC.h"
#import "PatrolTaskListVC.h"

#import "PatrolMatterSubmitVC.h"
#import "PtrolMemberTaskListVC.h"
#import "PatrolUrgentTasksVC.h"

#define h (H/4)
#define LocationTimeout 3  //   定位超时时间，可修改，最小2s
#define ReGeocodeTimeout 3 //   逆地理请求超时时间，可修改，最小2s

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


@interface GJGraViewController ()<AVSpeechSynthesizerDelegate,CLLocationManagerDelegate,AMapLocationManagerDelegate>
{
    GJHomeButton *titlebutton;
    //遮盖button
    UIButton *coverButton;
    //登录标识符
    NSString *state;
    NSString *DataStr;
    UIImageView *ListensingleImageview;
    BOOL ISWork;
    NSString *ISWorks;
    NSTimer *WorkTime;
    NSTimer *RefreshTimers;
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
    UILabel *blable;
    NSString *hourTime;
    NSString *secondTime;
    int Second;
    int nowSecond;
    BOOL ISSecondVoice;
    NSString *receivelng;
    NSString *receivelat;
    NSString *moneyStr;
    NSString *orderNum;
    UILabel *orderLable;
    UILabel *orderLablemoney;
    NSString *memberID;
    NSString *WORKTYPE;
    NSTimer *PlaceTimer;
    NSMutableArray *VoiceWageDataArray;
    NSMutableArray *VoiceWageIDArray;
    NSString *VoiceTime;
    NSString *VocieWageID;
    NSTimer *VoiceTimers;
    //    BOOL ISVoiceWage;
    int voicetimes;
    BOOL isplaying;
    NSString *community_id;
    
    
    //
    UILabel *EndPointLable;
    UILabel *EndPhonenumLable;
    UILabel *gongg;
    NSString *EndPointStr;
    NSString *EndPhonenum;
    
    NSString *allot_type;
    NSMutableArray *ad_list;
    UIView *functionView;
    
    GJCommunityModel *WLBmodel;
    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@end

@implementation GJGraViewController
-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarHidden = NO;

    //沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
    GJFZAccount *acction = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!acction){
        GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
        [self presentViewController:loginVC animated:NO completion:nil];
    }else
    {
        [self GetCommunityID];
        
        NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
        GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        community_id = model.community_id;
        NSLog(@"community_id.length**************%ld",(unsigned long)community_id.length);
        if (community_id.length != 0) {
            
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[NSString stringWithFormat:@"%d",Second] forKey:@"workTimesecond"];
    [userdefaults setObject:[NSString stringWithFormat:@"%d",Second/60] forKey:@"workTime"];
    [ListensingleImageview.layer removeAllAnimations];
    [ListensingleImageview removeFromSuperview];
    [ListenLable removeFromSuperview];
    [LISTButton removeFromSuperview];
    [WorkTime invalidate];
    [RefreshTimers invalidate];
    WorkTime = nil;
    [PlaceTimer invalidate];
}
-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    ad_list=[[NSMutableArray alloc]init];
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _scrollView;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friocn_2x06"]];
    imgView.frame = _scrollView.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView insertSubview:imgView atIndex:0];
    self.scrollView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self positionButton];
        [self.scrollView.mj_header endRefreshing];
    }];
    ISWork = YES;
    ISWorks = @"YES";
    VoiceWageDataArray = [NSMutableArray array];
    VoiceWageIDArray = [NSMutableArray array];
    unexedataArrayDataOne = [NSDictionary dictionary];
    ivvDict = [NSDictionary dictionary];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetCommunityID) name:@"getCommunityID" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ChangeCommunityIDName) name:@"ChangeCommunityIDName" object:nil];
    
//      static dispatch_once_t hanwanjie;
//    
//      dispatch_once(&hanwanjie, ^{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getwageDataWorkS) name:@"ShowSingle" object:nil];

    });
//    });
    
    //设置导航栏中间的标题按钮
    titlebutton = [[GJHomeButton alloc]init];
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    NSString *communitName = model.community_name;
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
    leftbutton.backgroundColor = NAVCOlOUR;
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItems =nil ;
    [self GetData];
    [self configLocationManagers];
    [self creatNet];
    [super viewDidLoad];
}

-(void)getwageDataWorkS
{
    NSLog(@"1111111111");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    
    NSString *_id=[userDefaults objectForKey:@"PushMatterID"];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_work_detail" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[_id] andBlock:^(id dictionary)
     {
         
         SLog(@"%@",dictionary);
         
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
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
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }
         else if([state isEqualToString:@"1"])
         {
             
             
             VoiceWageIDArray=[NSMutableArray array];
             VoiceWageDataArray=[NSMutableArray array];
             
             memberID =[userDefaults objectForKey:@"PushMatterID"];
             
             
             [VoiceWageIDArray addObject:memberID];
             NSMutableDictionary *wageVoiceDict = [NSMutableDictionary dictionary];
             [wageVoiceDict setValue:dictionary[@"return_data"] forKey:memberID];
             [VoiceWageDataArray addObject:wageVoiceDict];
             
             
             
             
             NSLog(@"%@",VoiceWageIDArray);
             NSLog(@"%@",wageVoiceDict);
             
#pragma mark - 只收一条
             //             if (isplaying == YES) {
             //                 return ;
             //             }else
             //             {
             [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
             [workOrderListView removeFromSuperview];
             [backGroundButton removeFromSuperview];
             [self VoiceWageArray];
             //             }
             
             
      

         }
     }];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShowSingle" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getwageDataWorkS) name:@"ShowSingle" object:nil];
}


-(void)creatNet
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    NSString *property_ids =model.property_id;
    NSString *communitID = model.community_id;
    NSLog(@"%@",dict);
    
    if (property_ids != nil && communitID != nil) {
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"home" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[property_ids,communitID] andBlock:^(id dictionary)
         {
             NSLog(@"获取广告图%@",dictionary);
             NSLog(@"%@",dictionary[@"return_data"]);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                     [self presentViewController:LoginViewController animated:YES completion:nil];
                 });
             }else if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
             }
             
             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }else if ([state isEqualToString:@"1"])
             {
#pragma mark - 启动页之后的广告
                 NSArray *arr=[NSArray arrayWithArray:dictionary[@"return_data"][@"boot_adv"]];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"adv"];
                 
                 for (int i=0; i<arr.count; i++) {
                     NSString *img_url=[NSString stringWithFormat:@"%@",arr[i][@"img_url"]];
                     
                     NSArray *stringArr = [img_url componentsSeparatedByString:@"/"];
                     NSString *imageName = stringArr.lastObject;
                     
                     // 拼接沙盒路径
                     NSString *filePath = [self getFilePathWithImageName:imageName];
                     NSLog(@"%@",filePath);
//                     [self removeALL];
                     
                     [self downloadAdImageWithUrl:img_url imageName:imageName];
                     
                     
                 }

                 
                 
                 
                 NSArray *arr1=dictionary[@"return_data"][@"ad_list"];
                 for (NSDictionary *dic in arr1) {
                     [ad_list addObject:dic[@"img_url"]];
                 }
                 [self createdUI];
                 
                 //             complaintStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"complaint_nums"]];
                 //             feedBackStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"feedback_nums"]];
                 //             repairStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"repair_nums"]];
                 
                 
             }
         }];
    }else{
        NSLog(@"22");
    }
    
}


//2
-(void)GetData
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    //    NSLog(@"dateString:%@",dateString);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSString *xingqi =[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:[comps weekday] - 1]];
    DataStr = [NSString stringWithFormat:@"%@  %@",dateString,xingqi];
    
}

-(void)createdUI
{
    
    _SMSView=[[GJSMS_Scroll_ImageView alloc]initWithSMS_ImageURLArr:ad_list IntervalTime:2.5 Frame:CGRectMake(0,0, W,W*0.4) PageControl:YES Pagenumber:NO TitleFrame:CGRectMake(0, 0, 0, 0)];
    
    
    
    
    UILabel *DataLable = [[UILabel alloc]initWithFrame:CGRectMake(10, W*0.4+10, 10, 30)];
    DataLable.text = DataStr;
    DataLable.textAlignment = NSTextAlignmentLeft;
    CGFloat datawidth = [UILabel getWidthWithTitle:DataStr font:[UIFont fontWithName:geshi size:20]];
    DataLable.frame = CGRectMake(10, W*0.4+10, datawidth, 30);
    DataLable.font = [UIFont fontWithName:geshi size:17];
    UIButton *positionButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(DataLable.frame) - 10, W*0.4+10, WIDTH/3, 30)];
    positionButton.backgroundColor = [UIColor clearColor];
    [positionButton setTitle:@"刷新位置" forState:UIControlStateNormal];
    [positionButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    positionButton.titleLabel.font = [UIFont fontWithName:geshi size:17];
    [positionButton addTarget:self action:@selector(positionButton) forControlEvents:UIControlEventTouchUpInside];
    
    orderLable = [[UILabel alloc]initWithFrame:CGRectMake(10, W*0.4+40, 20, 30)];
    orderLable.textAlignment = NSTextAlignmentLeft;
    orderLable.numberOfLines = 0;
    if (!orderNum) {
        orderNum = @"0";
    }
    NSString *contentStr = @"今日完成订单,";
    NSString *orderstr = [NSString stringWithFormat:@"%@%@",contentStr,orderNum];
    NSInteger len = [orderNum lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * ontime = [[NSMutableString alloc]initWithString:contentStr];
    [ontime insertString:orderNum atIndex:6];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:ontime];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6, len)];
    orderLable.attributedText = str;
    CGFloat width = [UILabel getWidthWithTitle:orderstr font:[UIFont fontWithName:geshi size:20]];
    orderLable.frame = CGRectMake(10, W*0.4+40, width, 30);
    orderLable.font = [UIFont fontWithName:geshi size:20];
    [self.scrollView addSubview:orderLable];
    if (!moneyStr) {
        moneyStr = @"0";
    }
    NSString *contentStrs = @"赚取了元";
    orderLablemoney = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderLable.frame), CGRectGetMaxY(DataLable.frame), WIDTH/2, 30)];
    orderLablemoney.textAlignment = NSTextAlignmentLeft;
    orderLablemoney.font = [UIFont fontWithName:geshi size:20];
    
    NSInteger lens = [moneyStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * ontimes = [[NSMutableString alloc]initWithString:contentStrs];
    [ontimes insertString:moneyStr atIndex:3];
    NSMutableAttributedString *strs = [[NSMutableAttributedString alloc]initWithString:ontimes];
    [strs addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, lens)];
    orderLablemoney.attributedText = strs;
    
    
    
    
    
    
    
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(orderLablemoney.frame), WIDTH - 10, 20)];
    alable.textColor = gycoloer;
    alable.textAlignment = NSTextAlignmentLeft;
    alable.font = [UIFont fontWithName:geshi size:15];
    alable.text = @"今日还差8单，次日即可领取15.00元额外奖励";
    
    blable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(alable.frame), WIDTH - 10, 20)];
    blable.textColor = gycoloer;
    blable.textAlignment = NSTextAlignmentLeft;
    blable.font = [UIFont fontWithName:geshi size:15];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"workTime___________%@",[userdefaults objectForKey:@"workTime"]);
    if (![userdefaults objectForKey:@"workTime"]) {
        blable.text = @"您已经累计在线0分钟";
        Second = 0;
    }else
    {
        blable.text = [NSString stringWithFormat:@"您已经累计在线%@分钟",[userdefaults objectForKey:@"workTime"]];
        Second = [[userdefaults objectForKey:@"workTime"] intValue];
    }
    
    //    一堆小button
    functionView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(blable.frame)+10,W, w * 4)];
//    functionView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:functionView];
    

  
    [self buttonWithImageName:@"icon_n_112" textlable:@"维修工单" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(0, 0, w - 1, 78) Tag:1];

    [self buttonWithImageName:@"icon_n_112" textlable:@"安保工单" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w,0, w-1, 78) Tag:2];

    [self buttonWithImageName:@"巡检" textlable:@"巡检" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w*2,0, w-1, 78) Tag:3];
    
    [self buttonWithImageName:@"巡查" textlable:@"巡查" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w*3,0, w-1, 78) Tag:4];
    
    [self buttonWithImageName:@"紧急任务" textlable:@"紧急任务" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(0, 79, w-1, 78) Tag:5];

    [self buttonWithImageName:@"在线报事" textlable:@"在线报事" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w, 79, w-1, 78) Tag:6];

    
    
    [self.scrollView addSubview:_SMSView];
    //    [self.scrollView addSubview:RepairButton];
    //    [self.scrollView addSubview:sweepButton];
    [self.scrollView addSubview:blable];
    [self.scrollView addSubview:orderLablemoney];
    [self.scrollView addSubview:DataLable];
    [self.scrollView addSubview:positionButton];
    [self positionButton];
    self.scrollView.contentSize=CGSizeMake(W,SCREEN_HEIGHT<600?600:SCREEN_HEIGHT);

    if (IS_IPAD) {
        self.scrollView.contentSize=CGSizeMake(W, H+100);
    }
}
-(void)ButtonDidClicked:(UIButton *)button
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
                if (resultCode == SucceedCode) {
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
                if (resultCode==SucceedCode) {
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
        
    }else if (button.tag == 6){
        PatrolMatterSubmitVC * pmsVC = [[PatrolMatterSubmitVC alloc]init];
        [self.navigationController pushViewController:pmsVC animated:YES];
    }
    
}


-(UIButton *)buttonWithImageName:(NSString *)imagename textlable:(NSString *)lable target:(id)target action:(SEL)action CGrect:(CGRect)rect Tag:(int)tags;
{
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = tags;
    UIImageView *imageview;
    if (tags==3||tags==4||tags==5||tags==6) {
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((W/4-23)/2,15,23, 23)];
        
    }else{
        imageview = [[UIImageView alloc]initWithFrame:CGRectMake((W/4-34)/2, 10, 34, 34)];
        
    }
    imageview.image = [UIImage imageNamed:imagename];
    UILabel *lables = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, W/4, 30)];
    lables.text = lable;
    lables.textColor = gycoloer;
    lables.font = [UIFont fontWithName:geshi size:14];
    lables.textAlignment = NSTextAlignmentCenter;
    [button addSubview:imageview];
    [button addSubview:lables];
    [button setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [functionView  addSubview:button];
    return button;
}
//推送工单
//-(void)changeVoicetimer
//{
//    voicetimes -= 1;
//    if (voicetimes == 0) {
//        [VoiceTimers invalidate];
//        isplaying = NO;
//        [self VoiceWageArray];
//    }
//}
-(void)CloseButtonDidClicked
{
    [backGroundButton removeFromSuperview];
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [VoiceTimers invalidate];
    [self.audioPlayer stop];
    isplaying = NO;
//    [self VoiceWageArray];
}
#pragma mark - 只能接第一个推送
-(void)VoiceWageArray
{
    if (VoiceWageIDArray.count != 0) {
        //        if (isplaying == NO) {
        //            isplaying = YES;
        [self reloadVoiceWage];
        //        }
    }else
    {
        
        if (ISSecondVoice == YES) {
            
            [self reloadsecondVoiceWage];
            
        }
    }
}

-(void)reloadVoiceWage
{

    unexedataArrayDataOne = [NSDictionary dictionary];
    NSArray *dataArray = [NSArray arrayWithArray:VoiceWageIDArray];
    VocieWageID = dataArray[0];
    for (NSDictionary *Datadict in VoiceWageDataArray) {
        unexedataArrayDataOne = [Datadict objectForKey:VocieWageID];
    }
    ivvDict = [NSDictionary dictionary];
    ivvDict = unexedataArrayDataOne[@"ivv_json"];
    VoiceWageIDArray = [NSMutableArray arrayWithArray:dataArray];
    //    [VoiceWageIDArray removeObjectAtIndex:0];
    [VoiceTimers invalidate];
    [self WorkorderList333];

}
-(void)reloadsecondVoiceWage
{
    VocieWageID = unexedataArrayDataOne[@"repair_id"];
    ivvDict = [NSDictionary dictionary];
    ivvDict = unexedataArrayDataOne[@"ivv_json"];
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [workOrderListView removeFromSuperview];
    [backGroundButton removeFromSuperview];
    [VoiceTimers invalidate];
    ISSecondVoice = NO;
    [self WorkorderList333];
}

-(void)WorkorderList333
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    UIWindow *awindow = [UIApplication sharedApplication].keyWindow;
    
    //黑色背景
    backGroundButton = [[UIButton alloc]initWithFrame:awindow.frame];
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    
    //弹出框
    workOrderListView = [[UIView alloc]initWithFrame:CGRectMake(20, 70, WIDTH - 40, HEIGHT - 100)];
    workOrderListView.backgroundColor = [UIColor whiteColor];
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, workOrderListView.width, workOrderListView.width/4)];
    workOrderListView.layer.cornerRadius = 15;
    workOrderListView.clipsToBounds = YES;
    
    
    //实时图片
    headImageView.image = [UIImage imageNamed:@"friocn_2x10"];
    headImageView.userInteractionEnabled = YES;
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(workOrderListView.width - 40, 0, 40, 40)];
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
    
    
    //地址图片
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
    
    UILabel *EndPhonenumLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPointLable.frame) + 5, workOrderListView.width - 50, 30)];
    EndPhonenumLable.textAlignment = NSTextAlignmentLeft;
    EndPhonenumLable.font = [UIFont fontWithName:geshi size:17];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",unexedataArrayDataOne[@"contact"]];
    NSString *EndPhonenum = [NSString stringWithFormat:@"电话 : %@",phoneNumber];
    EndPhonenumLable.text = EndPhonenum;
    NSString *repair_time;
    NSLog(@"unexedataArrayDataOne___%@",unexedataArrayDataOne);
    if ([unexedataArrayDataOne[@"serving_time"] isEqualToString:@""]) {
        repair_time = @"尽快";
    }else{
        repair_time = unexedataArrayDataOne[@"serving_time"];
    }
    UILabel *orderLables = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPhonenumLable.frame), workOrderListView.width - 40, 20)];
    orderLables.textAlignment = NSTextAlignmentLeft;
    orderLables.font = [UIFont fontWithName:geshi size:17];
    orderLables.text = [NSString stringWithFormat:@"预约时间 : %@",repair_time];
    orderLables.numberOfLines = 0;
    UIFont * ofont = [UIFont systemFontOfSize:17];
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize osize = CGSizeMake(workOrderListView.width - 40,MAXFLOAT);
    //    获取当前文本的属性
    NSDictionary * odic = [NSDictionary dictionaryWithObjectsAndKeys:ofont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  octualsize =[orderLables.text boundingRectWithSize:osize options:NSStringDrawingUsesLineFragmentOrigin  attributes:odic context:nil].size;
    //   更新UILabel的frame
    orderLables.frame = CGRectMake(10, CGRectGetMaxY(EndPhonenumLable.frame) + 5, workOrderListView.width - 40, octualsize.height);
    UILabel *ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(10 ,CGRectGetMaxY(orderLables.frame) + 10, workOrderListView.width - 20 , 20)];
    ContentLable.font = [UIFont fontWithName:geshi size:17];
    ContentLable.textAlignment = NSTextAlignmentLeft;
    
    
    //接单按钮
    UIButton *OrdersButtons = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWigth/2-50, CGRectGetMaxY(ContentLable.frame) + 30, 100, 100)];
    [OrdersButtons setBackgroundImage:[UIImage imageNamed:@"getOrderButton_100x100_@2x"] forState:UIControlStateNormal];
    [OrdersButtons addTarget:self action:@selector(OrdersButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *OrdersImageView = [[UIImageView alloc]initWithFrame:CGRectMake(OrdersButtons.width/2 - 13, 20, 26, 30)];
    OrdersImageView.image = [UIImage imageNamed:@"friocn_2x12"];
    UILabel *OrdersLable = [[UILabel alloc]initWithFrame:CGRectMake(OrdersButtons.width/2 - 30, 60, 60, 20)];
    OrdersLable.textColor = [UIColor whiteColor];
    OrdersLable.textAlignment = NSTextAlignmentCenter;
    
    if ([allot_type isEqualToString:@"RND"]) {
        OrdersLable.text=@"抢单";
    }else{
        OrdersLable.text = @"接单";
    }

    OrdersLable.font = [UIFont fontWithName:geshi size:17];
    [OrdersButtons addSubview:OrdersLable];
    [OrdersButtons addSubview:OrdersImageView];
    _scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(OrdersButtons.frame)+20);
    // [workOrderListView addSubview:OrdersButtons];
    [workOrderListView addSubview:StartPointImageView];
    
    
    //重新设置frame
    workOrderListView.height = KScreenHeight - 250;
    [backGroundButton addSubview:OrdersButtons];
    [OrdersButtons setFrame:CGRectMake(OrdersButtons.frame.origin.x,workOrderListView.frame.origin.y+workOrderListView.frame.size.height + 20,OrdersButtons.frame.size.width,OrdersButtons.frame.size.height)];

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
        strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
    }else if (voiceArray.count != 0)
    {
        wageType = @"工单内容";
        ivvStr = @"语音工单";
        NSString *voiceStr;
        for (NSDictionary *voice in ivvDict[@"voice"]) {
            voiceStr = voice[@"voice"];
        }
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//        NSString *voiceurl = [userdefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@",voiceStr];
        strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@，%@,预约时间,%@,工单内容",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time];
    }else if (imageArray.count != 0)
    {
        wageType = @"工单类型";
        
        ivvStr = @"图片工单";
        strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
    }else
    {
        wageType = @"工单内容";
        ivvStr = @"文字工单";
        strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,unexedataArrayDataOne[@"description"]];
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
    ContentLable.frame = CGRectMake(10, CGRectGetMaxY(orderLables.frame) + 10, workOrderListView.width - 40, conctualsize.height);
    [workOrderListView addSubview:EndPhonenumLable];
    [workOrderListView addSubview:ContentLable];
    [workOrderListView addSubview:StartPointLable];
    [workOrderListView addSubview:EndPointLable];
    [workOrderListView addSubview:orderLables];
    [workOrderListView addSubview:headImageView];
    [workOrderListView addSubview:closeButton];
    [backGroundButton addSubview:workOrderListView];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [awindow addSubview:backGroundButton];
        av = [[AVSpeechSynthesizer alloc]init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:strssss]; //需要转换的文本
        av.delegate = self;
        [av speakUtterance:utterance];
    });
    
    
    
}





-(void)GetCommunityID
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    NSString *communitName= model.community_name;
    WLBmodel=model;
    
    if (communitName != nil)
    {
        [self ChangeCommunityIDName];
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
    // NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
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
-(void)titleDidClicked:(UIButton *)sender
{
    GJHomeCommuntyViewController *HomeCoVC = [[GJHomeCommuntyViewController alloc]init];
    [self.navigationController pushViewController:HomeCoVC animated:YES];
}
-(void)GraButtonDidClicked:(UIButton *)sender
{
    if(sender.tag == 21){
       
    }else{
      
    }
}

//在线时间
-(void)BeganTimelevelTimer:(NSTimer *)timer_
{
    NSLog(@"Second____________*************%d",Second);
    Second += 1;
    NSString *secondstr = [NSString stringWithFormat:@"%d",Second/60];
    blable.text = [NSString stringWithFormat:@"您已经累计在线%@分钟",secondstr];
}
//获取当前时间
-(NSString *)getNowTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}


-(void)Changestate
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"change_state" andBodyOfRequestForKeyArr:@[@"state"] andValueArr:@[WORKTYPE] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary[@"return_data"]);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                 [self presentViewController:LoginViewController animated:YES completion:nil];
             });
         }else if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
         }
         
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }else if ([state isEqualToString:@"1"])
         {
             
         }
     }];
}

//3
- (void)configLocationManagers
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setLocationTimeout:LocationTimeout];
    [self.locationManager setReGeocodeTimeout:ReGeocodeTimeout];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
}
//刷新位置
-(void)positionButton
{
    [GJSVProgressHUD show];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
//            [GJSVProgressHUD showErrorWithStatus:@"刷新失败"];
            //朱滴20181016上架
            [GJSVProgressHUD showInfoWithStatus:@"已刷新"];
            //                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (regeocode)
        {
            receivelng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            receivelat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            [self GETPositionData];
            [GJSVProgressHUD showSuccessWithStatus:@"刷新成功"];
        }
    }];
    
}

-(void)GETPositionData
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"refresh_position" andBodyOfRequestForKeyArr:@[@"subd[lat]",@"subd[lng]"] andValueArr:@[receivelat,receivelng] andBlock:^(id dictionary)
     {
         NSLog(@"dictionary____%@",dictionary);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }
         else if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
         }
         
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             
         }
         else if([state isEqualToString:@"1"])
         {
             [orderLable removeFromSuperview];
             [orderLablemoney removeFromSuperview];
             if (dictionary[@"return_data"][@"total_cost"] == NULL) {
                 orderNum = @"0";
             }else
             {
                 orderNum = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"total_cost"]];
             }
             if (!dictionary[@"return_data"][@"total_nums"]) {
                 moneyStr = @"0";
             }else
             {
                 moneyStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"total_nums"]];
             }
             orderLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 20, 30)];
             orderLable.textAlignment = NSTextAlignmentLeft;
             orderLable.numberOfLines = 0;
             NSString *contentStr = @"今日完成订单,";
             NSString *orderstr = [NSString stringWithFormat:@"%@%@",contentStr,orderNum];
             NSInteger len = [orderNum lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
             NSMutableString * ontime = [[NSMutableString alloc]initWithString:contentStr];
             [ontime insertString:orderNum atIndex:6];
             NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:ontime];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6, len)];
             orderLable.attributedText = str;
             CGFloat width = [UILabel getWidthWithTitle:orderstr font:[UIFont fontWithName:geshi size:20]];
             orderLable.frame = CGRectMake(10, W*0.4+40, width, 30);
             orderLable.font = [UIFont fontWithName:geshi size:20];
             [self.scrollView addSubview:orderLable];
             
             NSString *contentStrs = @"赚取了元";
             orderLablemoney = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderLable.frame), W*0.4+40, WIDTH/2, 30)];
             orderLablemoney.textAlignment = NSTextAlignmentLeft;
             orderLablemoney.font = [UIFont fontWithName:geshi size:20];
             
             NSInteger lens = [moneyStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
             NSMutableString * ontimes = [[NSMutableString alloc]initWithString:contentStrs];
             [ontimes insertString:moneyStr atIndex:3];
             NSMutableAttributedString *strs = [[NSMutableAttributedString alloc]initWithString:ontimes];
             [strs addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, lens)];
             orderLablemoney.attributedText = strs;
             [self.scrollView addSubview:orderLable];
             [self.scrollView addSubview:orderLablemoney];
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)OrdersButtonDidClicked
{
    if ([allot_type isEqualToString:@"RND"]) {
#pragma mark - 走抢单接口
        
        //        OrdersLable.text=@"抢单";
        NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
        GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
        
        if ([model.property_id isEqualToString:@""]) {
            //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
            //return;
        }
        
        // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *property_ids = model.property_id;
        
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"grab" andBodyOfRequestForKeyArr:@[@"repair_id",@"property_id"] andValueArr:@[memberID,property_ids] andBlock:^(id dictionary)
         {
             
             NSLog(@"%@",property_ids);
             NSLog(@"%@",memberID);
             NSLog(@"%@",dictionary);
             
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
             } else if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
             }

             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }
             else if([state isEqualToString:@"1"])
             {
                 
                 [GJSVProgressHUD showWithStatus:dictionary[@"return_data"]];
                 
                 double delayInSeconds = 1.0;
                 //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
                 dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                 //推迟两纳秒执行
                 dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                 dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
                     [self yanzheng:memberID];
                     
                 });
                 
                 //                 再走个接口实现这三个
                 //                 [GJSVProgressHUD showSuccessWithStatus:@"抢单成功"];
                 //                 [backGroundButton removeFromSuperview];
                 //                 [self getVoicewageDataWork];
             }
         }];
        
        
        
    }else{
        
        
        
        
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"receive" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[memberID] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
             } else if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
             }

             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }
             else if([state isEqualToString:@"1"])
             {
                 [GJSVProgressHUD showSuccessWithStatus:@"接单成功"];
                 [backGroundButton removeFromSuperview];
                 
                 
                 
             }
         }];
        
    }
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
    
}
-(void)yanzheng:(NSString *)str
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"confirm_grab" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[str] andBlock:^(id dictionary)
     {
         
         
         
         
         
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [GJSVProgressHUD dismiss];
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         } else if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
         }

         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }
         else if([state isEqualToString:@"1"])
         {
             
             
             
             
             //                 再走个接口实现这三个
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             [backGroundButton removeFromSuperview];
             
         }
     }];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    RefreshTimers=nil;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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
-(void)removeALL{
    NSString *extension = @"";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    
}
//   获取路径
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

//下载
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}


@end
