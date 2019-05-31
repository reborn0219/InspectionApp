//
//  GJChangePassViewController.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJChangePassViewController : UITableViewController
@property(nonatomic,strong)UITextField *oldPassword;
@property(nonatomic,strong)UITextField *newsPassword;
@property(nonatomic,strong)UITextField *newsPasswordAgen;
@property(nonatomic,strong)UIAlertView *shengjialert;
@end
