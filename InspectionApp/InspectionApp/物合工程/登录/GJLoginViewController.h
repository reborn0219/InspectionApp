//
//  GJLoginViewController.h
//  WLBLogin
//
//  Created by 付智鹏 on 16/2/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMBProgressHUD+MJ.h"

@protocol LoginAndColseDelegates <NSObject>

-(void)LoginAndColse:(NSString *)number;

@end

@interface GJLoginViewController : UIViewController
{
    BOOL recordPwd;
    UITextField *nameTextField;
    UITextField *pswTextField;
    UIButton *loginbutton;
}
@property(nonatomic,strong)UIImageView *bigimageview;
@property(nonatomic,strong)UIImageView *bigimageView1;
@property(nonatomic,strong)NSString *tongzhi;
@property(nonatomic,strong)UIAlertView *shengjialert;
@property (nonatomic, strong)GJIQKeyboardManager *returnKeyHandler;
@property(nonatomic,strong)id<LoginAndColseDelegates>delegates;
@end
