//
//  GJSearchPassWordController.h
//  WLBLogin
//
//  Created by 付智鹏 on 16/2/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJSearchPassWordController : UIViewController

@property(nonatomic,strong)UITextField *numberTextFiled;
@property(nonatomic,strong)UITextField *VerificationTextFiled;
@property(nonatomic,strong)UITextField *NewpassWordTextFiled;
@property(nonatomic,strong)UITextField *NewpassWordTextFiledagen;
@property(nonatomic,strong)UIButton *getbutton;
@property(nonatomic,strong)UIButton *confirmButton;
@property(nonatomic,strong)NSString *ReceiveNewpassWord;
@property(nonatomic,strong)NSString *ReceiveNewpassWordagen;
@end
