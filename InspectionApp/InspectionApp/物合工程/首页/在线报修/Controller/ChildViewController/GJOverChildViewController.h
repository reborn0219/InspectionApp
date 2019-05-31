//
//  GJOverChildViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverChildVCDelegates <NSObject>

-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;

@end

@interface GJOverChildViewController : UIViewController
@property(nonatomic,strong)NSDictionary *receiveDataDic;
//@property(nonatomic,strong)AVAudioPlayer *player;

@property(nonatomic,assign)id<OverChildVCDelegates>OverDelegates;
@end
