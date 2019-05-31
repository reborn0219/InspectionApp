//
//  GJMessageNewsViewController.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GJMessageNewsViewController : UIViewController
@property(nonatomic,strong)UIScrollView *messagenewsView;
@property(nonatomic,assign)NSString *TitleText;
@property(nonatomic,assign)NSString *receiveContent;
@property(nonatomic,assign)NSInteger receive;
@property(nonatomic,strong)UILabel *TitleLable;
@property(nonatomic,strong)UILabel *ContentLable;
@end
