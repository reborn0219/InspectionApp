//
//  GJAboutUsViewcontroller.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "GJAboutUsViewcontroller.h"
#import "GJDisclaimerViewController.h"
#import "GJProblemViewController.h"
#import "GJAboutusView.h"

@interface GJAboutUsViewcontroller()<aboutUsDidClickDelegate,MFMailComposeViewControllerDelegate>
{
    NSMutableDictionary * dict;
}
@property(nonatomic,strong)GJAboutusView *aboutView;
@end

@implementation GJAboutUsViewcontroller

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

-(void)viewDidLoad
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    dict = [[NSMutableDictionary alloc]initWithDictionary:[userdefaults objectForKey:@"aboutUsData"]];
    UILabel *titlelable = [UILabel lableWithName:@"关于物联宝管家"];
    self.navigationItem.titleView = titlelable;
    self.aboutView = [[GJAboutusView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.aboutView.delegates = self;
    self.view = self.aboutView;
}

-(void)aboutUsDidClicked:(UIButton *)buttontags
{
    
    if (buttontags.tag == 0) {
        GJDisclaimerViewController *DisclaimerVC = [[GJDisclaimerViewController alloc]init];
        [self.navigationController pushViewController:DisclaimerVC animated:YES];
    }
    else if (buttontags.tag ==1)
    {
        GJProblemViewController *ProblemVC = [[GJProblemViewController alloc]init];
        [self.navigationController pushViewController:ProblemVC animated:YES];
    }
    else if (buttontags.tag == 2)
    {
        [self WeChatView];
    }
     else if (buttontags.tag == 3)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",dict[@"email"]]]];
//        @"mailto://devprograms@apple.com"
    }else if (buttontags.tag == 4)
    {
        [self phoneNumber];
    }
}
-(void)WeChatView
{
    UIButton *disCoverButton = [[UIButton alloc]init];
    [disCoverButton addTarget:self action:@selector(closeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    disCoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    UIView *wechatView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2 - 120,120, 240, 300)];
    wechatView.backgroundColor = buttonHighcolor;
    wechatView.layer.masksToBounds = YES;
    wechatView.layer.cornerRadius = 6.0;
    wechatView.layer.borderWidth = 1.0;
    wechatView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,wechatView.size.width , 20)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"扫码分享";
    titleLable.font = [UIFont fontWithName:geshi size:14];
    titleLable.textColor = gycolor;
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, wechatView.size.width, 1)];
    lineLable.backgroundColor = gycoloers;
    UIImageView *wechatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 55, 180, 180)];
    wechatImageView.backgroundColor = [UIColor clearColor];
    [wechatImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"wechat_qrc"]] placeholderImage:[UIImage imageNamed:@"100x100"]];
    UILabel *InvitefriendsLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, wechatView.size.width, 10)];
    InvitefriendsLable.backgroundColor = [UIColor clearColor];
    InvitefriendsLable.textColor = gycolor;
    InvitefriendsLable.font = [UIFont fontWithName:geshi size:12];
    InvitefriendsLable.text = @"邀请好友扫码关注物联宝管家官方微信";
    InvitefriendsLable.textAlignment = NSTextAlignmentCenter;
    
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 280, wechatView.size.width, 10)];
    alable.backgroundColor = [UIColor clearColor];
    alable.font = [UIFont fontWithName:geshi size:12];
    alable.textColor = [UIColor orangeColor];
    alable.text = @"更多惊喜等你哦~~";
    alable.textAlignment = NSTextAlignmentCenter;
    
    [wechatView addSubview:titleLable];
    [wechatView addSubview:InvitefriendsLable];
    [wechatView addSubview:alable];
    [wechatView addSubview:wechatImageView];
    [wechatView addSubview:lineLable];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    disCoverButton.frame = window.bounds;
    [disCoverButton addSubview:wechatView];
    [window addSubview:disCoverButton];
}
-(void)closeButtonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}
//拨打电话功能
-(void)phoneNumber
{
    //朱滴20180915版权信息改为美戴瑜洋
    if ([dict[@"tel"] isEqual:@"400-8756-399"]) {
        [dict setObject:@"400-6836-524" forKey:@"tel"];
    }
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:dict[@"tel"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
    [alertview show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",dict[@"tel"]]]];
    }
}
@end
