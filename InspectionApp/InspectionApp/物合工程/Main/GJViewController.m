//
//  GJViewController.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJViewController.h"
#import "GJhomeViewController.h"
#import "GJAllWageViewController.h"
#import "GJmyViewController.h"
#import "GJNavigationController.h"
#import "GJLoginViewController.h"
#import "GJGraViewController.h"
#import "Masonry.h"
#import "GJUnexeChildViewController.h"
#import "TBTabBar.h"

#define titcolor (colorWithRed:110 green:185 blue:43 alpha:1)

@interface GJViewController ()
@property (nonatomic, retain) UIView *tabBarView;
@end

@implementation GJViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化所有控制器
    [self setUpChildVC];
    [self setUpMidelTabbarItem];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBar setHidden:NO];
}

#pragma mark -创建tabbar中间的tabbarItem
- (void)setUpMidelTabbarItem {
    
    TBTabBar *tabBar = [[TBTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    [tabBar setDidClickPublishBtn:^{
        
//        ReleaseController *hmpositionVC = [[ReleaseController alloc] init];
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:hmpositionVC];
//        [weakSelf presentViewController:nav animated:YES completion:nil];
        
    }];
    
}

#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    GJhomeViewController *findVC = [[GJhomeViewController alloc] init];
    GJGraViewController *graVC = [[GJGraViewController alloc]init];
    GJmyViewController *myVC = [[GJmyViewController alloc] init];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *Isrole = [userdefaults objectForKey:@"role"];
    
    if (Isrole.length == 0 || [Isrole isEqualToString:@"admin"]) {
        [self setChildVC:findVC title:@"管家" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select"];
        [self setChildVC:myVC title:@"设置" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select"];

    }else
    {
        [self setChildVC:graVC title:@"管家" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select"];
        [self setChildVC:myVC title:@"设置" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select"];

    }

    
}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    GJNavigationController *nav = [[GJNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self.tabBar setHidden:NO];

    NSLog(@"item name = %@", item.title);
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
//    if([item.title isEqualToString:@"发现"])
//    {
//        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
//    }
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}


@end
