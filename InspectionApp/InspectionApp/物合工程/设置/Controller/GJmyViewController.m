//
//  GJmyViewController.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJmyViewController.h"
#import "GJSetUpController.h"
#import "GJnewsViewController.h"
#import "GJLoginViewController.h"
#import "GJUIScrollView+APParallaxHeader.h"
#import "GJCommunityModel.h"

#define FZcovertag 100
#define FZLeftMenuW 150
#define FZLeftMenuH 500
#define FZLeftMenuY 60

@interface GJmyViewController ()<MyViewDelegate>
{
    //    NSString *changeImageUrl;
    NSString *topImageUrl;
    NSString *changeTopurl;
    NSString *ture_name;
    NSString *nick_name;
    int Tags;
    UIView *stateView;
    BOOL ISOpen;
    UIButton *stateButton;
    UIImageView *stateImageView;
    UILabel *stateLable;
    NSString *state;
    NSString *repairStr;
    NSString *feedBackStr;
    NSString *complaintStr;
    NSArray *nameArrays;
    NSArray *DataNameArray;
    NSArray *imageNameArrays;
    NSString *USERTYPE;
    
    NSString *na;
    
    NSString *SSS;
    
    UIImageView *headerView;
    
    UIImageView *avaImg;
    UILabel  *nameLab;
}
@end

@implementation GJmyViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    ture_name = [userDefaults objectForKey:@"ture_name"];
//    NSString *topurl = [userDefaults objectForKey:@"app_avatar_url"];
    NSString *imageurl = [userDefaults objectForKey:@"avatar"];
    changeTopurl = [userDefaults objectForKey:@"HeadportraitImage"];
    nameLab.text = [userDefaults objectForKey:@"ture_name"];
    topImageUrl = [NSString stringWithFormat:@"%@",imageurl];
    [avaImg sd_setImageWithURL:[NSURL URLWithString:topImageUrl] placeholderImage:[UIImage imageNamed:@"100x100"]];
    [self.myview.tableView reloadData];

    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    if (nameArrays == nil ||[userdefault objectForKey:@"statename"] == nil) {
        stateLable.text = @"空   闲";
        stateImageView.image = [UIImage imageNamed:@"成功"];
    }else
    {
        stateLable.text = [userdefault objectForKey:@"statename"];
        stateImageView.image = [UIImage imageNamed:[userdefault objectForKey:@"stateImagename"]];
    }
    if ([stateLable.text isEqualToString:@"繁   忙"])
    {
        stateButton.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    else
    {
        stateButton.layer.borderColor = FZColor(110,185,43).CGColor;
    }

    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.myview = [[GJMyView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myview;
    self.myview.delegates = self;
    self.myview.tableView.delegate = self;
    self.myview.tableView.dataSource = self;
    ISOpen = NO;
    self.myview.backgroundColor = viewbackcolor;
    
    headerView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dj_sp22"]];
    [headerView setFrame:CGRectMake(0, 0, W, 200)];
    headerView.userInteractionEnabled=YES;
    [headerView setContentMode:UIViewContentModeScaleAspectFill];
    [self.myview.tableView addParallaxWithView:headerView andHeight:200];
    self.myview.backgroundColor=[UIColor yellowColor];
    if (@available(iOS 11.0, *)){
        self.myview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    avaImg=[[UIImageView alloc]init];
    if (IS_iPhoneX) {
        avaImg.frame=CGRectMake((W-70)/2, 50, 70, 70);
        
    }else{
        avaImg.frame=CGRectMake((W-70)/2, 30, 70, 70);
        
    }
    
    ;
    avaImg.layer.cornerRadius=35;
    NSString *imageurl = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];

    
    avaImg.layer.masksToBounds=YES;
    [headerView addSubview:avaImg];
    
    
    UIButton *avaV=[[UIButton alloc]initWithFrame:CGRectMake((W-70)/2, 40, 70, 70)];
    avaV.layer.cornerRadius=35;
    [avaV addTarget:self action:@selector(imageTap) forControlEvents:UIControlEventTouchUpInside];
    avaV.layer.masksToBounds=YES;
    [headerView addSubview:avaV];
    
    
    [avaImg sd_setImageWithURL:[NSURL URLWithString:imageurl]placeholderImage:[UIImage imageNamed:@"100x100"]];
    
    if (IS_iPhoneX) {
        nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 40+70+10, W, 30)];
        
    }else{
        nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 40+70, W, 30)];
        
        
    }    nameLab.textColor=[UIColor whiteColor];
    nick_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"ture_name"];

    nameLab.textAlignment=NSTextAlignmentCenter;
    nameLab.font=[UIFont systemFontOfSize:14];
    [headerView addSubview:nameLab];
    
    nameLab.text = nick_name;
    
    
    //设置标题
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    NSString *property_full_name;
    if ([model.property_full_name isEqualToString:@""]) {
        property_full_name = @"我的";
    }else{
        property_full_name = model.property_full_name;
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:geshi size:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = property_full_name;
    self.navigationItem.titleView = titleLabel;
    
    if(H == 480)
    {
        self.myview.tableView.contentSize = CGSizeMake(W, H);
    }
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.myview.tableView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadNumData];
        // 结束刷新
        [self.myview.tableView.mj_header endRefreshing];
    }];
    // 马上进入刷新状态
    [self.myview.tableView.mj_header beginRefreshing];
    stateButton = [[UIButton alloc]init];
    if (IS_iPhoneX) {
        stateButton.frame = CGRectMake((W-80)/2, 160, 80, 25);
        
    }else{
        stateButton.frame = CGRectMake((W-80)/2, 140, 80, 25);
        
        
    }
    [stateButton addTarget:self action:@selector(stateButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    stateButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    stateButton.layer.borderWidth = 0.5;
    stateButton.layer.borderColor = NAVCOlOUR.CGColor;
    stateButton.layer.cornerRadius = 3.0;
    stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
    stateLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 50, 15)];
    stateLable.font = [UIFont fontWithName:geshi size:15];
    stateLable.textColor = gycolor;
    [stateButton addSubview:stateLable];
    [stateButton addSubview:stateImageView];
    //导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
    
    
    //左侧导航栏按钮
    UIImageView *leftbutton = [[UIImageView alloc]init];
    leftbutton.backgroundColor = NAVCOlOUR;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItems = nil;
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStyle:) name:@"BoolOF" object:nil];

    
    NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
    if (nameArrays == nil ||[userdefault objectForKey:@"statename"] == nil) {
        stateLable.text = @"空   闲";
        stateImageView.image = [UIImage imageNamed:@"成功"];
    }else
    {
        stateLable.text = [userdefault objectForKey:@"statename"];
        stateImageView.image = [UIImage imageNamed:[userdefault objectForKey:@"stateImagename"]];
    }
    if ([stateLable.text isEqualToString:@"繁   忙"])
    {
        stateButton.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    else
    {
        stateButton.layer.borderColor = FZColor(110,185,43).CGColor;
    }
    [headerView addSubview:stateButton];
    
    
}
#pragma mark - 收到推送方法
-(void)changeStyle:(NSNotification *)noti
{
    NSDictionary  *dic = [noti userInfo];
    NSString *info = [dic objectForKey:@"ONOFF"];
    NSLog(@"接收 userInfo传递的消息：%@",info);
    USERTYPE = info;
    SSS=info;
    na=@"1";
    [self Changestate];
}
#pragma mark cell 的点击事件

-(void)imageTap
{
    GJnewsViewController *NewsVC = [[GJnewsViewController alloc]init];
    
        NewsVC.tongzhi = @"push";
    
    [self.navigationController pushViewController:NewsVC animated:YES];

}

//协议实现点击事件(设置)
-(void)buttonDidClicked:(UIButton *)sender
{
    GJSetUpController *setVC = [[GJSetUpController alloc]init];
    setVC.tongzhi = @"push";
    [self.navigationController pushViewController:setVC animated:YES];
}
-(void)stateButtonDidClicked
{
    if (ISOpen == NO) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIButton *backbutton = [[UIButton alloc]initWithFrame:window.frame];
        backbutton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        stateView = [[UIView alloc]initWithFrame:CGRectMake((W-90)/2, 170, 90, 40)];
        stateView.backgroundColor = viewbackcolor;
        stateView.layer.borderColor = gycoloers.CGColor;
        stateView.layer.borderWidth = 0.5;
        stateView.layer.cornerRadius = 3.0;
        stateView.backgroundColor = [UIColor whiteColor];
        nameArrays = [NSArray array];
        DataNameArray = [NSArray array];
        imageNameArrays = [NSArray array];
        if ([stateLable.text isEqualToString:@"繁   忙"]) {
            nameArrays = @[@"空   闲"];
            DataNameArray = @[@"空闲"];
            imageNameArrays = @[@"成功"];
        }else if ([stateLable.text isEqualToString:@"空   闲"]) {
            nameArrays = @[@"繁   忙"];
            DataNameArray = @[@"繁忙"];
            
            imageNameArrays = @[@"-2"];
        }
        for (int i = 0; i < 1; i ++) {
            UIButton *freeButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 10 + i * 35, 80, 25)];
            freeButton.tag = 1000 + i;
            [freeButton addTarget:self action:@selector(freeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            freeButton.backgroundColor = [UIColor clearColor];
            freeButton.layer.borderWidth = 0.5;
            freeButton.layer.borderColor = NAVCOlOUR.CGColor;
            freeButton.layer.cornerRadius = 5.0;
            UIImageView *freeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
            UILabel *freeLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 50, 15)];
            freeLable.font = [UIFont fontWithName:geshi size:15];
            freeLable.textColor = gycolor;
            freeLable.text = nameArrays[i];
            freeImageView.image = [UIImage imageNamed:imageNameArrays[i]];
            [freeButton addSubview:freeLable];
            [freeButton addSubview:freeImageView];
            [stateView addSubview:freeButton];
        }
        [self.myview addSubview:stateView];
        ISOpen = YES;
    }else
    {
        ISOpen = NO;
        [stateView removeFromSuperview];
    }
}
#pragma mark - 点击切换按钮
-(void)freeButtonDidClicked:(UIButton *)sender
{
    ISOpen = NO;
    Tags = sender.tag;
    USERTYPE = DataNameArray[sender.tag - 1000];
    na=@"0";
    [self Changestate];
}
-(void)reloadNumData
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *property_ids =model.property_id;
    NSString *communitID = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"home" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[property_ids,communitID] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary[@"return_data"]);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                 [self presentViewController:LoginViewController animated:YES completion:nil];
             });
         }else if ([state isEqualToString:@"5"]) {
//             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
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
             complaintStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"complaint_nums"]];
             feedBackStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"feedback_nums"]];
             repairStr = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"repair_nums"]];
             [self.myview.tableView reloadData];
             
         }
     }];
}



-(void)Changestate
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"change_state" andBodyOfRequestForKeyArr:@[@"state"] andValueArr:@[USERTYPE] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary[@"return_data"]);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                 [self presentViewController:LoginViewController animated:YES completion:nil];
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
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             [stateView removeFromSuperview];
         }else if ([state isEqualToString:@"1"])
         {

             if ([na isEqualToString:@"1"]) {
                 if ([SSS isEqualToString:@"空闲"]) {
                     NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
                     [userdefaults setObject:@"空   闲" forKey:@"statename"];
                     [userdefaults setObject:@"成功" forKey:@"stateImagename"];
                     [userdefaults synchronize];
                     [self.myview.tableView reloadData];
                     [stateView removeFromSuperview];
                     
                     
                 }else{
                 
                 NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
                 [userdefaults setObject:@"繁   忙" forKey:@"statename"];
                 [userdefaults setObject:@"-2" forKey:@"stateImagename"];
                 [userdefaults synchronize];
                 [self.myview.tableView reloadData];
                 [stateView removeFromSuperview];
                 }
                 
                 NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
                 if (nameArrays == nil ||[userdefault objectForKey:@"statename"] == nil) {
                     stateLable.text = @"空   闲";
                     stateImageView.image = [UIImage imageNamed:@"成功"];
                 }else
                 {
                     stateLable.text = [userdefault objectForKey:@"statename"];
                     stateImageView.image = [UIImage imageNamed:[userdefault objectForKey:@"stateImagename"]];
                 }
                 if ([stateLable.text isEqualToString:@"繁   忙"])
                 {
                     stateButton.layer.borderColor = [UIColor redColor].CGColor;
                     
                 }
                 else
                 {
                     stateButton.layer.borderColor = FZColor(110,185,43).CGColor;
                 }
             }else{
                 NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
                 [userdefaults setObject:nameArrays[Tags - 1000] forKey:@"statename"];
                 [userdefaults setObject:imageNameArrays[Tags - 1000] forKey:@"stateImagename"];
                 [userdefaults synchronize];
                 [self.myview.tableView reloadData];
                 [stateView removeFromSuperview];
                 
                 
#pragma mark - 发送通知
                 
             NSDictionary *dic = [NSDictionary dictionaryWithObject:USERTYPE forKey:@"STATE"];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"GOout" object:nil userInfo:dic];
                 
                 NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
                 if (nameArrays == nil ||[userdefault objectForKey:@"statename"] == nil) {
                     stateLable.text = @"空   闲";
                     
                     stateImageView.image = [UIImage imageNamed:@"成功"];
                 }else
                 {
                     stateLable.text = [userdefault objectForKey:@"statename"];
                     stateImageView.image = [UIImage imageNamed:[userdefault objectForKey:@"stateImagename"]];
                 }
                 if ([stateLable.text isEqualToString:@"繁   忙"])
                 {
                     stateButton.layer.borderColor = [UIColor redColor].CGColor;
                     
                 }
                 else
                 {
                     stateButton.layer.borderColor = FZColor(110,185,43).CGColor;
                 }
             }
            
             //             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
         }
     }];
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


@end
