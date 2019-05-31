//
//  GJVoiceWageViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/8/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol UnexeCutedViewDelegate <NSObject>

//-(void)UnexeCellDidClicked:(NSDictionary *)dict statNumber:(NSString *)statenumber Islocation:(NSString *)location;
//-(void)PushLoginVCDidClicked;
//-(void)PushVideoVCDidClicked:(NSString *)PlayvideoStr;
//-(void)pushImagebrowserDidClicked:(NSMutableArray *)mutableArray imageTag:(int)imagetag;
//@end
@interface GJVoiceWageViewController : UIViewController

@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIAlertView *shengjialert;
@property(nonatomic,strong)UIButton *dispatchButton;
@property(nonatomic,strong)UIButton *invalidButton;
@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UIButton *fenpeiyesButton;
@property(nonatomic,strong)UIButton *quxiaoyesButton;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)NSMutableDictionary * datasource;
//@property(nonatomic,strong)id<UnexeCutedViewDelegate>Unexedelegate;
@end
