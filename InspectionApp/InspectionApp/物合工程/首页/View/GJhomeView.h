//
//  GJhomeView.h
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJSMS_Scroll_ImageView.h"
#import "GJhomeViewController.h"
@protocol HomeButtonDelegate <NSObject>

-(void)HomeButtonClicked:(UIButton *)button;
-(void)complaintClicked;
-(void)consultationClicked;
-(void)pushLoginVC;
@end

@interface GJhomeView : UIScrollView
{
    NSMutableArray *_imageNames;
}
@property(nonatomic,strong)UITableView *atableview;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *lable1;
@property(nonatomic,strong)UILabel *NotAssignedLable;
@property(nonatomic,strong)UILabel *complaintLable;
@property(nonatomic,strong)UILabel *consultationLable;
@property(nonatomic,strong)    UIButton *RunLableButton;
@property (nonatomic, strong)    GJSMS_Scroll_ImageView *scrollView;
@property (nonatomic,strong) GJhomeViewController *viewController;


@property(nonatomic,assign)id<HomeButtonDelegate>delegates;
@property(nonatomic,strong)UIAlertView *shengjialert;
@end
