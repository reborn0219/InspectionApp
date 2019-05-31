//
//  GJUnexecutedViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJwageViewController;


@interface  GJWholeViewController: UIViewController

@property(nonatomic,assign)BOOL isAnBao;

@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)id<WholeCutedViewDelegate>Wholedelegate;
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIAlertView *shengjialert;
@property(nonatomic,strong)UIButton *dispatchButton;
@property(nonatomic,strong)UIButton *invalidButton;
@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UIButton *fenpeiyesButton;
@property(nonatomic,strong)UIButton *quxiaoyesButton;
@property(nonatomic,strong)UILabel *timeLable;
@end
