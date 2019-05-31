
//
//  GJMessageNewsViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMessageNewsViewController.h"
#import "GJSliderViewController.h"
@interface GJMessageNewsViewController ()
@end

@implementation GJMessageNewsViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titlelable = [UILabel lableWithName:@"通知详情"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
//    self.messagenewsView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *arr = [userdefaults objectForKey:@"MessageNewsArray"];
//    NSArray *contentarray = [arr objectAtIndex:0];
//    NSArray *titleArray = [arr objectAtIndex:1];
    NSArray *h5_url=[arr objectAtIndex:3];
    UIWebView *web=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",h5_url[self.receive]]]];
    [web loadRequest:request];
    [self.view addSubview:web];
//    self.TitleLable = [[UILabel alloc]init];
//    self.TitleLable.numberOfLines = 0;
//    self.TitleLable.textAlignment = NSTextAlignmentCenter;
//    self.TitleLable.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.TitleLable.text = titleArray[self.receive];
//    //关键语句
//    CGSize expectSize = [self.TitleLable sizeThatFits:CGSizeMake(WIDTH - 20, MAXFLOAT)];
//    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
//    self.TitleLable.frame = CGRectMake(10, 10, WIDTH - 20, expectSize.height);
//    self.TitleLable.textColor = gycolor;
//    self.TitleLable.font = [UIFont boldSystemFontOfSize:17];
//    self.TitleLable.backgroundColor = [UIColor whiteColor];
//    
//
//    self.ContentLable = [[UILabel alloc]init];
//    self.ContentLable.numberOfLines = 0;
//    self.ContentLable.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.ContentLable.text = contentarray[self.receive];
//    //关键语句
//    CGSize ContentexpectSize = [self.ContentLable sizeThatFits:CGSizeMake(WIDTH - 20, MAXFLOAT)];
//    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
//    self.ContentLable.frame = CGRectMake(10, CGRectGetMaxY(self.TitleLable.frame)+10, WIDTH - 20, ContentexpectSize.height);
//    self.ContentLable.textColor = gycolor;
//    self.ContentLable.font = [UIFont systemFontOfSize:15];
//    self.ContentLable.backgroundColor = [UIColor whiteColor];
//    
//    [self.messagenewsView addSubview:self.TitleLable];
//    [self.messagenewsView addSubview:self.ContentLable];
//    self.messagenewsView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(self.ContentLable.frame));
//    self.messagenewsView.pagingEnabled = YES;
//    self.messagenewsView.scrollEnabled = YES;
//    self.messagenewsView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.messagenewsView];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
