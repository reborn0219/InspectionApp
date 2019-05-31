//
//  GJXSMediaPlayer.h
//  MovieDemo
//
//  Created by zhao on 16/3/25.
//  Copyright © 2016年 Mega. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "XibView.h"
@class GJXSMediaPlayerMaskView;

@interface GJXSMediaPlayer : UIView


/** 视频URL */
@property (nonatomic, strong) NSURL   *videoURL;
//-(void)orientationChanged:(NSNotification *)noc;
@property(nonatomic,strong)GJXSMediaPlayerMaskView *maskView;


@end



