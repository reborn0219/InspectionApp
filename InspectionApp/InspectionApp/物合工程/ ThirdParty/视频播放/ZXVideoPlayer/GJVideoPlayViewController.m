//
//  GJVideoPlayViewController.m
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/29.
//  Copyright © 2016年 Shawn. All rights reserved.
#import "GJVideoPlayViewController.h"
#import "GJZXVideoPlayerController.h"
#import "GJZXVideo.h"
@interface GJVideoPlayViewController ()
@property (nonatomic, strong) GJZXVideoPlayerController *videoController;
@end
@implementation GJVideoPlayViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self playVideo];
}
- (void)playVideo
{
    if (!self.videoController) {
        self.videoController = [[GJZXVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, kZXVideoPlayerOriginalWidth, kZXVideoPlayerOriginalHeight)];
        __weak typeof(self) weakSelf = self;
        self.videoController.videoPlayerGoBackBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            [strongSelf.navigationController popViewControllerAnimated:YES];
            [strongSelf.navigationController setNavigationBarHidden:NO animated:YES];
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"ZXVideoPlayer_DidLockScreen"];
            strongSelf.videoController = nil;
        };
        self.videoController.videoPlayerWillChangeToOriginalScreenModeBlock = ^(){
            NSLog(@"切换为竖屏模式");
        };
        self.videoController.videoPlayerWillChangeToFullScreenModeBlock = ^(){
            NSLog(@"切换为全屏模式");
        };
        [self.videoController showInView:self.view];
    }
    self.videoController.video = self.video;
}

@end
