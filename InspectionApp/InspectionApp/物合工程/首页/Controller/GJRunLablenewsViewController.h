//
//  GJRunLablenewsViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/8/1.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJRunLablenewsViewController : UIViewController
@property(nonatomic,strong)UIScrollView *messagenewsView;
@property(nonatomic,assign)NSString *TitleText;
@property(nonatomic,assign)NSString *receiveContent;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,strong)UILabel *TitleLable;
@property(nonatomic,strong)UILabel *ContentLable;
@property(strong,nonatomic)NSString *H5_url;

@end
