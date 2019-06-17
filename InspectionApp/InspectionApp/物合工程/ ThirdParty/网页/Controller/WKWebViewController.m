//
//  WKWebViewController.m
//  InspectionApp
//
//  Created by yang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
// WKWebView 内存不释放的问题解决
@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
@interface WKWebViewController ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>
@property (nonatomic,strong) WKWebView * webView;
@property (nonatomic, strong) UIProgressView * progressView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
    
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    config.allowsInlineMediaPlayback = YES;
    //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    config.requiresUserActionForMediaPlayback = YES;
    //设置是否允许画中画技术 在特定设备上有效
    config.allowsPictureInPictureMediaPlayback = YES;
    //设置请求的User-Agent信息中应用程序名称 iOS9后可用
    config.applicationNameForUserAgent = @"ChinaDailyForiPad";
    //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
    WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
    //这个类主要用来做native与JavaScript的交互管理
    WKUserContentController * wkUController = [[WKUserContentController alloc] init];
    //注册一个name为jsToOcNoPrams的js方法
    [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
    [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
    config.userContentController = wkUController;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,NavBar_H, SCREEN_WIDTH, SCREEN_HEIGHT-NavBar_H) configuration:config];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    //可返回的页面列表, 存储已打开过的网页
    
    [self.view addSubview:self.webView];
    //页面后退
}
- (NSString *)readCurrentCookieWithDomain:(NSString *)domainStr{
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableString * cookieString = [[NSMutableString alloc]init];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
    }
    if ([cookieString hasSuffix:@";"]) {
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    }
    
    return cookieString;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showNaBar:2];
    [self setBarTitle:_titleStr];
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,w ,H - NavBar_H)];
    [self.webView loadHTMLString:self.webUrl baseURL:nil];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
//    [request addValue:[self readCurrentCookieWithDomain:_webUrl] forHTTPHeaderField:@"Cookie"];
//    [_webView loadRequest:request];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
@end
