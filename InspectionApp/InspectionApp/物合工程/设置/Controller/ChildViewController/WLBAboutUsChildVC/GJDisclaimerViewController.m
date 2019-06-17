//
//  GJDisclaimerViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/6.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJDisclaimerViewController.h"

@interface GJDisclaimerViewController ()
{
    NSString *uploadUrl;
    NSString *textViewBackView;
}
@property(nonatomic,strong)UILabel *TitleLable;
@property(nonatomic,strong)UIAlertView *shengjialert;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation GJDisclaimerViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;

    self.tableview.backgroundColor = viewbackcolor;
    self.view = self.tableview;
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titlelable = [UILabel lableWithName:@"免责声明"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
    [self getdata];
}
-(void)getdata
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    textViewBackView = [userdefaults objectForKey:@"setupDisclaimerStr"];
    if (textViewBackView != nil) {
        [self createdUI];
    }else
    {
    [GJSVProgressHUD showWithStatus:@"加载中"];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"disclaimer" andBodyOfRequestForKeyArr:@[] andValueArr:@[] andBlock:^(id dictionary) {
        NSLog(@"%@",dictionary);
        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                [self presentViewController:LoginViewController animated:YES completion:nil];
            });
        }else if ([state isEqualToString:@"-1"])
        {
            [GJSVProgressHUD showErrorWithStatus:@"网络错误!"];
        }else if ([state isEqualToString:@"3"])
        {
            NSString *info = dictionary[@"upgrade_info"][@"info"];
            uploadUrl = dictionary[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];
        }
        else if([state isEqualToString:@"1"])
        {
            [userdefaults setObject:dictionary[@"return_data"] forKey:@"setupDisclaimerStr"];
            [userdefaults synchronize];
            textViewBackView = dictionary[@"return_data"];
            [self createdUI];
        }
        [GJSVProgressHUD dismiss];
    }];
    }
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
-(void)createdUI
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, W, H - 64)];
    [webView loadHTMLString:textViewBackView baseURL:nil];
    [self.tableview addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
