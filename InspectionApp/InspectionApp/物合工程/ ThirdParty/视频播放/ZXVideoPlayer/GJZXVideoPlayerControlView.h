//
//  GJZXVideoPlayerControlView.h
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/21.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJZXVideoPlayerTimeIndicatorView.h"
#import "GJZXVideoPlayerBrightnessView.h"
#import "GJZXVideoPlayerVolumeView.h"
#import "GJZXVideoPlayerBatteryView.h"

#define kZXPlayerControlViewHideNotification @"ZXPlayerControlViewHideNotification"

@protocol ZXVideoPlayerControlViewDelegage <NSObject>

@optional
- (void)videoPlayerControlViewDidTapped;

@end

@interface GJZXVideoPlayerControlView : UIView

@property (nonatomic, assign, readwrite) id<ZXVideoPlayerControlViewDelegage> delegate;

@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong, readonly) UIView *bottomBar;
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *pauseButton;
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
@property (nonatomic, strong, readonly) UIButton *shrinkScreenButton;
@property (nonatomic, strong, readonly) UISlider *progressSlider;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;

@property (nonatomic, assign, readonly) BOOL isBarShowing;
/// 返回按钮
@property (nonatomic, strong, readwrite) UIButton *backButton;
/// 屏幕锁定按钮
@property (nonatomic, strong, readwrite) UIButton *lockButton;
/// 缓冲进度条
@property (nonatomic, strong, readwrite) UIProgressView *bufferProgressView;
/// 快进、快退指示器
@property (nonatomic, strong, readwrite) GJZXVideoPlayerTimeIndicatorView *timeIndicatorView;
/// 亮度指示器
@property (nonatomic, strong, readwrite) GJZXVideoPlayerBrightnessView *brightnessIndicatorView;
/// 音量指示器
@property (nonatomic, strong, readwrite) GJZXVideoPlayerVolumeView *volumeIndicatorView;
/// 电池条
@property (nonatomic, strong, readwrite) GJZXVideoPlayerBatteryView *batteryView;
/// 标题
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;

@end
