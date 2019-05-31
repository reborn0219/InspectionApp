


//
//  GJUnexecutedViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#define LocationTimeout 3  //   定位超时时间，可修改，最小2s
#define ReGeocodeTimeout 3 //   逆地理请求超时时间，可修改，最小2s

#import "GJVoiceWageViewController.h"
#import "GJToolBarView.h"

#import "Masonry.h"
#import "GJCommunityModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface GJVoiceWageViewController ()<AVSpeechSynthesizerDelegate,UITextFieldDelegate,workNameIDDelegates,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSString *state;
    NSString *DataStr;
    UIImageView *ListensingleImageview;
    BOOL ISWork;
    NSTimer *WorkTime;
    UILabel *ListenLable;
    UIButton *backGroundButton;
    AVSpeechSynthesizer *av;
    UIButton *LISTButton;
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
    NSString *receivelng;
    NSString *receivelat;
    NSString *moneyStr;
    NSString *orderNum;
    UILabel *orderLable;
    UILabel *orderLablemoney;
    NSString *memberID;
    NSString *WORKTYPE;
    NSMutableArray *VoiceWageDataArray;
    NSMutableArray *VoiceWageIDArray;
    NSString *VoiceTime;
    int onum;
    float mstr;
    //    NSTimer *RefreshTimers;
    NSTimer *FiveTimesTimer;
    int VoiceWageCount;
    int RefreshTime;
    UIView *apportionView;
    UITextView *opinionView;
    UITextField *placeLables;
    NSString *theworkID;
    NSMutableArray *workIdarray;
    NSMutableArray *workNameArray;
    BOOL NOPLAY;
    NSString *    VoiceUr ;
    
    NSString *allot_type;
    
    NSInteger Srow;
    NSArray *allData;
    int dataNum;
    NSString *na;
    
    UIWindow *window;
    UIImageView *leftVoiceImageView;
    UIImageView *rightVoiceImageView;
    UILabel *VoiceTimeLable;
    NSString *voiceTimeStr;
    NSString *times;
    UIButton *PlayVoiceButton;
    BOOL ISTIMERSTR;
    NSTimer *VoiceImageTimer;
    NSTimer *VoiceChangeImageTimer;
    int thetimes;
    int ImageChange;
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (nonatomic,strong) GJToolBarView *toolBarView; //静音收工toolBarView
@property(nonatomic,strong)UITableView *GRtableview;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@end

@implementation GJVoiceWageViewController
@synthesize datasource;
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
    WorkTime = nil;
    [FiveTimesTimer invalidate];
    FiveTimesTimer = nil;
    NOPLAY = YES;
    
    [VoiceImageTimer invalidate];
    [VoiceChangeImageTimer invalidate];
    [self.audioPlayer stop];

    
}

#pragma mark - 物联宝过来的语音播报
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;

    NOPLAY = NO;
}
-(void)viewDidAppear:(BOOL)animated
{

    if (ISWork == YES) {
        [self addlistImageView];
        [self getVoicewageDataWork];
    }else
    {
        [self addCancellistImageView];
    }
}
- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CloseButtonDidClicked) name:@"CloseTheVoiceWage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GOout:) name:@"GOout" object:nil];
    
    dataNum=0;

    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _scrollView;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friocn_2x06"]];
    imgView.frame = _scrollView.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView insertSubview:imgView atIndex:0];
    self.scrollView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        //朱滴20181010听单数据错误
        [self positionButton];
        [self.scrollView.mj_header endRefreshing];
    }];
    ISWork = YES;
    onum = 0;
    mstr = 0;
    VoiceWageDataArray = [NSMutableArray array];
    VoiceWageIDArray = [NSMutableArray array];
    unexedataArrayDataOne = [NSDictionary dictionary];
    ivvDict = [NSDictionary dictionary];
    [self GetDataTime];
    [self createdUI];
    [self configLocationManagers];
    [super viewDidLoad];
    //增加监听，当键弹起时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wageFirstkeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wageFirstkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
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
        NSLog(@"-=-=--=-=-=-=-=-=lon = %f",location.coordinate.longitude);
        NSLog(@"-=-=--=-=-=-=-=-=lat = %f",location.coordinate.latitude);
//        if (error)
//        {
//            [GJSVProgressHUD showErrorWithStatus:@"刷新失败"];
//            //                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//        }
//        if (regeocode)
//        {
            receivelng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            receivelat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            [self GETPositionData];
            [GJSVProgressHUD showSuccessWithStatus:@"刷新成功"];
//        }
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
             [self alertToLoginMsg:dictionary[@"return_data"]];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"]];
             
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
             
             [self refreshlabel];
             [self.scrollView addSubview:orderLable];
             [self.scrollView addSubview:orderLablemoney];
         }
     }];
}
-(void)alertToLoginMsg:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    alert.delegate = delegate;
    [alert show];
    alert.tag=9999;
}
- (void) alertToUpMsg:(NSString *) str{//点击升级
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alert.delegate = delegate;
    [alert show];
    alert.tag=9996;
    
}
-(void)GetDataTime
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
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
    UILabel *DataLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 10, 30)];
    DataLable.text = DataStr;
    DataLable.textAlignment = NSTextAlignmentLeft;
    CGFloat datawidth = [UILabel getWidthWithTitle:DataStr font:[UIFont fontWithName:geshi size:20]];
    DataLable.frame = CGRectMake(10, 10, datawidth, 30);
    DataLable.font = [UIFont fontWithName:geshi size:17];
    orderLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 20, 30)];
    orderLable.textAlignment = NSTextAlignmentLeft;
    orderLable.numberOfLines = 0;
    if (!orderNum) {
        orderNum = @"0";
    }
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    orderNum = [defaults objectForKey:@"voice_nums"];
//    moneyStr = [defaults objectForKey:@"voice_price"];
    
    NSString *contentStr = @"今日完成订单,";
    NSString *orderstr = [NSString stringWithFormat:@"%@%@",contentStr,orderNum];
    NSInteger len = [orderNum lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * ontime = [[NSMutableString alloc]initWithString:contentStr];
    [ontime insertString:orderNum atIndex:6];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:ontime];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6, len)];
    orderLable.attributedText = str;
    CGFloat width = [UILabel getWidthWithTitle:orderstr font:[UIFont fontWithName:geshi size:20]];
    orderLable.frame = CGRectMake(10, 40, width, 30);
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
    if (![userdefaults objectForKey:@"workTime"]) {
        blable.text = @"您已经累计在线0分钟";
        Second = 0;
    }else
    {
        blable.text = [NSString stringWithFormat:@"您已经累计在线%@分钟",[userdefaults objectForKey:@"workTime"]];
        Second = [[userdefaults objectForKey:@"workTime"] intValue];
    }
    
    
    if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"]) {
        [self.scrollView addSubview:blable];
    }
    [self.scrollView addSubview:orderLablemoney];
    [self.scrollView addSubview:DataLable];
    
}
-(void)addlistImageView
{
    ListensingleImageview = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 60, CGRectGetMaxY(blable.frame)+ 20, 120, 120)];
    ListensingleImageview.layer.cornerRadius = 60;
    ListensingleImageview.image = [UIImage imageNamed:@"listionOrderButtonAnimation_100x100_@2x"];
    [self.scrollView addSubview:ListensingleImageview];
    ListenLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 - 60, CGRectGetMaxY(blable.frame)+ 20, 120, 120)];
    ListenLable.text = @"听单中";
    ListenLable.font = [UIFont fontWithName:geshi size:22];
    ListenLable.textAlignment = NSTextAlignmentCenter;
    ListenLable.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:ListenLable];
    LISTButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2 + 80, CGRectGetMaxY(ListensingleImageview.frame) - 85, 50, 50)];
    LISTButton.layer.cornerRadius = 25;
    [LISTButton setBackgroundColor:[UIColor orangeColor]];
    [LISTButton setTitle:@"收工" forState:UIControlStateNormal];
    na=@"0";
    [LISTButton addTarget:self action:@selector(imageViewTurn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:LISTButton];
    [self turn];
}
-(void)addCancellistImageView
{
    ListensingleImageview = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 60, CGRectGetMaxY(blable.frame)+ 20, 120, 120)];
    ListensingleImageview.layer.cornerRadius = 60;
    ListensingleImageview.image = [UIImage imageNamed:@"listionOrderButtonAnimation_100x100_@2x"];
    [self.scrollView addSubview:ListensingleImageview];
    ListenLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 - 60, CGRectGetMaxY(blable.frame)+ 20, 120, 120)];
    ListenLable.text = @"准备中";
    ListenLable.font = [UIFont fontWithName:geshi size:22];
    ListenLable.textAlignment = NSTextAlignmentCenter;
    ListenLable.textColor = [UIColor orangeColor];
    [self.scrollView addSubview:ListenLable];
    LISTButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2 + 80, CGRectGetMaxY(ListensingleImageview.frame) - 85, 50, 50)];
    LISTButton.layer.cornerRadius = 25;
    [LISTButton setBackgroundColor:gycoloer];
    [LISTButton setTitle:@"开工" forState:UIControlStateNormal];
    na=@"0";
    [LISTButton addTarget:self action:@selector(imageViewTurn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:LISTButton];
}
#pragma mark - 点击收工，开工。
-(void)GOout:(NSNotification *)noti
{
    NSDictionary  *dic = [noti userInfo];
    
    NSString *info = [dic objectForKey:@"STATE"];
    
    NSLog(@"接收 userInfo传递的消息：%@",info);
    
    if ([info isEqualToString:@"空闲"]) {
        ISWork=NO;
        
        [self imageViewTurn:LISTButton];
        
    }else{
        
        ISWork=YES;
        na=@"1";
        [self imageViewTurn:LISTButton];
    
    }

    
}
-(void)imageViewTurn:(UIButton *)sender
{
    if (ISWork == YES) {
        ISWork = NO;
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        [userdefaults setObject:[NSString stringWithFormat:@"%d",Second/60] forKey:@"workTime"];
        [userdefaults setObject:[NSString stringWithFormat:@"%d",Second] forKey:@"workTimesecond"];
        [userdefaults synchronize];
        [WorkTime invalidate];
        WorkTime = nil;
        [FiveTimesTimer invalidate];
        FiveTimesTimer = nil;
        [ListensingleImageview.layer removeAllAnimations];
        [ListensingleImageview removeFromSuperview];
        [ListenLable removeFromSuperview];
        [sender removeFromSuperview];
        if ([na isEqualToString:@"1"]) {
            
        }else{
        [self addCancellistImageView];
        }
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"繁忙" forKey:@"ONOFF"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BoolOF" object:nil userInfo:dic];
        
       
        
    }else
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"空闲" forKey:@"ONOFF"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BoolOF" object:nil userInfo:dic];
        
        
        ISWork = YES;
      
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        Second = [[userdefaults objectForKey:@"workTimesecond"] intValue];
        if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"]) {
            Second = [[userdefaults objectForKey:@"workTimesecond"] intValue];
            WorkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(BeganTimelevelTimer:) userInfo:nil repeats:YES];
        }
        [self getVoicewageDataWork];
#pragma mark - 定时听单
        FiveTimesTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(FiveTimesTimergetVoicewageData:) userInfo:nil repeats:YES];
        ListenLable.text = @"听单中";
        [sender setTitle:@"收工" forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor orangeColor]];
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.duration = 1.0;
        //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
        animation.cumulative = YES;
        animation.repeatCount = FLT_MAX;
        //在图片边缘添加一个像素的透明区域，去图片锯齿
        CGRect imageRrect = CGRectMake(0, 0,ListensingleImageview.frame.size.width, ListensingleImageview.frame.size.height);
        UIGraphicsBeginImageContext(imageRrect.size);
        
        [ListensingleImageview.image drawInRect:CGRectMake(1,1,ListensingleImageview.frame.size.width-2,ListensingleImageview.frame.size.height-2)];
        ListensingleImageview.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //围绕Z轴旋转，垂直与屏幕
        ListensingleImageview.transform = CGAffineTransformRotate(ListensingleImageview.transform, M_PI_2);
        [ListensingleImageview.layer addAnimation:animation forKey:nil];
    }
    [self ISbusy];
}
-(void)turn{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"]) {
        Second = [[userdefaults objectForKey:@"workTimesecond"] intValue];
        WorkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(BeganTimelevelTimer:) userInfo:nil repeats:YES];
    }
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.duration = 1.0;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = FLT_MAX;
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,ListensingleImageview.frame.size.width, ListensingleImageview.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [ListensingleImageview.image drawInRect:CGRectMake(1,1,ListensingleImageview.frame.size.width-2,ListensingleImageview.frame.size.height-2)];
    ListensingleImageview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //围绕Z轴旋转，垂直与屏幕
    ListensingleImageview.transform = CGAffineTransformRotate(ListensingleImageview.transform, M_PI_2);
    [ListensingleImageview.layer addAnimation:animation forKey:nil];
}

#pragma mark - 获取数据
-(void)getVoicewageDataWork
{
    [FiveTimesTimer invalidate];
    FiveTimesTimer = nil;
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *community_id = model.community_id;
    NSString *role;
    if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
        role = @"admin";
    }else
    {
        role = @"normal";
    }
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    
         [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"get_news_order2" andBodyOfRequestForKeyArr:@[@"community_id",@"role"] andValueArr:@[community_id,role] andBlock:^(id dictionary)
    
//NSString *    property_id = model.property_id;
//    
//    
//           [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_work_list" andBodyOfRequestForKeyArr:@[@"repair[property_id]",@"repair[community_id]",@"repair[repair_status]",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"未处理",@"0",@"10"] andBlock:^(id dictionary)
//          
    
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }
         else if([state isEqualToString:@"0"])
         {
             FiveTimesTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(FiveTimesTimergetVoicewageData:) userInfo:nil repeats:YES];
         }else if ([state isEqualToString:@"-1"])
         {
             [self getVoicewageDataWork];
         }
         else if([state isEqualToString:@"1"])
         {
             
             NSArray *unexedataArray = [NSArray array];
             
             allData=[NSArray array];
             allData=dictionary[@"return_data"];
             dataNum=0;
             unexedataArray = dictionary[@"return_data"];
             NSDictionary *dict = unexedataArray[0];
             
             memberID = [NSString stringWithFormat:@"%@",dict[@"value"]];
             
             allot_type=[NSString stringWithFormat:@"%@",dict[@"allot_type"]];
             
             unexedataArrayDataOne = [NSDictionary dictionary];
             unexedataArrayDataOne = dict;
             NSLog(@"%@",dict[@"remarks"]);
             NSMutableArray *vvv=[NSMutableArray arrayWithArray:[UserDefaults objectForKey:@"MEMBERID_ARR"]];
             
             NSLog(@"%@,%@",memberID,vvv);
             if ([vvv containsObject: memberID]) {
                 [self xiayige:@"yes"];
             }else{
                 
//                 [vvv addObject:memberID];
//                 [UserDefaults setObject:vvv forKey:@"MEMBERID_ARR"];
                 
                 
//                 [self VoiceWageArray];
                 //20181010
                 if (unexedataArray.count) {
                     datasource = unexedataArray[0];
                     [self VoiceWageArray];
                     [userDefaults setObject:@"1" forKey:@"order_type"];
                     
                 }else{
                     //朱滴20180905增加后台听单-没有新听单就销毁后台
                     [userDefaults setObject:@"0" forKey:@"order_type"];
                 }
                 [userDefaults synchronize];
                 [self refreshlabel];

             }
             

             
         }
     }];
}
-(void)refreshlabel
{
    NSString *contentStr = @"今日完成订单,";
    NSString *orderstr = [NSString stringWithFormat:@"%@%@",contentStr,orderNum];
    NSInteger len = [orderNum lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *ontime = [[NSMutableString alloc]initWithString:contentStr];
    [ontime insertString:orderNum atIndex:6];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:ontime];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(6, len)];
    [orderLable setAttributedText:str];
    CGFloat width = [UILabel getWidthWithTitle:orderstr font:[UIFont fontWithName:geshi size:20]];
    orderLable.frame = CGRectMake(10, 40, width, 30);
    orderLable.font = [UIFont fontWithName:geshi size:20];
    
    NSString *contentStrs = @"赚取了元";
    NSInteger lens = [moneyStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSMutableString * ontimes = [[NSMutableString alloc]initWithString:contentStrs];
    [ontimes insertString:moneyStr atIndex:3];
    NSMutableAttributedString *strs = [[NSMutableAttributedString alloc]initWithString:ontimes];
    [strs addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, lens)];
    [orderLablemoney setAttributedText:strs];
    
}
-(void)WorkorderList333
{
    
    SLog(@"%@",unexedataArrayDataOne);
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    UIWindow *awindow = [UIApplication sharedApplication].keyWindow;
    
    //黑色背景
    backGroundButton = [[UIButton alloc]initWithFrame:awindow.frame];
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    //报修工单View
    workOrderListView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, WIDTH - 40, HEIGHT - 200)];
    workOrderListView.backgroundColor = [UIColor whiteColor];
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, workOrderListView.width, workOrderListView.width/4)];
    workOrderListView.layer.cornerRadius = 15;
    workOrderListView.clipsToBounds = YES;
    
    //顶部实时图片
    headImageView.image = [UIImage imageNamed:@"friocn_2x10"];
    headImageView.userInteractionEnabled = YES;
    
    //顶部关闭按钮
    UIButton *closeButton = [[UIButton alloc]init];
    if (IS_IPAD) {
        closeButton.frame = CGRectMake(workOrderListView.width -workOrderListView.width/8 , 0, workOrderListView.width/8, workOrderListView.width/8);
        
    }else{
        
        closeButton.frame = CGRectMake(workOrderListView.width - 40, 0, 40, 40);
    }
    [closeButton addTarget:self action:@selector(CloseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"orderPlayPageCloseButton_40x40_"] forState:UIControlStateNormal];
    
    //报修地址，报修内容
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
    // 顶部“入室维修”
    contentLable.text = unexedataArrayDataOne[@"type_name"];
    [headImageView addSubview:distanceLable];
    [headImageView addSubview:contentLable];
    
    //起始图标
    UIImageView *StartPointImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(headImageView.frame) + 20, 30, 30)];
    StartPointImageView.image = [UIImage imageNamed:@"friocn_2x15"];
    UILabel *StartPointLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(StartPointImageView.frame) + 5, CGRectGetMaxY(headImageView.frame) + 20, workOrderListView.width - 50, 30)];
    StartPointLable.textAlignment = NSTextAlignmentLeft;
    StartPointLable.font = [UIFont fontWithName:geshi size:17];
    NSString *RoomAddress;
    StartPointLable.text = unexedataArrayDataOne[@"position"];
    
    StartPointLable.text = unexedataArrayDataOne[@"add"];
    RoomAddress = [unexedataArrayDataOne[@"room_info"][@"room_address"] stringByReplacingOccurrencesOfString:@"-" withString:@"#"];
    
    
    UILabel *EndPointLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(StartPointImageView.frame)+10, workOrderListView.width - 50, 30)];
    EndPointLable.textAlignment = NSTextAlignmentLeft;
    EndPointLable.font = [UIFont fontWithName:geshi size:17];
    NSString *userName;
    userName=unexedataArrayDataOne[@"name"];
    NSString *EndPointStr;
    if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
        EndPointStr = [NSString stringWithFormat:@"投  诉  人 : %@ ",userName];
    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
        EndPointStr = [NSString stringWithFormat:@"咨  询  人 : %@ ",userName];

    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
        EndPointStr = [NSString stringWithFormat:@"提  交  人 : %@ ",userName];

    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
        EndPointStr = [NSString stringWithFormat:@"申  请  人 : %@ ",userName];
        
    }
    else {
        
        EndPointStr = [NSString stringWithFormat:@"报  修  人 : %@ ",userName];

    }
    
    
    EndPointLable.text = EndPointStr;
    
    //报修电话
    UILabel *EndPhonenumLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPointLable.frame) + 5, workOrderListView.width - 50, 30)];
    EndPhonenumLable.textAlignment = NSTextAlignmentLeft;
    EndPhonenumLable.font = [UIFont fontWithName:geshi size:17];
    NSString *phoneNumber = [NSString stringWithFormat:@"%@",unexedataArrayDataOne[@"tel"]];
    NSString *EndPhonenum = [NSString stringWithFormat:@"联系电话 : %@",phoneNumber];
    EndPhonenumLable.text = EndPhonenum;
    
    
    
    if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
        //公共
        EndPointLable.frame =CGRectMake(10, CGRectGetMaxY(StartPointImageView.frame)+10, workOrderListView.width - 50, 30);
        EndPointLable.text=@"公共区域报事";
        EndPhonenumLable.frame = CGRectMake(10, CGRectGetMaxY(EndPointLable.frame) + 5, workOrderListView.width - 50, 0);
        
        
        
    }else{
        //普通
        
    }
    
    
    
    
    //预约时间
    NSString *repair_time;
    if ([unexedataArrayDataOne[@"time"] isEqualToString:@""]) {
        repair_time = @"尽快";
    }else{
        repair_time = unexedataArrayDataOne[@"time"];
    }
    UILabel *orderLables = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(EndPhonenumLable.frame), workOrderListView.width - 40, 20)];
    orderLables.textAlignment = NSTextAlignmentLeft;
    orderLables.font = [UIFont fontWithName:geshi size:17];
    
    
    if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
        
        orderLables.text = [NSString stringWithFormat:@"投诉时间 : %@",repair_time];

    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
        EndPointStr = [NSString stringWithFormat:@"咨询人 : %@ ",userName];
        orderLables.text = [NSString stringWithFormat:@"咨询时间 : %@",repair_time];

    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
        
        orderLables.text = [NSString stringWithFormat:@"提交时间 : %@",repair_time];

    }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
        
        orderLables.text = [NSString stringWithFormat:@"申请时间 : %@",repair_time];
        
    }
    else {
        
        orderLables.text = [NSString stringWithFormat:@"预约时间 : %@",repair_time];

    }
    
    
    
    
    
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
    
    
    
    
    UIButton *OrdersButtons = [[UIButton alloc]initWithFrame:CGRectMake(workOrderListView.width/2 - 50, CGRectGetMaxY(ContentLable.frame) + 20, 100, 100)];
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
    
    
    
    UIButton *AdminOrdersButton = [[UIButton alloc]initWithFrame:CGRectMake(workOrderListView.width/2 - 75, CGRectGetMaxY(ContentLable.frame) + 30, 100, 100)];
    [AdminOrdersButton setBackgroundImage:[UIImage imageNamed:@"getOrderButton_100x100_@2x"] forState:UIControlStateNormal];
    [AdminOrdersButton addTarget:self action:@selector(AdminOrdersButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"R"]) {
        //报修工单
        [AdminOrdersButton setTitle:@"分配工单" forState:UIControlStateNormal];

    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]){
        //    投诉
        [AdminOrdersButton setTitle:@"投诉查看" forState:UIControlStateNormal];

        
    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
        //        咨询
        [AdminOrdersButton setTitle:@"咨询查看" forState:UIControlStateNormal];

    }
    else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
        //        会员审核
        [AdminOrdersButton setTitle:@"审核查看" forState:UIControlStateNormal];

    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
        //门禁
        [AdminOrdersButton setTitle:@"审核操作" forState:UIControlStateNormal];

    }


    
    
    
    [AdminOrdersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    _scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(OrdersButtons.frame)+20);
    NSArray *videoArray = [NSArray array];
    videoArray = ivvDict[@"video"];
    NSArray *voiceArray = [NSArray array];
    voiceArray = ivvDict[@"voice"];
    NSArray *imageArray = [NSArray array];
    imageArray = ivvDict[@"images"];
    NSString *strssss;
    NSString *wageType;
    if (videoArray.count != 0) {
        
        if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
//            EndPointStr = [NSString stringWithFormat:@"投诉人 : %@ ",userName];
            wageType = @"投诉内容";

        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
            
            wageType = @"咨询内容";

        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
            
            wageType = @"审核备注";

        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
            
            wageType = @"申请备注";
            
        }
        else {
            
            
            wageType = @"工单类型";

        }
        
        
        
        
        
        
        
        
        ivvStr = @"视频工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];
            
        }else{
            
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
        }
    }else if (voiceArray.count != 0)
    {
        if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
            EndPointStr = [NSString stringWithFormat:@"投诉人 : %@ ",userName];
            wageType = @"投诉内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
            
            wageType = @"咨询内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
            
            wageType = @"备注";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
            
            wageType = @"申请备注";
            
        }
        else {
            
            
            wageType = @"工单类型";
            
        }
        
        ivvStr = @"语音工单";
        NSString *voiceStr;
        for (NSDictionary *voice in ivvDict[@"voice"]) {
            voiceStr = voice[@"voice"];
        }
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        //        NSString *voiceurl = [userdefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@",voiceStr];
        
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];
            
        }else{
            
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@%@,预约时间,%@,工单内容",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time];
        }
        
    }else if (imageArray.count != 0)
    {
        if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
//            EndPointStr = [NSString stringWithFormat:@"投诉人 : %@ ",userName];
            wageType = @"投诉内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
            
            wageType = @"咨询内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
            
            wageType = @"备注";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
            
            wageType = @"申请备注";
            
        }
        else {
            
            
            wageType = @"工单类型";
            
        }
        
        
        ivvStr = @"图片工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];
            
        }else{
            
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单类型,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,ivvStr];
        }
    }else
    {
        if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]) {
//            EndPointStr = [NSString stringWithFormat:@"投诉人 : %@ ",userName];
            wageType = @"投诉内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
            
            wageType = @"咨询内容";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
            
            wageType = @"备注";
            
        }else if([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
            
            wageType = @"申请备注";
            
        }
        else {
            
            
            wageType = @"工单类型";
            
        }
        
        ivvStr = @"文字工单";
        if ([unexedataArrayDataOne[@"is_op"] isEqualToString:@"P"]) {
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,公共区域报修工单,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,repair_time,unexedataArrayDataOne[@"description"]];
            
        }else{
            strssss = [NSString stringWithFormat:@"实时：%@小区,您有一条%@工单需要处理,地址,%@室,%@,%@,预约时间,%@,工单内容,%@",distanceLable.text,unexedataArrayDataOne[@"parent_class"],RoomAddress,EndPointStr,EndPhonenum,repair_time,unexedataArrayDataOne[@"description"]];
        }
    }
    NSMutableArray *VoiceArr=[NSMutableArray array];
    for (int i=0; i<50; i++) {
        NSString *str=[NSString stringWithFormat:@"%@",unexedataArrayDataOne[@"voice_txt"]];
        [VoiceArr addObject:str];
    }
    if ([ivvStr isEqualToString:@"文字工单"]) {
        ContentLable.text = [NSString stringWithFormat:@"%@ : %@",wageType,unexedataArrayDataOne[@"remarks"]];
    
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
    
    
    //静音收工View
    MJWeakSelf
    _toolBarView = [[GJToolBarView alloc]init];
    _toolBarView.NoSoundBlock = ^(BOOL JYSelected){
  
        [weakSelf MuteButton:JYSelected];
    };
    
#pragma mark - 收工方法
    _toolBarView.KnockOffBlock = ^(){
        [weakSelf xiayige:@"yes"];
//        [weak_self NOworkButtonDidClicked];
    };
    
    [workOrderListView addSubview:_toolBarView];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((WIDTH-40)/2/2-50, 0, 60, 45)];
    
    lab.text=@"下一个";
    lab.textColor=[UIColor whiteColor];
    lab.font=[UIFont systemFontOfSize:17];
    lab.textAlignment=NSTextAlignmentRight;
    [ _toolBarView.KnowOffButton addSubview:lab];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(lab.bounds.size.width+lab.frame.origin.x+10, 7, 30, 30)];
    [img setImage:[UIImage imageNamed:@"next_icon1"]];
    [ _toolBarView.KnowOffButton addSubview:img];

    [_toolBarView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.right.bottom.equalTo(workOrderListView);
        make.height.mas_equalTo(45);
    }];
    
    
    /* 
     UIButton * MuteButton = [[UIButton alloc]init];
     if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"]) {
     [workOrderListView addSubview:OrdersButtons];
     MuteButton.frame = CGRectMake(20, HEIGHT - 170, 60, 60);
     
     }else
     {
     MuteButton.frame = CGRectMake(20, HEIGHT - 170, 60, 60);
     }
     [MuteButton setBackgroundImage:[UIImage imageNamed:@"friocn_2x13"] forState:UIControlStateNormal];
     [MuteButton setTitle:@"静音" forState:UIControlStateNormal];
     [MuteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [MuteButton addTarget:self action:@selector(MuteButton) forControlEvents:UIControlEventTouchUpInside];
     
     UIButton *NOworkButton = [[UIButton alloc]initWithFrame:CGRectMake(workOrderListView.width - 80, HEIGHT - 170, 60, 60)];
     NOworkButton.layer.cornerRadius = 30;
     [NOworkButton setBackgroundColor:[UIColor orangeColor]];
     [NOworkButton setTitle:@"收工" forState:UIControlStateNormal];
     [NOworkButton addTarget:self action:@selector(NOworkButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];*/
    
#pragma mark - 工单类型的Lable的位置
    //更新UILabel的frame
    ContentLable.frame = CGRectMake(10, CGRectGetMaxY(orderLables.frame) + 10, workOrderListView.width - 40, conctualsize.height);
#pragma mark - 区分视频，图片，语音类型的工单下面的东西
    if (videoArray.count != 0) {
    //视频工单
        
        UIButton *imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat  hhh;
        if (IPHONE5) {
            hhh=50;
        }else{
            hhh=90;
        }
        imgBtn.frame=CGRectMake(10, ContentLable.frame.origin.y+conctualsize.height+5+10, hhh, hhh);
        [workOrderListView addSubview:imgBtn];

        
        [imgBtn addTarget:self action:@selector(bofang) forControlEvents:UIControlEventTouchUpInside];
    
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, hhh, hhh)];
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",videoArray[0][@"video_img_ico"]]] placeholderImage:[UIImage imageNamed:@"100x100"]];
        [imgBtn addSubview:img];
        UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(img.bounds.size.width/2 - 15, img.bounds.size.width/2 - 15, 30, 30)];
        bofangimageView.backgroundColor = [UIColor clearColor];
        bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
        [img addSubview:bofangimageView];
        
    }else if (voiceArray.count != 0)
    {
        
        times = voiceArray[0][@"voice_time"];
      NSInteger  VoiceButtonLength = [times integerValue];
        
        NSString *voiceStr = voiceArray[0][@"voice"];
        VoiceUr = [NSString stringWithFormat:@"%@",voiceStr];
        
    //语音工单
        UILabel * timeLab = [[UILabel alloc]init];
        timeLab.textColor = NAVCOlOUR;
        timeLab.font = [UIFont fontWithName:geshi size:15];
        [workOrderListView addSubview:timeLab];
        
        UIImageView *  VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
        [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
        
        
        timeLab.text = [NSString stringWithFormat:@"%ld''",(long)VoiceButtonLength];
        int voiceLength;

        if (VoiceButtonLength <= 10) {
            voiceLength = 80;
            timeLab.frame = CGRectMake(100,  ContentLable.frame.origin.y+conctualsize.height+8, 30, 22);
        }else if (VoiceButtonLength > 10 && VoiceButtonLength <= 20 )
        {
            voiceLength = 100;
            timeLab.frame = CGRectMake(120,  ContentLable.frame.origin.y+conctualsize.height+8, 30, 22);
            
        }else if (VoiceButtonLength > 20 && VoiceButtonLength <= 40)
        {
            voiceLength = 120;
            timeLab.frame = CGRectMake(140,  ContentLable.frame.origin.y+conctualsize.height+8, 30, 22);
            
        }else if (VoiceButtonLength > 40 && VoiceButtonLength <= 60)
        {
            voiceLength = 140;
            timeLab.frame = CGRectMake(160, ContentLable.frame.origin.y+conctualsize.height+8, 30, 22);
        }

        
        
        UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(10, ContentLable.frame.origin.y+conctualsize.height+5, voiceLength, 28)];
        
        [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(UNExePlayVoiceButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [workOrderListView addSubview:voiceButton];
        
        [voiceButton addSubview:VoiceImageView];
        
    }else if (imageArray.count != 0)
    {
    //图片工单
//        UIScrollView *scr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ContentLable.origin.y+conctualsize.height, workOrderListView.width, 40)];
//        NSInteger  numLine;
//        if (imageArray.count%3==0) {
//            numLine=imageArray.count/3;
//            
//        }else{
//            numLine=imageArray.count/3+1;
//
//        }
//        scr.contentSize=CGSizeMake(numLine*workOrderListView.width, 40);
//
//        for (int i=0; i<numLine; i++) {
//            UIView *fenV=[[UIView alloc]initWithFrame:CGRectMake(workOrderListView.width*i, 0, workOrderListView.width, 40)];
//            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((workOrderListView.width-120)/4, 0, 40, 40)];
//            
//            [scr addSubview:fenV];
//            [scr addSubview:img];
//        }
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        
        CGFloat Hei;
        if (IPHONE5) {
            layout.itemSize=CGSizeMake(60, 60);
            layout.sectionInset=UIEdgeInsetsMake(0, (workOrderListView.width-180)/4, 0, (workOrderListView.width-180)/4);
            layout.minimumLineSpacing=(workOrderListView.width-180)/4;
            Hei=60;
        }else{
            layout.itemSize=CGSizeMake(90, 90);
            layout.sectionInset=UIEdgeInsetsMake(0, (workOrderListView.width-270)/4, 0, (workOrderListView.width-270)/4);
            layout.minimumLineSpacing=(workOrderListView.width-270)/4;
            Hei=90;
            
        }
        
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, ContentLable.frame.origin.y+conctualsize.height+5+10, workOrderListView.width,Hei) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ddd"];
        [workOrderListView addSubview:collectionView];
 
        
        
    }else
    {
        
        
    //文字工单
    }
    
    
    
    
    if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"]) {
        //是工人端就加上OrdersButtons；
        [backGroundButton addSubview:OrdersButtons];
        OrdersButtons.centerX = backGroundButton.centerX;
        [OrdersButtons setFrame:CGRectMake(OrdersButtons.frame.origin.x,workOrderListView.frame.origin.y+workOrderListView.frame.size.height + 30,OrdersButtons.frame.size.width,OrdersButtons.frame.size.height)];
        
    }else{
        //是管家端就加上AdminOrdersButton；
        [backGroundButton addSubview:AdminOrdersButton];
        AdminOrdersButton.centerX = backGroundButton.centerX;
        [AdminOrdersButton setFrame:CGRectMake(AdminOrdersButton.frame.origin.x,workOrderListView.frame.origin.y+workOrderListView.frame.size.height + 30,AdminOrdersButton.frame.size.width,AdminOrdersButton.frame.size.height)];

    }
    
    [workOrderListView addSubview:StartPointImageView];
    [workOrderListView addSubview:EndPhonenumLable];
    [workOrderListView addSubview:ContentLable];
    [workOrderListView addSubview:StartPointLable];
    [workOrderListView addSubview:EndPointLable];
    [workOrderListView addSubview:orderLables];
    [workOrderListView addSubview:headImageView];
    [workOrderListView addSubview:closeButton];
    
    [backGroundButton addSubview:workOrderListView];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        if (NOPLAY == YES) {
            return ;
        }else
        {
            [awindow addSubview:backGroundButton];
//            [awindow bringSubviewToFront:backGroundButton];
            av = [[AVSpeechSynthesizer alloc]init];
            
            
            NSLog(@"语音播放%@",VoiceArr[0]);
//            for (int i=0; i<VoiceArr.count; i++) {
            
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:VoiceArr[0]]; //需要转换的文本
            utterance.postUtteranceDelay = 1;
            av.delegate = self;
            [av speakUtterance:utterance];
//            }
        }
        
    });

    
}
//图片个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *imageArray = [NSArray array];
    imageArray= ivvDict[@"images"];
    return imageArray.count;
    
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ddd" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    CGFloat Hei;
    if (IPHONE5) {
        Hei=60;
    }else{
        Hei=90;
        
    }
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Hei, Hei)];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ivvDict[@"images"][indexPath.row][@"images_ico"]]] placeholderImage:[UIImage imageNamed:@"100x100"]];
    [cell addSubview:img];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%@",ivvDict[@"images"][indexPath.row][@"images"]);
       
    NSMutableArray *imagedataArray=[NSMutableArray array];
    
    for (int i=0; i<[ivvDict[@"images"] count]; i++) {
        NSString *str=[NSString stringWithFormat:@"%@",ivvDict[@"images"][i][@"images"]];
        [imagedataArray addObject:[GJMHPhotoModel photoWithURL:[NSURL URLWithString:str]]];

    }
    
        NSLog(@"%@",imagedataArray);
    
    GJMHPhotoBrowserController *vc = [GJMHPhotoBrowserController new];

    vc.displayTopPage = YES;
    vc.displayDeleteBtn = NO;
    vc.imgArray = imagedataArray;
    [self presentViewController:vc animated:YES completion:nil];
    
    backGroundButton.hidden=YES;

}


//语音
-(void)UNExePlayVoiceButtonDidClicked
{
    voiceTimeStr = times;
    window = [UIApplication sharedApplication].keyWindow;
    backGroundButton = [[UIButton alloc]initWithFrame:window.frame];
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [backGroundButton addTarget:self action:@selector(backGroundButtonDisMiss) forControlEvents:UIControlEventTouchUpInside];
    UIView *VoiceView = [[UIView alloc]initWithFrame:CGRectMake(0, window.frame.size.height - 200, WIDTH, 200)];
    VoiceView.backgroundColor = [UIColor whiteColor];
    leftVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 100, 20, 80, 30)];
    rightVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 + 20, 20, 80, 30)];
    VoiceTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 - 20, 20, 40, 30)];
    VoiceTimeLable.backgroundColor = [UIColor clearColor];
    VoiceTimeLable.textAlignment = NSTextAlignmentCenter;
    VoiceTimeLable.textColor = gycolor;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%@s",voiceTimeStr];
    PlayVoiceButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2 - 50, 60, 100, 100)];
    [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
    
    [PlayVoiceButton addTarget:self action:@selector(voicesPlayDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [VoiceView addSubview:leftVoiceImageView];
    [VoiceView addSubview:rightVoiceImageView];
    [VoiceView addSubview:VoiceTimeLable];
    [VoiceView addSubview:PlayVoiceButton];
    [backGroundButton addSubview:VoiceView];
    [window addSubview:backGroundButton];
    [self voicesPlayDidClicked];


}
-(void)voicesPlayDidClicked
{
    if (ISTIMERSTR == YES) {
        ISTIMERSTR = NO;
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_n_103@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_n_103@2x"]];
        VoiceTimeLable.text = [NSString stringWithFormat:@"%@s",voiceTimeStr];
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x86"] forState:UIControlStateNormal];
        //结束定时器
        [VoiceImageTimer invalidate];
        [VoiceChangeImageTimer invalidate];
        //        [[PlayerManager sharedManager] stopPlaying];
        [self.audioPlayer stop];
    }else
    {
        ISTIMERSTR = YES;
        thetimes = [voiceTimeStr intValue];
        ImageChange = ([voiceTimeStr intValue]) * 2;
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
        //设置扩音播放
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];

        
            
                [self.audioPlayer playURL:[NSURL URLWithString:VoiceUr]];
                //启动定时器
                VoiceImageTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(unexechangeVoiceImage:) userInfo:nil repeats:YES];
                VoiceChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(unexechangeimageVoiceImage:) userInfo:nil repeats:YES];
        
        
        
    }
}
-(void)unexechangeVoiceImage:(NSTimer *)time
{
    ISTIMERSTR = YES;
    thetimes -= 0.5;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%ds ",thetimes];
    if (thetimes == 0) {
        [self backGroundButtonDisMiss];
    }
}
-(void)unexechangeimageVoiceImage:(NSTimer *)time
{
    ImageChange -= 0.5;
    if (ImageChange%2 == 0) {
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_a_102@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_a_102@2x"]];
    }else
    {
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_a_103@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_a_103@2x"]];
    }
    if (thetimes == 0) {
        //结束定时器
        [VoiceChangeImageTimer invalidate];
        VoiceChangeImageTimer = nil;
    }
}
-(void)backGroundButtonDisMiss
{
    ISTIMERSTR = NO;
    [VoiceImageTimer invalidate];
    [VoiceChangeImageTimer invalidate];
    [self.audioPlayer stop];
    [backGroundButton removeFromSuperview];
}




//视频
-(void)bofang{
    GJZXVideo *video = [[GJZXVideo alloc] init];
    video.playUrl =[NSString stringWithFormat:@"%@", ivvDict[@"video"][0][@"video"]];
    GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
    vc.video = video;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    backGroundButton.hidden=YES;

}

-(void)xiayige:(NSString *)str
{
    NSLog(@"%d",dataNum);
    if (dataNum+1<allData.count) {
        [FiveTimesTimer invalidate];
        
        FiveTimesTimer = nil;
        

//准备下一个的数据
        NSDictionary *or_dict ;
        
        if ([str isEqualToString:@"no"]) {
       

            NSDictionary *dict = allData[dataNum];
            //拿到当前的id
            memberID = [NSString stringWithFormat:@"%@",dict[@"value"]];
            or_dict = allData[dataNum];


        }else{
            
            NSDictionary *dict = allData[dataNum+1];
            //拿到当前的id
            memberID = [NSString stringWithFormat:@"%@",dict[@"value"]];

            or_dict = allData[dataNum+1];
            
            dataNum=dataNum+1;

        }
        
        unexedataArrayDataOne = [NSDictionary dictionary];
        unexedataArrayDataOne = or_dict;
        allot_type=[NSString stringWithFormat:@"%@",or_dict[@"allot_type"]];


            [self VoiceWageArray];
            
            
            if ([str isEqualToString:@"no"]) {
                
            }else{
            NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[UserDefaults objectForKey:@"MEMBERID_ARR"]];
            
            [arr addObject:memberID];
            NSLog(@"%@",arr);
            [UserDefaults setObject:arr forKey:@"MEMBERID_ARR"];
            }
            
        
        

        
    }else{
        
        NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:[UserDefaults objectForKey:@"MEMBERID_ARR"]];
        NSDictionary *dict = allData[[allData count]-1];
        memberID = [NSString stringWithFormat:@"%@",dict[@"value"]];
        unexedataArrayDataOne = dict;
        
        if ([str isEqualToString:@"no"]) {
            [self VoiceWageArray];

        }else{
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            [UserDefaults setObject:arr forKey:@"MEMBERID_ARR"];
            
            //重新走接口

            [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
            [self.audioPlayer stop];
            [workOrderListView removeFromSuperview];
            [backGroundButton removeFromSuperview];
            
            FiveTimesTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(FiveTimesTimergetVoicewageData:) userInfo:nil repeats:YES];
        }
        
  
     
    }
}

//静音按钮
-(void)MuteButton:(BOOL)JYsel
{
    if (JYsel==YES) {
        [av pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
        
//        [self.audioPlayer stop];
    }else{
        
        [av continueSpeaking];
        

    }

}

-(void)NOworkButtonDidClicked
{
    ISWork = NO;
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
    [backGroundButton removeFromSuperview];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:[NSString stringWithFormat:@"%d",Second/60] forKey:@"workTime"];
    [userdefaults setObject:[NSString stringWithFormat:@"%d",Second] forKey:@"workTimesecond"];
    [userdefaults synchronize];
    [WorkTime invalidate];
    WorkTime = nil;
    [FiveTimesTimer invalidate];
    FiveTimesTimer = nil;
    [ListensingleImageview.layer removeAllAnimations];
    [ListensingleImageview removeFromSuperview];
    [ListenLable removeFromSuperview];
    [self addCancellistImageView];
}
#pragma mark - 当语音播放完毕后，如果是语音的就读语音
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance
{
//    if ([ivvStr isEqualToString:@"语音工单"]) {
//        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
//        [self.audioPlayer playURL:[NSURL URLWithString:VoiceUrl]];
//    }
    [av speakUtterance:utterance];
    

}
-(void)CloseButtonClicked
{
         [self CloseButtonDidClicked];

}
#pragma mark - 点击了关闭按钮
-(void)CloseButtonDidClicked
{
    

//    FiveTimesTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(FiveTimesTimergetVoicewageData:) userInfo:nil repeats:YES];
    
    [backGroundButton removeFromSuperview];
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
   
//    if (dataNum>0) {
//        dataNum=dataNum-1;
//        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:[UserDefaults objectForKey:@"MEMBERID_ARR"]];
//        [arr removeLastObject];
//        [UserDefaults setObject:arr forKey:@"MEMBERID_ARR"];
        [self xiayige:@"no"];
        
        
        
//    }else{
//        dataNum=0;
//        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:[UserDefaults objectForKey:@"MEMBERID_ARR"]];
//        [arr removeAllObjects];
//        [UserDefaults setObject:arr forKey:@"MEMBERID_ARR"];
//        [self xiayige:@"no"];


//    }

    
}
-(void)FiveTimesTimergetVoicewageData:(NSTimer *)atimer
{
    [self getVoicewageDataWork];
}

//维修师傅
-(void)AdminOrdersButtonDidClicked
{
    if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"R"]) {
        //报修工单
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
                 if (workIdarray.count>0) {
                     theworkID = [NSString stringWithFormat:@"%@",workIdarray[0]];
                     Srow = 0;
                 }
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
                 if (workIdarray.count>0) {
                     theworkID = [NSString stringWithFormat:@"%@",workIdarray[0]];
                     Srow = 0;
                 }
                 [GJSVProgressHUD dismiss];
                 [self WorkYesButtonDidClicked];
             }
             
         }];
        
    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]){
        //    投诉
        [self tousuzixun:unexedataArrayDataOne[@"value"]];
    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
        //        咨询
        [self tousuzixun:unexedataArrayDataOne[@"value"]];
    }
    else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"M"]){
        //        会员审核
        [self shenhe:unexedataArrayDataOne[@"value"]];
        
        
        
  
    }else if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"SD"]){
        
      

        
    }

    
    
    
    
    

}
-(void)tousuzixun:(NSString *)tz_ID
{
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"feedback_info" andBodyOfRequestForKeyArr:@[@"feedback_id"] andValueArr:@[tz_ID] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary);

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

             
             if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"A"]){
                 //咨询
                 
            backGroundButton.hidden=YES;

                 [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                 [self.audioPlayer stop];
             }else     if ([unexedataArrayDataOne[@"voice_type"] isEqualToString:@"C"]){
                 
               
                 backGroundButton.hidden=YES;
                 
                 [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
                 [self.audioPlayer stop];
             }
             
             
         }
         
     }];
    

}
-(void)shenhe:(NSString *)str
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"owner_info" andBodyOfRequestForKeyArr:@[@"audit_id"] andValueArr:@[str] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary);

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
             NSLog(@"%@",dictionary);
             backGroundButton.hidden=YES;
             
             [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
             [self.audioPlayer stop];
         }
         
     }];
    


}


-(void)WorkYesButtonDidClicked
{
    ISWork = NO;
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
    _coverButton = [[UIButton alloc]init];
    _coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [_coverButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _coverButton.frame = window.bounds;
    
    
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
    [_coverButton addSubview:apportionView];
    [window addSubview:_coverButton];
    
}
-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[worknameID]];
}
//分派确定
-(void)YESButtonVoiceWageDidClicked:(UIButton *)sender
{
    NSString *repairID = unexedataArrayDataOne[@"value"];
    NSString *servingtime = unexedataArrayDataOne[@"time"];
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
        NSLog(@"%@",property_ids);
        NSLog(@"%@",repairID);
        NSLog(@"%@",theworkID);
        NSLog(@"%@",servingtime);
        NSLog(@"%@",opinionView.text);

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
                 ISWork = YES;
                 if (workIdarray.count>0) {
                     theworkID = [NSString stringWithFormat:@"%@",workIdarray[0]];
                     
                 }
                 
                 [self getVoicewageDataWork];
             }
             [_coverButton removeFromSuperview];
         }];
    }
}
-(void)Closebutton
{
    ISWork = YES;
    [_coverButton removeFromSuperview];
}
-(void)VoiceWageArray
{
    ivvDict = [NSDictionary dictionary];
    
    ivvDict = unexedataArrayDataOne[@"ivv_json"];
    [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.audioPlayer stop];
    [workOrderListView removeFromSuperview];
    [backGroundButton removeFromSuperview];
    if (ISWork == YES) {
        [self WorkorderList333];
    }
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
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
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
        //抢单暂停声音
        [av stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        [self.audioPlayer stop];
        
        }else{
        
        
        
        
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"receive" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[memberID] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
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
//                 [GJSVProgressHUD showSuccessWithStatus:@"接单成功"];
//                 [backGroundButton removeFromSuperview];
//                 [self getVoicewageDataWork];
                 
                 //朱滴20180905增加后台听单,修复听单无数据,接单后后台销毁
                 [GJSVProgressHUD showSuccessWithStatus:@"接单成功"];
                 [backGroundButton removeFromSuperview];
                 NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                 
                 onum += [datasource[@"product_info"][@"total_nums"] intValue];
                 mstr += [datasource[@"total_price"] floatValue];
                 orderNum = [NSString stringWithFormat:@"%d", onum];
                 moneyStr = [NSString stringWithFormat:@"%.2f", mstr];
                 [defaults setObject:orderNum forKey:@"voice_nums"];
                 [defaults setObject:moneyStr forKey:@"voice_price"];
                 /*
                  json解析过程中，若是全是数字，会默认成nscfnumber。
                  需要变成nsstring才能保存时。
                  
                  newsInfo.uid=[NSString stringWithFormat:@"%@",info.uid];
                  */
                 [defaults setObject:@"0" forKey:@"order_type"];
                 [defaults synchronize];
                 [self getVoicewageDataWork];
             }
         }];
    }
}
-(void)yanzheng:(NSString *)str
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"confirm_grab" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[str] andBlock:^(id dictionary)
     {
         
         
         
         
         
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [GJSVProgressHUD dismiss];
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
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
                              [self getVoicewageDataWork];
         }
     }];

}

//在线时间
-(void)BeganTimelevelTimer:(NSTimer *)timer_
{
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
-(void)ISbusy
{
    if (ISWork == NO) {
        WORKTYPE = @"繁忙";
    }else
    {
        WORKTYPE = @"空闲";
    }
    [self Changestate];
    
}
-(void)Changestate
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"change_state" andBodyOfRequestForKeyArr:@[@"state"] andValueArr:@[WORKTYPE] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                 [self presentViewController:LoginViewController animated:YES completion:nil];
             });
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
- (void)wageFirstkeyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
CGFloat    height = keyboardRect.size.height;


//    apportionView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, WIDTH-40 , 438)];

    CGRect Fvrame =   CGRectMake(20, 50-height+45*3, WIDTH-40 , 438);
    [apportionView setFrame: Fvrame];
    
}
//输入结束
- (void)wageFirstkeyboardWillHide:(NSNotification *)aNotification
{

    CGRect Fvrame =   CGRectMake(20, 50, WIDTH-40 , 438);

    [apportionView setFrame: Fvrame];
    
}

@end
