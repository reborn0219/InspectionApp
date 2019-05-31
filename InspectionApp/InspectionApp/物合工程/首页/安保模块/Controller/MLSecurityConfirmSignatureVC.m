//
//  MLSecurityConfirmSignatureVC.m
//  物联宝管家
//
//  Created by yang on 2019/1/16.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "MLSecurityConfirmSignatureVC.h"

#import "GJQueRenViewController.h"
#import "GJExecutedFishViewController.h"
#import "GJAllWageViewController.h"

@interface MLSecurityConfirmSignatureVC ()
{
    NSString *MattersaveToken;
    
}

@end

@implementation MLSecurityConfirmSignatureVC
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titlelable = [UILabel lableWithName:@"签名确认"];
    self.view.backgroundColor=viewbackcolor;
    self.navigationItem.titleView = titlelable;
    UIView *VV=[[UIView alloc]initWithFrame:CGRectMake(10, 64+ 10, WIDTH-20, 55)];
    VV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:VV];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,300, 20)];
    label.text=@"请将手机递给安保工作人员";
    label.textColor=RGBTEXTMAIN;
    label.font=[UIFont systemFontOfSize:17];
    label.textAlignment=NSTextAlignmentLeft;
    [VV addSubview:label];
    
    UILabel *qianming=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 200, 20)];
    qianming.text=@"签名";
    qianming.textColor=RGBTEXTMAIN;
    qianming.font=[UIFont systemFontOfSize:15];
    qianming.textAlignment=NSTextAlignmentLeft;
    [VV addSubview:qianming];
    
    UIView *sssV=[[UIView alloc]init];
    sssV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:sssV];
    
    
    UIImageView *NameImg=[[UIImageView alloc]init];
    
    if (_NameImg.size.width>WIDTH-40) {
        sssV.frame=CGRectMake(10, 55+64+10, WIDTH-20, (WIDTH-40)/(_NameImg.size.width/_NameImg.size.height )+20);
        NameImg.frame=CGRectMake(0,10, WIDTH-40,(WIDTH-40)/(_NameImg.size.width/_NameImg.size.height ) );
        
        
    }else{
        sssV.frame=CGRectMake(10, 55+64+10, WIDTH-20, _NameImg.size.height/7*4 +20);
        
        NameImg.frame=CGRectMake(0,10, _NameImg.size.width/7*4,_NameImg.size.height/7*4);
        
    }
    NameImg.centerX=sssV.centerX;
    
    
    [NameImg setImage:_NameImg];
    [sssV addSubview:NameImg];
    
    
    UIButton *lefBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    lefBtn.frame=CGRectMake(10, sssV.frame.origin.y+sssV.bounds.size.height+15, WIDTH/2-20, 40);
    lefBtn.backgroundColor=RGB(162, 162, 162);
    [lefBtn setTitle:@"重新签名" forState:UIControlStateNormal];
    [lefBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefBtn addTarget:self action:@selector(leftBB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lefBtn];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(WIDTH/2+10, sssV.frame.origin.y+sssV.bounds.size.height+15, WIDTH/2-20, 40);
    [rightBtn addTarget:self action:@selector(RightBB) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor=RGB(112, 19, 28);
    [rightBtn setTitle:@"确认无误" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:rightBtn];
    
    
    
}
-(void)leftBB
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 上传签名
-(void)RightBB
{
    [self save_token];
    
}
-(void)save_token
{
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"app_config" Action:@"get_save_token"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"app_config";
    params[@"a"] = @"get_save_token";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"save_id"] = userid;
    //3,发送请求
    [mgr POST:URL_LOCAL parameters:params success:^(GJAFHTTPRequestOperation *operation, id responseObject)
     {
         MattersaveToken = responseObject[@"return_data"][@"save_token"];
         [self imgWZ];
         
     } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
         [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
     }];
    
}
-(void)imgWZ
{
    NSData *imageData = UIImageJPEGRepresentation(_NameImg, 0.5);
    //获取头像数据
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"upload" Action:@"autograph"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:_WGDic];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    NSString *session = [userDefaults objectForKey:@"session_key"];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"upload";
    params[@"a"] = @"autograph";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"user_id"] = userid;
    params[@"session_key"] = session;
    
    NSLog(@"%@",params);
    [mgr POST:URL_LOCAL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"upload_file" fileName:fileName mimeType:@"image/png"];
    } success:^(GJAFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",responseObject);
        NSString *ddd=[NSString stringWithFormat:@"%@",responseObject[@"return_data"][@"file"]];
        [[NSUserDefaults standardUserDefaults] setObject:ddd forKey:@"QMWJ"];
        if ([[userDefaults objectForKey:@"isAnbao_autograph"] isEqualToString:@"F"]) {
            [self chuliGD];
        }else{
            [self WGGD];
        }
        
    } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----------%@",error);
        [GJSVProgressHUD dismiss];
        
    }];
    
}
-(void)WGGD
{
    
    //获取头像数据
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"security" Action:@"edit_finished"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:_WGDic];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    NSString *session = [userDefaults objectForKey:@"session_key"];
    
    params[@"autograph"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"QMWJ"];
    
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"edit_finished" andBodyOfRequestForKeyArr:[params allKeys] andValueArr:[params allValues] andBlock:^(id dictionary)
     {
         NSLog(@"%@",[params allKeys]);
         NSLog(@"%@",[params allValues]);
         NSLog(@"%@",dictionary);
         NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
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
         }else if ([state isEqualToString:@"1"])
         {
             NSLog(@"%@",params);
             NSLog(@"%@",dictionary);
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             
             for (UIViewController * vc in self.navigationController.viewControllers) {
                 if ([vc isKindOfClass:[GJAllWageViewController class]]) {
                     [self.navigationController popToViewController:vc animated:YES];
                     
                 }
             }

             [[NSNotificationCenter defaultCenter]postNotificationName:@"ExecutedfishWage" object:nil];
             
         }
     }];
    
    
}

-(void)chuliGD
{
    
    //获取头像数据
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"security" Action:@"receive"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    params[@"repair_id"]=_repair_id;
    params[@"autograph"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"QMWJ"];
    
    
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"receive" andBodyOfRequestForKeyArr:[params allKeys] andValueArr:[params allValues] andBlock:^(id dictionary)
     {
         NSLog(@"%@",[params allKeys]);
         NSLog(@"%@",[params allValues]);
         NSLog(@"%@",dictionary);
         NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
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
         }else if ([state isEqualToString:@"1"])
         {
             
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             [self.navigationController popToRootViewControllerAnimated:YES];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
             
             
             //                      创建fmdb
             GJYTKKeyValueStore *store = [[GJYTKKeyValueStore alloc] initDBWithName:@"repaird.db"];
             NSString *tableName = repaird_table;
             // 创建名为user_table的表，如果已存在，则忽略该操作
             [store createTableWithName:tableName];
             
             //             添加fmdb
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             // 设置时间格式
             formatter.dateFormat = @"yyyy-MM-dd HH:mm";
             NSString *start_time = [formatter stringFromDate:[NSDate date]];
             
             NSString *key =_repair_id;
             NSDictionary *user = @{@"id": _repair_id, Start_Time: start_time};
             [store putObject:user withId:key intoTable:tableName];
             
         }
     }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

