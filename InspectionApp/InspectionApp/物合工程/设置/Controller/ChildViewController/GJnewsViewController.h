//
//  GJnewsViewController.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadportraitDelegate <NSObject>

-(void)changeHeadportrait:(NSString *)change;

@end



@interface GJnewsViewController : UITableViewController
@property(nonatomic,assign)NSString *tongzhi;
@property(nonatomic,strong)NSArray *leftArray;
@property(nonatomic,strong)NSArray *rightArray;
@property(nonatomic,strong)NSMutableArray *departmentNameArray;
@property(nonatomic,strong)NSData *imageData;

@property(nonatomic,strong)UIAlertView *shengjialert;
@property(nonatomic,assign)id<HeadportraitDelegate>delegates;
@end
