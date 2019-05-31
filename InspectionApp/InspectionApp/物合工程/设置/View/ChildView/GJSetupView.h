//
//  GJSetupView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMBProgressHUD+MJ.h"



@protocol ChangePassDelegate <NSObject>
-(void)changePassDidClicked:(UIButton *)sender;
-(void)aboutViewDidClicked:(UIButton *)sender;
-(void)feedbackDidClicked:(UIButton *)sender;
-(void)closeAppClicked;
@end

@interface GJSetupView : UITableView
@property(nonatomic,strong)UIAlertView *alert;
@property(nonatomic,strong)UILabel *garbagelable;
@property(nonatomic,assign)id<ChangePassDelegate>delegates;
@end
