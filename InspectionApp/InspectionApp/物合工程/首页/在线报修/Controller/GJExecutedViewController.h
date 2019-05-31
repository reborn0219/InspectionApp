//
//  GJExecutedViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJwageViewController;


@interface GJExecutedViewController : UIViewController
@property(nonatomic,assign)BOOL isAnBao;

@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)id<exeCutedViewDelegate>exeDelegates;
@property(nonatomic,strong)UILabel *voiceTimeLable;
@end
