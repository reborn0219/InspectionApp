//
//  GJWebViewController.m
//  MeiLin
//
//  Created by 曹学亮 on 16/9/12.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJWebViewController.h"
#import "GJSVProgressHUD.h"
#import "AW_Constants.h"
#import "Masonry.h"
#import "GJShowMoreOperationView.h"
#import "UIAlertView+BlocksKit.h"
//#import "ComplainTypeViewController.h"

@interface GJWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,copy)   NSString *URLString;
@property (nonatomic,copy)   NSString *yunXinID;
@property (nonatomic,strong) GJShowMoreOperationView *menuView;
@end

@implementation GJWebViewController
#pragma mark - Init Menthod
+ (instancetype)initWithURL:(NSString *)URLString yunXinID:(NSString *)ID{
    GJWebViewController *controller = [[GJWebViewController alloc]init];
    controller.URLString = URLString;
    controller.yunXinID = ID;
    return controller;
}

#pragma mark - LifeCycle Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubViews];
    [self setNavigation];
    UILabel *titlelable = [UILabel lableWithName:@"正在加载..."];
    self.navigationItem.titleView = titlelable;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
    self.view.backgroundColor = HexRGB(0xf6f7f8);
}

- (void)addSubViews{
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setNavigation{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"canvas_more_32x32_"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Event Response
- (void)showMenu{
    [self.menuView showMenuView];
}

- (void)selectMenuIterm:(NSString *)string{
    NSLog(@"%@",string);
    if ([string isEqualToString:@"发送给朋友"]){
        
        
    }else if ([string isEqualToString:@"在Safair中打开"]){
        [self openWithSafair];
        
    }else if ([string isEqualToString:@"刷新"]){
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]]];
        
    }else if ([string isEqualToString:@"投诉"]){
        [self Complaints];
        
    }
}

//在Safair中打开
- (void)openWithSafair{
    if (![[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:self.URLString]]) {
        [GJSVProgressHUD showSuccessWithStatus:@"已发送"];
      
      return;
    }
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.URLString]];
}

//举报用户
- (void)Complaints{
   /* NSString *user_id = [GJUserCacheManager getById:self.yunXinID].userId;
    ComplainTypeViewController *controller = [[ComplainTypeViewController alloc] init];
    controller.userId=user_id;
    [self.navigationController pushViewController:controller animated:YES];*/
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [GJSVProgressHUD showWithStatus:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [GJSVProgressHUD dismiss];
    
    //获取网页title
    NSString *htmlTitle = @"document.title";
    
    //获取到得网页内容
    NSString *titleHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:htmlTitle];
    UILabel *titlelable = [UILabel lableWithName:titleHtmlInfo];
    self.navigationItem.titleView = titlelable;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [GJSVProgressHUD showErrorWithStatus:[error localizedDescription]];
}

#pragma mark - Setter && Getetr
- (UIWebView *)webView{
    if (!_webView) {
        _webView  = [[UIWebView alloc]init];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
    }
    return _webView;
}

- (GJShowMoreOperationView *)menuView{
    if (!_menuView) {
        MJWeakSelf
        NSString *urlString = [self.URLString substringFromIndex:7];
        _menuView = [[GJShowMoreOperationView alloc]initWithString:urlString DoneBlock:^(NSString *titleString) {
            [weakSelf selectMenuIterm:titleString];
        }];
    }
    return _menuView;
}

@end
