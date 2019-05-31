//
//  GJSetUpController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJSetUpController.h"
#import "GJSetupView.h"
#import "GJChangePassViewController.h"
#import "GJAboutUsViewcontroller.h"
#import "GJLoginViewController.h"
#import "GJSliderViewController.h"
#import "GJViewController.h"
@interface GJSetUpController()<ChangePassDelegate,LoginAndColseDelegates>
{
    NSString *receive;
    NSString *secondNum;//接受登录界面传来的值
    NSString *uploadUrl;
}
@property(nonatomic,strong)GJSetupView *setupView;
@property(nonatomic,strong)GJLoginViewController *LoginVC;
@property(nonatomic,strong)UIAlertView *shengjialert;
@end

@implementation GJSetUpController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
-(void)viewDidLoad
{
    UILabel *titlelable = [UILabel lableWithName:@"设置"];
    self.navigationItem.titleView = titlelable;
    self.setupView = [[GJSetupView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.setupView;
    self.setupView.delegates = self;
}

-(void)changePassDidClicked:(UIButton *)sender
{
    GJChangePassViewController *changeVC = [[GJChangePassViewController alloc]init];
    [self.navigationController pushViewController:changeVC animated:YES];
}

-(void)aboutViewDidClicked:(UIButton *)sender
{
    [self getAboutUsData];
   
}
-(void)closeAppClicked
{
#pragma mark - 聊天退出
//    网易云退出
    
    GJLoginViewController *LoginVC = [[GJLoginViewController alloc]init];
    LoginVC.tongzhi = @"clearPassword";
    LoginVC.delegates = self;
    [self presentViewController:LoginVC animated:YES completion:nil];
}

-(void)backhomeDidClicked
{
    if ([self.tongzhi isEqualToString:@"push"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //切换控制器
        GJViewController * tabbar = [[GJViewController alloc]init];
        [[GJSliderViewController sharedSliderController]showContentControllerWithModel:tabbar];
        [[GJSliderViewController sharedSliderController]showLeftViewController];
    }
}
//登录代理方法
-(void)LoginAndColse:(NSString *)number
{
    secondNum = number;
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([secondNum isEqualToString:@"1"])
    {
        GJViewController * tabbar = [[GJViewController alloc]init];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changHomeVC" object:nil];
        [[GJSliderViewController sharedSliderController]showContentControllerWithModel:tabbar];
    }
}


-(void)getAboutUsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [NSDictionary dictionary];
    dict = [userDefaults objectForKey:@"aboutUsData"];
    if (dict != nil) {
        GJAboutUsViewcontroller *aboutVC = [[GJAboutUsViewcontroller alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];

    }else
    {
    [GJSVProgressHUD showWithStatus:@"加载中"];
//    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
//    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"about" andBodyOfRequestForKeyArr:@[] andValueArr:@[] andBlock:^(id dictionary) {
//        NSLog(@"%@",dictionary);
//        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
//        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
//            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
//                [self presentViewController:LoginViewController animated:YES completion:nil];
//            });
//        }else if ([state isEqualToString:@"-1"])
//        {
//            [GJSVProgressHUD showErrorWithStatus:@"网络错误!"];
//        }else if ([state isEqualToString:@"3"])
//        {
//            NSString *info = dictionary[@"upgrade_info"][@"info"];
//            uploadUrl = dictionary[@"upgrade_info"][@"url"];
//            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
//            self.shengjialert.delegate = self;
//            [self.shengjialert show];
//        }
//        else if([state isEqualToString:@"1"])
//        {
//            [userDefaults setObject:dictionary[@"return_data"] forKey:@"aboutUsData"];
//            [userDefaults synchronize];
//            GJAboutUsViewcontroller *aboutVC = [[GJAboutUsViewcontroller alloc]init];
//            [self.navigationController pushViewController:aboutVC animated:YES];
//        }
//        [GJSVProgressHUD dismiss];
//    }];
    }
    
}

@end
