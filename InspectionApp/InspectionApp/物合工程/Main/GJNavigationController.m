//
//  GJNavigationController.m
//  物联宝家居
//
//  Created by 付智鹏 on 16/2/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJNavigationController.h"
@interface GJNavigationController ()

@end

@implementation GJNavigationController
-(void)viewDidLoad
{
    [super viewDidLoad];
}
/**
 *  拦截所有push进来的子控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)

    viewController.hidesBottomBarWhenPushed = YES;
    //左侧导航栏按钮
    //左侧导航栏按钮
    UIButton *leftbutton = [UIButton leftbuttonwithimageName:@"zx-video-banner-back" target:self action:@selector(back)];
    
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -6;
    
    
    viewController.navigationItem.leftBarButtonItems =  [NSArray arrayWithObjects:negativeSpacer,leftBtn,nil];
    
    
    
    //导航栏背景颜色
    [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
    [super pushViewController:viewController animated:animated];
}
/*
 UIButton *leftbutton = [UIButton leftbuttonwithimageName:@"zx-video-banner-back" target:self action:@selector(back)];
 UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
 viewController.navigationItem.leftBarButtonItem = leftBtn;
 //导航栏背景颜色
 [self.navigationController.navigationBar setBarTintColor:NAVCOlOUR];
 [super pushViewController:viewController animated:animated];
 */


/*
 //左侧导航栏按钮
 UIButton *leftbutton = [UIButton leftbuttonwithimageName:@"zx-video-banner-back" target:self action:@selector(back)];
 
 
 UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
 
 UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
 initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
 target:nil action:nil];
 negativeSpacer.width = -6;
 
 
 viewController.navigationItem.leftBarButtonItems =  [NSArray arrayWithObjects:negativeSpacer,leftBtn,nil];
 ;
 */

-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
