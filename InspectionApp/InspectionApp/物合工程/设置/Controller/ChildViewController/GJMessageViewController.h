//
//  GJMessageViewController.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMessageViewController : UITableViewController
@property(nonatomic,strong)NSString *tongzhi;
@property(nonatomic,strong)NSMutableArray *nameNewsArray;
@property(nonatomic,strong)NSMutableArray *contentNewsArray;
@property(nonatomic,strong)NSMutableArray *timeNewsArray;
@property(strong,nonatomic)NSMutableArray *h5_urlArr;
@property(nonatomic,strong)NSArray *namenewsArray;
@property(nonatomic,strong)NSArray *contentnewsArray;
@property(nonatomic,strong)NSArray *timenewsArray;
@property(nonatomic,strong)UIAlertView *shengjialert;
@end
