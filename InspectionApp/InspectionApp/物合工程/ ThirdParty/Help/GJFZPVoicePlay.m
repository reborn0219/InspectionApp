//
//  GJFZPVoicePlay.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/4.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPVoicePlay.h"
@implementation GJFZPVoicePlay
+(GJSTKAudioPlayer *)ShareAudioPlayer{
    static GJSTKAudioPlayer *STKplayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        STKplayer = [[GJSTKAudioPlayer alloc]initWithOptions:(STKAudioPlayerOptions){
            // equalizerBandFrequencies 均衡器带频率
            .flushQueueOnSeek = YES,
            // enableVolumeMixer设置为yes, 将启用音量控制
            .enableVolumeMixer = YES,
            // flushQueueOnSeek 刷新音频队列
            .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000}
        }];
        
    });
    return STKplayer;
}

@end
