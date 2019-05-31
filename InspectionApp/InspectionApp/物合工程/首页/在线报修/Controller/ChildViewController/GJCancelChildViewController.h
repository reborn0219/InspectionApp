//
//  GJCancelChildViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CancelChildVCDelegates <NSObject>

-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;

@end

@interface GJCancelChildViewController : UIViewController
@property(nonatomic,strong)NSDictionary *receiveDataDic;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,assign)BOOL isAnBao;

@property(nonatomic,assign)id<CancelChildVCDelegates>CancelDelegates;
@end
