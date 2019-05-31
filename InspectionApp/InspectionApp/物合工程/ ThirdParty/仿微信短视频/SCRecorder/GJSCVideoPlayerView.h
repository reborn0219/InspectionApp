//
//  GJSCVideoPlayerView.h
//  SCAudioVideoRecorder
//
//  Created by Simon CORSIN on 8/30/13.
//  Copyright (c) 2013 rFlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJSCPlayer.h"
#import "GJSCImageView.h"

@class GJSCVideoPlayerView;

@protocol SCVideoPlayerViewDelegate <NSObject>

- (void)videoPlayerViewTappedToPlay:(GJSCVideoPlayerView *__nonnull)videoPlayerView;

- (void)videoPlayerViewTappedToPause:(GJSCVideoPlayerView *__nonnull)videoPlayerView;

@end

@interface GJSCVideoPlayerView : UIView

/**
 The delegate
 */
@property (weak, nonatomic) IBOutlet __nullable id<SCVideoPlayerViewDelegate> delegate;

/**
 The player this GJSCVideoPlayerView show
 */
@property (strong, nonatomic) GJSCPlayer *__nullable player;

/**
 The underlying AVPlayerLayer used for displaying the video.
 */
@property (readonly, nonatomic) AVPlayerLayer *__nullable playerLayer;

/**
 If enabled, tapping on the view will pause/unpause the player.
 */
@property (assign, nonatomic) BOOL tapToPauseEnabled;

/**
 Init the GJSCVideoPlayerView with a provided GJSCPlayer.
 */
- (nonnull instancetype)initWithPlayer:(GJSCPlayer *__nonnull)player;

/**
 Set whether every new instances of GJSCVideoPlayerView should automatically create
 and hold an GJSCPlayer when needed. If disabled, an external GJSCPlayer must be set
 manually to each GJSCVideoPlayerView instance in order to work properly. Default is YES.
 */
+ (void)setAutoCreatePlayerWhenNeeded:(BOOL)autoCreatePlayerWhenNeeded;

/**
 Whether every new instances of GJSCVideoPlayerView should automatically create and hold an GJSCPlayer
 when needed. If disabled, an external GJSCPlayer must be set manually to each
 GJSCVideoPlayerView instance in order to work properly. Default is YES.
 */
+ (BOOL)autoCreatePlayerWhenNeeded;

@end
