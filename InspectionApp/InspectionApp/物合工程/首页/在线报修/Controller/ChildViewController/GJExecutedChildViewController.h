//
//  GJExecutedChildViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol exeChildVCDelegates <NSObject>
//拨放视频
-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;
//标记完工
-(void)PushFishWageClicked:(NSString *)repairdIDs;
-(void)PushLoginVCDidClicked;

@end

@interface GJExecutedChildViewController : UIViewController
@property(nonatomic,strong)NSDictionary *receiveDataDic;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,assign)BOOL isAnBao;
@property(nonatomic,assign)id<exeChildVCDelegates>exeDelegates;
@end
