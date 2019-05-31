//
//  GJSetupView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJSetupView.h"
#import "JPUSHService.h"
#import "XSDLocationTools.h"
#import "GJAppDelegate.h"
@interface GJSetupView()
{
    NSString *clearCacheName;
}

@end

@implementation GJSetupView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = viewbackcolor;
        [self floats];
    }
    return self;
}
-(void)createdUI
{
    //20181022上架后显示去评分
    NSArray *namearray = @[@"修改密码",@"去评分",@"关于我们"];
    for (int i = 1 ; i < 4; i++) {
        if (i > 1) {
            [self buttonWithTitle:namearray[i - 1] CGRect:CGRectMake(0, 16 + 40*i, W, 40) tags:i];
        }else{
            [self buttonWithTitle:namearray[i-1] CGRect:CGRectMake(0, 40*i+6, W, 40) tags:i];
        }
    }
    //20180921上架前隐藏去评分
//    NSArray *namearray = @[@"修改密码",@"意见反馈",@"关于我们"];
//    for (int i = 1 ; i < 4; i++) {
//        if (i > 1) {
//            [self buttonWithTitle:namearray[i - 1] CGRect:CGRectMake(0, 16 + 40*i, W, 40) tags:i];
//        }else{
//            [self buttonWithTitle:namearray[i-1] CGRect:CGRectMake(0, 40*i+6, W, 40) tags:i];
//        }
//    }
    UIButton *garbagebutton = [[UIButton alloc]init];
    garbagebutton.backgroundColor = [UIColor whiteColor];
    garbagebutton.frame = CGRectMake(0, 6, W, 40);
    garbagebutton.tag = 0;
    [garbagebutton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [garbagebutton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState: UIControlStateHighlighted];
    UILabel *garbagelable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, W - 100, 20)];
    garbagelable.backgroundColor = [UIColor clearColor];
    garbagelable.text = @"清理缓存";
    garbagelable.font = [UIFont fontWithName:geshi size:17];
    garbagelable.textColor = gycolor;
    self.garbagelable = [[UILabel alloc]initWithFrame:CGRectMake(W - 100, 10, 90, 20)];
    self.garbagelable.backgroundColor = [UIColor clearColor];
    self.garbagelable.textAlignment = NSTextAlignmentRight;
    self.garbagelable.text = clearCacheName;
    NSLog(@"%@",clearCacheName);
    self.garbagelable.textColor = gycolor;
    self.garbagelable.font = [UIFont fontWithName:geshi size:17];
    self.garbagelable.alpha = 0.6;
    [garbagebutton  addSubview:self.garbagelable];
    [self addSubview:garbagebutton];
    UILabel *uplinelable = [[UILabel alloc]initWithFrame:CGRectMake(0,0, W, 0.5)];
    uplinelable.backgroundColor = gycoloers;
    UILabel *aaalable = [[UILabel alloc]initWithFrame:CGRectMake(20, 40.5, W - 20, 0.5)];
    aaalable.backgroundColor = gycoloers;
    [garbagebutton addSubview:aaalable];
    [garbagebutton addSubview:garbagelable];
    [garbagebutton addSubview:uplinelable];
    [self addSubview:garbagebutton];
    
    
    
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0,85.5, W, 0.5)];
    alable.backgroundColor = gycoloers;
    [self addSubview:alable];
    
    
    
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(0, 95.5, W, 0.5)];
    blable.backgroundColor = gycoloers;
    UILabel *clable = [[UILabel alloc]initWithFrame:CGRectMake(0, 175.5, W, 0.5)];
    clable.backgroundColor = gycoloers;
    
    UILabel *closeupLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 189.5, W, 0.5)];
    UILabel *closedownLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 230.5, W, 0.5)];
    closeupLable.backgroundColor = gycoloers;
    closedownLable.backgroundColor = gycoloers;
    [self addSubview:closeupLable];
    [self addSubview:closedownLable];
    [self addSubview:blable];
    [self addSubview:clable];
    UIButton *closebutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 190, W, 40)];
    closebutton.backgroundColor = [UIColor whiteColor];
    [closebutton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    UILabel *dlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, W, 20)];
    dlable.backgroundColor = [UIColor clearColor];
    dlable.text = @"退出登录";
    dlable.font = [UIFont fontWithName:geshi size:17];
    dlable.textAlignment = NSTextAlignmentCenter;
    dlable.textColor = gycolor;
    [closebutton addSubview:dlable];
    closebutton.titleLabel.textColor = [UIColor blackColor];
    [closebutton addTarget:self action:@selector(CloseClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closebutton];
    
}
-(void)buttonWithTitle:(NSString *)title CGRect:(CGRect)rect tags:(NSInteger)tags
{
    UIButton *abutton = [[UIButton alloc]init];
    abutton.backgroundColor = [UIColor whiteColor];
    abutton.frame = rect;
    abutton.tag = tags;
    [abutton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [abutton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, W - 100, 20)];
    alable.backgroundColor = [UIColor clearColor];
    alable.text = title;
    alable.textColor = gycolor;
    alable.font = [UIFont fontWithName:geshi size:17];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
    imageView.image = [UIImage imageWithName:@"sssss"];
    imageView.backgroundColor = [UIColor clearColor];
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(20, 39.5, W - 20, 0.5)];
    blable.backgroundColor = gycoloers;
    [abutton addSubview:blable];
    [abutton addSubview:alable];
    [abutton addSubview:imageView];
    [self addSubview:abutton];
}

//弹出退出提示框
-(void)CloseClicked
{
    self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    self.alert.tag = 1;
    [self.alert show];
}
//判断是否退出和是否清除缓存
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)self.alert.tag);
    if (self.alert.tag == 1) {
        if (buttonIndex == 0) {
            [self.alert removeFromSuperview];
        }else
        {
            [self closeAppClicked];
        }
    }else{
        if (buttonIndex == 0) {
            [self.alert removeFromSuperview];
        }else
        {
            [self cleargarbage];
        }
    }
}
/**
 *  App退出
 */
- (void)closeAppClicked{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
//NSArray * arr=[NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"adv"]];

    for (id  key in dic) {
        NSString *lskey_str = (NSString *)key;
        if ([lskey_str isKindOfClass:[NSString class]]&&[lskey_str isEqualToString:@"showguide"]) {
            
        }else{
            [userDefaults removeObjectForKey:key];
        }
    }
    
    [userDefaults synchronize];
    
//    [userDefaults setObject:arr forKey:@"adv"];
    
//    [userDefaults removeObjectForKey:@"user_id"];
//    [userDefaults removeObjectForKey:@"session_key"];
    if (self.delegates && [self.delegates respondsToSelector:@selector(closeAppClicked)]) {
        [self.delegates closeAppClicked];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
    [JPUSHService setTags:[NSSet setWithObjects:@"", nil] alias:@"" callbackSelector:@selector(kkk) object:self];

    [[NSUserDefaults standardUserDefaults]setObject:@(NO) forKey:@"IS_LOGIN"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[XSDLocationTools shareInstance]stopLocationService];;
    GJAppDelegate *appDelegate = (GJAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate stopChatTimer];
    
}
-(void)TCRY{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#define DEFAULTS [NSUserDefaults standardUserDefaults]
    //    [DEFAULTS removeObjectForKey:@"userName"];
    //    [DEFAULTS removeObjectForKey:@"userPwd"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ZJchat_pwd"];

    
}
-(void)kkk{

}
-(void)buttonDidClicked:(UIButton *)sender
{
    if (sender.tag == 0) {
        self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要清除缓存数据?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        self.alert.tag = 2;
        [self.alert show];

        
        
    }else if (sender.tag == 1)
    {
        //修改密码
        [self changePass:sender];
    }else if (sender.tag == 2)
    {
        //20181022上架后显示去评分
             [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1438960772"]];//https://itunes.apple.com/us/app/物合管家/id1438960772?l=zh&ls=1&mt=8
    }
    else if(sender.tag == 3){
        //关于我们
       [self feedbackDidClicked:sender];
    }
    
}
//修改密码
-(void)changePass:(UIButton *)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(changePassDidClicked:)]) {
        [self.delegates changePassDidClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
//关于我们
-(void)feedbackDidClicked:(UIButton*)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(changePassDidClicked:)]) {
        [self.delegates aboutViewDidClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
-(void)floats
{
    float tmpSize = 2.3;
    clearCacheName = [NSString stringWithFormat:@"%.2fM",tmpSize];
    [self createdUI];
}

- (void)cleargarbage

{
    [[SDImageCache sharedImageCache] clearMemory];
    float tmpSize =  2.3;
    clearCacheName = [NSString stringWithFormat:@"清理了缓存(%.2fM)",tmpSize];
    self.garbagelable.text = @"0.00M";
}
@end
