//
//  GJChangePassViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJChangePassViewController.h"
#import "GJLoginViewController.h"
#import "GJViewController.h"
#import "GJSliderViewController.h"
@interface GJChangePassViewController()<UITextFieldDelegate,LoginAndColseDelegates,UIAlertViewDelegate>
{
    NSString *secondNum;//接受登录界面传来的值
    NSString *uploadUrl;
}
@end

@implementation GJChangePassViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

-(void)viewDidLoad
{
    self.view.backgroundColor = viewbackcolor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self createdTabbar];
    [self createdUI];
}
-(void)createdTabbar
{
    //导航栏标题
    UILabel *titlelable = [UILabel lableWithName:@"修改密码"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
    //导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
    //右侧导航栏按钮
    UIButton *rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 40, 30)];
    alable.text = @"确定";
    alable.font = [UIFont fontWithName:geshi size:20];
    alable.textColor = [UIColor whiteColor];
    [rightbutton addTarget:self action:@selector(determine) forControlEvents:UIControlEventTouchUpInside];
    [rightbutton addSubview:alable];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)createdUI
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    backView.backgroundColor = [UIColor whiteColor];
    self.oldPassword = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, WIDTH - 30, 40)];
    self.oldPassword.placeholder = @"请输入旧密码";
    [self.oldPassword setSecureTextEntry:YES];//密码设置为暗文
    
    //显示一键删除小按钮
    self.oldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.oldPassword.textColor = gycoloer;
    self.newsPassword = [[UITextField alloc]initWithFrame:CGRectMake(15, 40, WIDTH - 30, 40)];
    self.newsPassword.placeholder = @"请输入新密码";
    [self.newsPassword setSecureTextEntry:YES];
    self.newsPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.newsPassword.textColor = gycoloer;
    self.newsPasswordAgen = [[UITextField alloc]initWithFrame:CGRectMake(15, 80, WIDTH - 30, 40)];
    self.newsPasswordAgen.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.newsPasswordAgen.placeholder = @"请确认新密码";
    [self.newsPasswordAgen setSecureTextEntry:YES];//密码设置为暗文

    self.newsPasswordAgen.textColor = gycoloer;
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, WIDTH - 30, 1)];
    alable.backgroundColor = gycoloers;
    [self.oldPassword addSubview:alable];
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, WIDTH - 30, 1)];
    blable.backgroundColor = gycoloers;
    [self.newsPassword addSubview:blable];
    UILabel *clable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, WIDTH - 30, 1)];
    clable.backgroundColor = gycoloers;
    [self.oldPassword addSubview:clable];
    [backView addSubview:self.oldPassword];
    [backView addSubview:self.newsPassword];
    [backView addSubview:self.newsPasswordAgen];
    [self.view addSubview:backView];
}

//右侧导航栏确定按钮点击事件
-(void)determine
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *password = [userDefaults objectForKey:@"newpassward"];
    NSLog(@"%@",password);
    NSLog(@"%@",self.oldPassword.text);
    if (![self.oldPassword.text isEqualToString: password]) {
        [GJSVProgressHUD showErrorWithStatus:@"旧密码错误"];
    }else{
        if(![self.newsPassword.text isEqualToString :self.newsPasswordAgen.text ])
        {
            [GJSVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        }
        
        else if((self.newsPassword.text.length < 6)||(self.newsPasswordAgen.text.length < 6))
        {
            [GJSVProgressHUD showErrorWithStatus:@"密码至少为6位"];
        }
        else
        {
            [self Dataparsing];
        }
    }
}
//修改密码请求数据
-(void)Dataparsing
{
    NSString *MD5Newpassword = [NSString md5HexDigest:self.newsPassword.text];
    NSString *MD5AgenPassword = [NSString md5HexDigest:self.newsPasswordAgen.text];
    NSString *MD5OldPassword = [NSString md5HexDigest:self.oldPassword.text];
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"user" Action:@"change_password"];
    [GJSVProgressHUD showWithStatus:@"修改中"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    NSString *session = [userDefaults objectForKey:@"session_key"];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"user";
    params[@"a"] = @"change_password";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"user_id"] = userid;
    params[@"session_key"] = session;
    params[@"password_old"] = MD5OldPassword;
    params[@"password_new"] = MD5Newpassword;
    params[@"password_new_confirm"] = MD5AgenPassword;
    //3,发送请求
    [mgr POST:URL_LOCAL parameters:params success:^(GJAFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *state = [NSString stringWithFormat:@"%@",responseObject[@"state"]];
        
        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                [self presentViewController:LoginViewController animated:YES completion:nil];
            });
        }else if ([state isEqualToString:@"-1"])
        {
            [GJSVProgressHUD showErrorWithStatus:@"网络错误，请检查您的网络设置"];
        }else if ([state isEqualToString:@"3"])
        {
            NSString *info = responseObject[@"upgrade_info"][@"info"];
            uploadUrl = responseObject[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];

        }else if ([state isEqualToString:@"1"])
        {
        [GJSVProgressHUD dismiss];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.newsPassword.text forKey:@"newpassward"];
        [userDefaults synchronize];
        [GJSVProgressHUD showSuccessWithStatus:@"密码已修改,请重新登录!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        GJLoginViewController *LoginVC = [[GJLoginViewController alloc]init];
        LoginVC.delegates = self;
        [self presentViewController:LoginVC animated:YES completion:nil];
        });
        }else
        {
            [GJSVProgressHUD showErrorWithStatus:responseObject[@"return_data"]];
        }
    } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
        [GJSVProgressHUD dismiss];
        [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
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
//登录代理方法
-(void)LoginAndColse:(NSString *)number
{
    secondNum = number;
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([secondNum isEqualToString:@"1"])
    {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:@"1" forKey:@"Requst"];
        GJViewController * tabbar = [[GJViewController alloc]init];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changHomeVC" object:nil];
        [[GJSliderViewController sharedSliderController]showContentControllerWithModel:tabbar];
    }
}


@end
