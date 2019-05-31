//
//  MPViewController.m
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import "GJMViewController.h"
#import "GJXSMediaPlayer.h"
#import "GJXSMediaPlayerMaskView.h"
@interface GJMViewController ()<fullScreenBtnDidClickedDelegate>
{
    BOOL ISvertical;
}

@property(nonatomic,retain)GJXSMediaPlayer *player;
@end

@implementation GJMViewController
-(void)viewDidAppear:(BOOL)animated
{
    [self prefersStatusBarHidden];
}
- (void)viewDidLoad {
    ISvertical = YES;
    self.view.backgroundColor = [UIColor blackColor];
    _player = [[GJXSMediaPlayer alloc]initWithFrame:CGRectMake(0, HEIGHT/2 - 110, self.view.frame.size.width, 220)];
//    _player.videoURL = [NSURL URLWithString:@"http://m3u8back.gougouvideo.com/m3u8_yyyy?i=4275259"];
    _player.videoURL = self.receivePlaymoviedurl;
    _player.maskView.fullscreenDelegate = self;
    [self.view addSubview:_player];
    [super viewDidLoad];
}
-(void)fullScreenBtnDidClicked
{
    if (ISvertical == YES) {
        ISvertical = NO;
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        //设置旋转动画
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        //设置视图旋转
        self.view.bounds = CGRectMake(0, 0, self.view.height, self.view.width);
        self.view.transform = CGAffineTransformMakeRotation(M_PI*1.5);
        [UIView commitAnimations];

    }else
    {
        ISvertical = YES;
        CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        //设置旋转动画
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        //设置视图旋转
        self.view.bounds = CGRectMake(0, 0, self.view.width, self.view.height);
        self.view.transform = CGAffineTransformMakeRotation(M_PI * 2);
        [UIView commitAnimations];
    }
}
- (BOOL)prefersStatusBarHidden {
    //设置状态栏隐藏显示
    NSLog(@"ssss");
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
