//
//  PPBaseViewController.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNavigationBarView.h"
#import "Masonry.h"
#import "PPViewTool.h"
#import "PPUserGuideVC.h"
#import "PPNoDataView.h"
#import "ConfirmationVC.h"

@interface PPBaseViewController : UIViewController
@property(nonatomic,strong)PPNavigationBarView *navBar;
@property (nonatomic, strong)PPNoDataView  *noDataView;
-(void)hiddenNaBar;
-(void)showNaBar:(NSInteger)type;
-(void)setBarTitle:(NSString *)title;
-(void)popController;
-(void)popController:(NSInteger)index;
-(void)popControllerReverse:(NSInteger)index;
-(void)rightBarAction:(NSInteger)type;
-(void)segementDidSelected:(NSInteger)type;
-(void)backValue:(NSString *)value;
@property (nonatomic,strong) UIView *topView;
@end
