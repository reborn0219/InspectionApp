//
//  GJNewsChildViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJNewsChildViewController.h"
#import "GJLoginViewController.h"


@interface GJNewsChildViewController ()<UIAlertViewDelegate>
{
    NSString *namestr;
    NSString *typename;
    NSString *uploadUrl;
}
@end

@implementation GJNewsChildViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *titlelable = [UILabel lableWithName:self.titlelables];
    self.navigationItem.titleView = titlelable;
//    titlelable.text = self.titlelables;
    self.tabBarController.tabBar.translucent = NO;
    UIButton *rightbutton = [UIButton rightbuttonwithtitleName:@"确定" target:self action:@selector(determineButtonDidClicked)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.NewsChiledView = [[GJNewsChildView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.NewsChiledView;
    self.NewsChiledView.textField.text = self.rightTitle;
}
-(void)determineButtonDidClicked
{
    
    
    if ([self.titlelables isEqualToString:@"姓名"]) {
        namestr = self.NewsChiledView.textField.text;
        typename = @"ovapp_data[ture_name]";
    }else
    {
        namestr = self.NewsChiledView.textField.text;
        typename = @"ovapp_data[nick_name]";
    }
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"save_userinfo" andBodyOfRequestForKeyArr:@[typename] andValueArr:@[namestr] andBlock:^(id dictionary) {
        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
        
        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                [self presentViewController:LoginViewController animated:YES completion:nil];
            });
        }else if ([state isEqualToString:@"-1"])
        {
            [GJSVProgressHUD showErrorWithStatus:@"网络错误，修改失败"];
        }else if ([state isEqualToString:@"3"])
        {
            NSString *info = dictionary[@"upgrade_info"][@"info"];
            uploadUrl = dictionary[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];
        }
        else
        {
            if ([self.titlelables isEqualToString:@"姓名"])
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dictionary[@"return_data"][@"ture_name"]forKey:@"ture_name"];
                [userDefaults synchronize];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dictionary[@"return_data"][@"nick_name"]forKey:@"nick_name"];
                [userDefaults synchronize];
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            [GJSVProgressHUD showSuccessWithStatus:@"修改成功"];
        }
        
    }];

}
//升级弹窗
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.shengjialert removeFromSuperview];
    }else
    {
        //升级
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:uploadUrl]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
