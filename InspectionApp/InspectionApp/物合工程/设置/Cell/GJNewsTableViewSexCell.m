//
//  GJNewsTableViewSexCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/24.
//  Copyright © 2016年 付智鹏. All rights reserved.
//
//#import <Foundation/Foundation.h>
//#import <CommonCrypto/CommonHMAC.h>
//#import <SystemConfiguration/SystemConfiguration.h>
//#import <netdb.h>
//#import <arpa/inet.h>
#import "GJNewsTableViewSexCell.h"

@implementation GJNewsTableViewSexCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLable];
    }
    return self;
}

-(void)createLable
{
    
    
    self.LeftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10,200, 20)];
    self.LeftLable.textColor = gycolor;
    self.LeftLable.font = [UIFont fontWithName:geshi size:15];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39, W - 30, 1)];
    lineLable.backgroundColor = gycoloers;
    self.MaleButton = [[UIButton alloc]initWithFrame:CGRectMake(W - 95, 5, 40, 30)];
    [self.MaleButton setTitle:@"男" forState:UIControlStateNormal];
    [self.MaleButton setTitleColor:NAVCOlOUR forState:UIControlStateNormal];
    [self.MaleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.MaleButton setBackgroundImage:[UIImage imagewithColor:NAVCOlOUR] forState:UIControlStateSelected];
    [self.MaleButton setBackgroundImage:[UIImage imagewithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.MaleButton.layer setMasksToBounds:YES];
    [self.MaleButton.layer setBorderWidth:0.5];//边框宽度
    self.MaleButton.layer.borderColor=gycoloers.CGColor;//边框颜色
    self.MaleButton.tag = 1000;
    [self.MaleButton addTarget:self action:@selector(sexButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.FemaleButton = [[UIButton alloc]initWithFrame:CGRectMake(W - 55, 5, 40, 30)];
    [self.FemaleButton setTitle:@"女" forState:UIControlStateNormal];
    [self.FemaleButton setTitleColor:NAVCOlOUR forState:UIControlStateNormal];
    [self.FemaleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.FemaleButton setBackgroundImage:[UIImage imagewithColor:NAVCOlOUR] forState:UIControlStateSelected];
    [self.FemaleButton setBackgroundImage:[UIImage imagewithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.FemaleButton.layer setMasksToBounds:YES];
    [self.FemaleButton.layer setBorderWidth:0.5];//边框宽度
    self.FemaleButton.layer.borderColor = gycoloers.CGColor;//边框颜色
    [self.FemaleButton addTarget:self action:@selector(sexButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.FemaleButton.tag = 1001;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *befordatastr = [userDefaults objectForKey:@"newsex"];
    NSString *LoginSex = [userDefaults objectForKey:@"sex"];
    if (befordatastr != nil) {
        nowSex = befordatastr;
    }
    else
    {
        nowSex = LoginSex;
    }
    if ([nowSex isEqualToString:@"男"]) {
        self.MaleButton.selected = YES;
        self.FemaleButton.selected = NO;
    }
    else
    {
        self.FemaleButton.selected = YES;
        self.MaleButton.selected = NO;
    }
    [self addSubview:self.MaleButton];
    [self addSubview:self.FemaleButton];
    [self addSubview:lineLable];
    [self addSubview:self.LeftLable];
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJNewsTableViewSexCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJNewsTableViewSexCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(void)sexButtonDidClicked:(UIButton *)sender
{
    GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
    if(!connect.connectedToNetwork)
    {
        [GJSVProgressHUD showErrorWithStatus:@"网络错误,修改失败"];
    }
    else
    {
        if (sender.tag == 1000)
        {
           self.MaleButton.selected = YES;
           self.FemaleButton.selected = NO;
           nowSex = @"男";
            [self getSexData];
       }
       else
       {
          self.FemaleButton.selected = YES;
          self.MaleButton.selected = NO;
          nowSex = @"女";
          [self getSexData];
       }
    }
}
-(void)getSexData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //传mfa返回access_token
    [GJSVProgressHUD showWithStatus:@"修改中"];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"save_userinfo" andBodyOfRequestForKeyArr:@[@"ovapp_data[sex]"] andValueArr:@[nowSex] andBlock:^(id dictionary) {
        NSLog(@"%@",dictionary);
        NSString *str = dictionary[@"return_data"];
        NSString *ico = dictionary[@"ico"];
        if ([ico isEqualToString:@"error"]) {
            [GJSVProgressHUD showErrorWithStatus:str];
        }else
        {
            [userDefaults setObject:dictionary[@"return_data"][@"sex"] forKey:@"newsex"];
            [userDefaults synchronize];
            [GJSVProgressHUD dismiss];
            [GJSVProgressHUD showSuccessWithStatus:@"修改成功"];
        }

    }];
//    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"user" Action:@"save_userinfo"];
//    //1,请求管理者
//    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSString *userid = [userDefaults objectForKey:@"user_id"];
//    NSString *session = [userDefaults objectForKey:@"session_key"];
//    //2,拼接请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"m"] = @"mlgj_api";
//    params[@"f"] = @"user";
//    params[@"a"] = @"save_userinfo";
//    params[@"app_id"] = appid;
//    params[@"app_secret"] = appsecret;
//    params[@"access_token"] = accesstoken;
//    params[@"user_id"] = userid;
//    params[@"session_key"] = session;
//    params[@"ovapp_data[sex]"] = nowSex;
//    //3,发送请求
//    [mgr POST:TOPurl parameters:params success:^(GJAFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"%@",responseObject);
//         NSString *str = responseObject[@"return_data"];
//         NSString *ico = responseObject[@"ico"];
//         if ([ico isEqualToString:@"error"]) {
//             [GJSVProgressHUD showErrorWithStatus:str];
//         }else
//         {
//             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//             [userDefaults setObject:responseObject[@"return_data"][@"sex"] forKey:@"newsex"];
//             [userDefaults synchronize];
//             [GJSVProgressHUD dismiss];
//             [GJSVProgressHUD showSuccessWithStatus:@"修改成功"];
//         }
//     } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
//         [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
//     }];
}











@end
