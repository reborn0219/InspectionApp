//
//  GJCancelViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/13.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJwageViewController;

@interface GJCancelViewController : UIViewController
@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,assign)id<cancelWageDelegates>cancelDelegates;
@property(nonatomic,assign)BOOL isAnBao;

@end
