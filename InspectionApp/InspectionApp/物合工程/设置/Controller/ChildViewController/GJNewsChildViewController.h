//
//  GJNewsChildViewController.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJNewsChildView.h"

@interface GJNewsChildViewController : UIViewController
@property(nonatomic,strong)NSString *titlelables;
@property(nonatomic,strong)NSString *rightTitle;
@property(nonatomic,strong)NSString *receivestr;
@property(nonatomic,strong)GJNewsChildView *NewsChiledView;
@property(nonatomic,strong)UIAlertView *shengjialert;
@end
