//
//  GJRunLablenewsViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/8/1.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJRunLablenewsViewController.h"

@interface GJRunLablenewsViewController ()<UIWebViewDelegate>
{
    NSString *titleStr;
    NSString *ContentStr;
}

@end

@implementation GJRunLablenewsViewController

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
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];

    NSDictionary *dataDic = [NSDictionary dictionary];
    dataDic = [userdefaults objectForKey:@"RunLableData"];
    NSLog(@"%@",dataDic);
    _H5_url=dataDic[@"notice"][@"h5_url"];

    UIWebView *webV=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    webV.delegate=self;
    [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_H5_url]]];
    [self.view addSubview:webV];

    
    
//    self.messagenewsView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//
//    NSLog(@"%@%@",titleStr,ContentStr);
//    titleStr = dataDic[@"notice"][@"msg_name"];
//    ContentStr = dataDic[@"notice"][@"msg_content"];
//    
//    self.TitleLable = [[UILabel alloc]init];
//    self.TitleLable.numberOfLines = 0;
//    self.TitleLable.textAlignment = NSTextAlignmentCenter;
//    self.TitleLable.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.TitleLable.text = titleStr;
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
//    self.ContentLable.text = ContentStr;
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
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [GJSVProgressHUD show];
}
- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    [GJSVProgressHUD dismiss];
    
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
