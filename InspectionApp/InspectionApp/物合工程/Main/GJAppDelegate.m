//
//  GJAppDelegate.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJAppDelegate.h"
#import "GJViewController.h"

#import "XSDLocationTools.h"
#import "GJLoginViewController.h"
#import "GJNavigationController.h"
#import "GJSliderViewController.h"
#import "GJQHMainGestureRecognizerViewController.h"
#import "GJLoginViewController.h"
#import "JPUSHService.h"
//#import "FZPJPushHelper.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <UserNotifications/UserNotifications.h>
#import "GJWebViewController.h"
#import "PSHomePageViewController.h"
#import "GJHomePageViewController.h"
#import "WHZLLoginViewController.h"
#import "PSMyViewController.h"
@interface GJAppDelegate ()<UIAlertViewDelegate,JPUSHRegisterDelegate>
{
    NSString *phoneNumber;
    
    UIScrollView *scr;
    UIButton *_countBtn;
    NSTimer *countTimer;
    
    int _count;
    NSArray *arr;
    BOOL isStop;
    
}

@property(nonatomic,strong)NSString *SPID;
@property(nonatomic,strong)NSString *isfront;//前台还是后台推送
@end

static int const showtime = 7;

@implementation GJAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
 
    NSNumber * is_login =  [[NSUserDefaults standardUserDefaults]objectForKey:@"IS_LOGIN"];
    if (is_login.boolValue) {
        [[XSDLocationTools shareInstance]startLocationService];
        [self startChatTimer];
        PSHomePageViewController *homeVC = [[PSHomePageViewController alloc]initWithNibName:@"PSHomePageViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
        self.window.rootViewController = nav;
        [self.window makeKeyWindow];
    }else{
     
//        WHZLLoginViewController *loginVC = [[WHZLLoginViewController alloc]initWithNibName:@"WHZLLoginViewController" bundle:[NSBundle mainBundle]];
        
        UITabBarController *loginVC = [[UITabBarController alloc]init];

        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginVC;
        [self.window makeKeyWindow];
    }
    //设置svp格式
    [GJSVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [GJSVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [GJSVProgressHUD setForegroundColor:[UIColor blackColor]];
    //设置弹出键盘格式
    GJIQKeyboardManager *manager = [GJIQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    [self registerJPush:launchOptions];//极光注册
    //获取自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getuserPhoneNumbers) name:@"getuserPhoneNumber" object:nil];
    //高德地图
    [AMapServices sharedServices].apiKey =Map_Key;
    return YES;
    
}
#pragma mark - 跳转页面
- (void)handleSingleTap:(UIGestureRecognizer *)sender
{
    
    [self yincang];
    NSString *str=arr[sender.view.tag][@"ad_url"];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"adv_url"];
    
    GJViewController *tabbar = (GJViewController *)self.window.rootViewController;
    GJWebViewController *web=[[GJWebViewController alloc]init];
    
    
    
    UINavigationController *nn= tabbar.viewControllers[0];
    [nn pushViewController:web animated:YES];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoad" object:nil userInfo:nil];
    
    NSLog(@"%@",arr[sender.view.tag]);
}
- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self yincang];
    }
}

- (void)show
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown
{
    __block int timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self yincang];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)yincang{
    [countTimer invalidate];
    countTimer = nil;
    
    [scr removeFromSuperview];
    [_countBtn removeFromSuperview];
    
}

- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

-(void)registerJPush:(NSDictionary *)launchOptions//极光注册
{
    static BOOL isproduction=NO;//18aa8a89db38b27300cf08b9
    [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                      UIRemoteNotificationTypeSound |
                                                      UIRemoteNotificationTypeAlert)
                                          categories:nil];
    
    
    [JPUSHService setupWithOption:launchOptions appKey:@"2407ef30f3b79dc5c0deed31" channel:@"" apsForProduction:isproduction];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    //    [defaultCenter addObserver:self
    //                      selector:@selector(networkDidRegister:)
    //                          name:kJPFNetworkDidLoginNotification
    //                        object:nil];
    //
    //    [defaultCenter addObserver:self
    //                      selector:@selector(receiveMessage:)
    //                          name:kJPFNetworkDidReceiveMessageNotification
    //                        object:nil];
    //
    //    [defaultCenter addObserver:self selector:@selector(didRegisterAction:) name:kJPFNetworkDidRegisterNotification object:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
}


#pragma mark - 禁止ipad旋转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)nowWindow {
 
    
    return UIInterfaceOrientationMaskPortrait;
    
}



- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    
    NSDictionary *userInfo=[notification userInfo];
    NSLog(@"%@",userInfo);
    NSLog(@"%@",[self logDic:userInfo]);
    
    
    
    
    //    if ([[[NSUserDefaults standardUserDefaults ] objectForKey:@"role"] isEqualToString:@"normal"])
    //    {
    //
    //        [ [NSUserDefaults standardUserDefaults ] setObject:@"2212" forKey:@"PushMatterID"];
    //        [[NSUserDefaults standardUserDefaults ] synchronize];
    //        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowSingle" object:nil];
    //
    //    }else
    //    {
    //
    //        [[NSUserDefaults standardUserDefaults ] setObject:@"2212" forKey:@"PushMatterID"];
    //        [[NSUserDefaults standardUserDefaults ] synchronize];
    //        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowAdminSingle" object:nil];
    //
    //    }
    
    
}

-(void)getuserPhoneNumbers
{
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *tags = [userdefaults objectForKey:@"jpush_tag"];
    NSString *code = [NSString stringWithFormat:@"%@",[userdefaults objectForKey:@"pro_code"]];
    NSLog(@"%@",code);
    [JPUSHService setTags:[NSSet setWithObjects:tags, nil] alias:code callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    //    pro126362
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
    /*
     tags: {(
     pro126362
     )},
     alias: 10681
     */
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService resetBadge];
    [self startChatTimer];
    
}
//单推
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""] stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    
    return;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"userInfo___%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
    
}
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    //    iOS7及以上系统，收到通知
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知2222:%@", [self logDic:userInfo]);
    if([UIApplication sharedApplication].applicationState==UIApplicationStateActive)
    {//前台运行时，收到推送的通知会弹出alertview提醒
#pragma mark - iOS7 前端收推送
        NSLog(@"aaa");
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[self logDic:userInfo] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //        [alert show];         3128
        //        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"3136",@"bb", nil];
        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"GJgoods" object:self userInfo:dic];
        //
        
        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CloseTheVoiceWage" object:nil];
        if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"])
        {
            [userdefaults setObject:wageID forKey:@"PushMatterID"];
            [userdefaults synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowSingle" object:nil];
            
        }else
        {
            [userdefaults setObject:wageID forKey:@"PushMatterID"];
            [userdefaults synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowAdminSingle" object:nil];
            
        }
    }
    else {
#pragma mark - ios 7后台收推送
        //后台运行的时候,点击消息发送一个通知,跳转到应到的界面
        NSLog(@"bbbb");
        
        NSString *content =[userInfo[@"aps"] valueForKey:@"alert"];
        
        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        _SPID=wageID;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"role"] isEqualToString:@"normal"])
        {
            
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_SPID,@"bb", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GRgoods" object:self userInfo:dic];
            
            
        }else{
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_SPID,@"bb", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GJgoods" object:self userInfo:dic];
            
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - iOS10前台收推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到推送:%@", [self logDic:userInfo]);
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[self logDic:userInfo] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //        [alert show];
        //
        
        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        //朱滴20181019系统消息
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge 数量
        NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CloseTheVoiceWage" object:nil];
        if ([[userdefaults objectForKey:@"role"] isEqualToString:@"normal"])
        {
            [userdefaults setObject:wageID forKey:@"PushMatterID"];
            [userdefaults synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowSingle" object:nil];
            
        }else
        {
            [userdefaults setObject:wageID forKey:@"PushMatterID"];
            [userdefaults synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowAdminSingle" object:nil];
            
        }
        //朱滴20181019系统消息
        //        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        //        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        //        [userdefaults setObject:wageID forKey:@"PushMatterID"];
        //        [userdefaults synchronize];
        //        _isfront = @"1";
        //        if (userInfo[@"_j_business"]&&[userInfo[@"_j_business"] intValue]==1){
        //            _tabbar.selectedIndex=3;
        //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您有新的系统消息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alert.tag=55555;
        //            [alert show];
        //            NSLog(@"自定义message:%@",userInfo);
        //        }else{
        //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您有新的订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alert.tag = 55555;
        //            [alert show];
        //            NSLog(@"自定义message:%@",userInfo);
        //
        //        }
    }else {
        NSLog(@"vvvv");
        
    }
    
    //    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
    //
    //        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    //        completionHandler(UNNotificationPresentationOptionSound);
    //    }else{
    //
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    //    }
}

#pragma  mark - ios10后台推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 后台收到推送:%@", [self logDic:userInfo]);
        //        [rootViewController addNotificationCount];
        
        //        NSString *content =[NSString stringWithFormat:@"%@",[userInfo[@"aps"] valueForKey:@"alert"]];
        //朱滴20181019系统消息
        NSDictionary *aps = [userInfo valueForKey:@"aps"];
        NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge 数量
        NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        _SPID=wageID;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"role"] isEqualToString:@"normal"])
        {
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_SPID,@"bb", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GRgoods" object:self userInfo:dic];
            
        }else{
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:_SPID,@"bb", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"GJgoods" object:self userInfo:dic];
            
        }
        //        //朱滴20181019系统消息
        //        NSString *wageID = [NSString stringWithFormat:@"%@",userInfo[@"id"]];
        //        _SPID=wageID;
        //        _isfront = @"2";
        //        if (userInfo[@"_j_business"]&&[userInfo[@"_j_business"] intValue]==1) {
        //            _tabbar.selectedIndex=3;
        //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您有新的系统消息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alert.tag=55555;
        //            [alert show];
        //            NSLog(@"自定义message:%@",userInfo);
        //            NSDictionary *aps = [userInfo valueForKey:@"aps"];
        //            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
        //            NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge 数量
        //            NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
        //
        //        }else{
        //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您有新的订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alert.tag = 55555;
        //            [alert show];
        //            NSLog(@"自定义message:%@",userInfo);
        //        }
        
        
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);  // 系统要求执行这个方法
}

#pragma mark - misc
- (void)registerAPNs
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    
    return;
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService resetBadge];
    return;
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
    
    
}
-(NSTimer *)chatTimer{
    if (!_chatTimer) {
        _chatTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(chatListenAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_chatTimer forMode:NSRunLoopCommonModes];
    }
    return _chatTimer;
}
-(void)startChatTimer{
    isStop = NO;
    [self.chatTimer setFireDate:[NSDate distantPast]];
}
-(void)stopChatTimer{
    isStop = YES;
    [self.chatTimer setFireDate:[NSDate distantFuture]];
}
-(void)chatListenAction{
    if (isStop == YES) {
        return;
    }
    MJWeakSelf
    [PatrolHttpRequest hasCall:@{@"id":[UserManager menber_id]} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode==SucceedCode) {
            NSString * isCall = data;
            NSLog(@"轮询结果：----%@",isCall);
            if (isCall.intValue!=0) {
                [weakSelf stopChatTimer];
                VideoChatViewController * chatVC = [[VideoChatViewController alloc]init];
                chatVC.roomNo = isCall;
                [[PPViewTool getCurrentViewController] presentViewController:chatVC animated:YES completion:nil];
            }
        }else{
            
        }
    }];
}
@end

