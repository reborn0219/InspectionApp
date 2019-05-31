//
//  MLSecurityYCLDetailVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/16.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MLSecurityYCLDetailVC : UIViewController
@property(nonatomic,strong)NSDictionary *receiveDataDic;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,assign)BOOL isAnBao;

@property(nonatomic,assign)id<FishChildViewDelegates>FishChildDelegates;
@end
