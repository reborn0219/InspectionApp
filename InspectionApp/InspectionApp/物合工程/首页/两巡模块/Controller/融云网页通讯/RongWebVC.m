//
//  RongWebVC.m
//  物联宝管家
//
//  Created by yang on 2019/4/28.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "RongWebVC.h"

@interface RongWebVC ()

@end

@implementation RongWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webV=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWigth, KScreenHeight)];
    NSURL* url = [NSURL URLWithString:@"https://rongyun.node4.yanxishe.cc/call.html?0"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webV loadRequest:request];//加载
    
    [self.view addSubview:webV];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
