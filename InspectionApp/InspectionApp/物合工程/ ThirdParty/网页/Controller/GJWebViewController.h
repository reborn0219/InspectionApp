//
//  GJWebViewController.h
//  MeiLin
//
//  Created by 曹学亮 on 16/9/12.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author cao, 16-09-12 10:09:25
 *
 *  点击链接跳转到的界面
 */
@interface GJWebViewController : UIViewController
+ (instancetype)initWithURL:(NSString *)URLString yunXinID:(NSString *)ID;
@end
