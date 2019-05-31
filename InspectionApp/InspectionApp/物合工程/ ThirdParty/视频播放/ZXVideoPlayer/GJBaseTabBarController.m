//
//  GJBaseTabBarController.m
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/29.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "GJBaseTabBarController.h"
#import "GJwageViewController.h"
#import "GJVideoPlayViewController.h"

@interface GJBaseTabBarController ()

@end

@implementation GJBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate
{
    UINavigationController *nav = self.viewControllers[0];
    if ([nav.topViewController isKindOfClass:[GJVideoPlayViewController class]]) {
        return ![[[NSUserDefaults standardUserDefaults] objectForKey:@"ZXVideoPlayer_DidLockScreen"] boolValue];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UINavigationController *nav = self.viewControllers[0];
    if ([nav.topViewController isKindOfClass:[GJwageViewController class]]) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
