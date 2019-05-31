//
//  GJTableView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJTableSweepView.h"
@interface GJTableView : UIView
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)GJTableSweepView *sweepView;
@property(nonatomic,strong)UITableView *tabview;
@property(nonatomic,strong)UIButton *leftbutton;
@property(nonatomic,strong)UIButton *rightbutton;
@property(nonatomic,strong)UILabel *bottomLable;
@end
