//
//  GJUnexeChildViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UNexeChildVCDelegates <NSObject>

-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;
-(void)PushLoginVCDidClicked;


-(void)QianMing:(NSString *)repair_id;

@end

@interface GJUnexeChildViewController : UIViewController
@property(nonatomic,assign)BOOL isAnBao;

@property(nonatomic,strong)NSDictionary *receiveDataDic;
@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UILabel  *textfield;
@property(nonatomic,strong)NSArray *WorkNmaeArray;
@property(nonatomic,strong)NSString *ISLOCATION;
@property(nonatomic,assign)id<UNexeChildVCDelegates>unexeDelegates;

@property(strong,nonatomic)NSString *STYLE;
@end
