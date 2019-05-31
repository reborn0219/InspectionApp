//
//  MLSecurityDCLVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJwageViewController;



@interface MLSecurityDCLVC : UIViewController
@property(nonatomic,assign)BOOL isAnBao;
@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)id<UnexeCutedViewDelegate>Unexedelegate;
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIAlertView *shengjialert;
@property(nonatomic,strong)UIButton *dispatchButton;
@property(nonatomic,strong)UIButton *invalidButton;
@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UIButton *fenpeiyesButton;
@property(nonatomic,strong)UIButton *quxiaoyesButton;
@property(nonatomic,strong)UILabel *timeLable;

@end
