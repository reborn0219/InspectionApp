//
//  MLSecurityCLZVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GJwageViewController;


@interface MLSecurityCLZVC : UIViewController
@property(nonatomic,assign)BOOL isAnBao;

@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)id<exeCutedViewDelegate>exeDelegates;
@property(nonatomic,strong)UILabel *voiceTimeLable;
@end
