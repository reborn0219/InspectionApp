//
//  MLSecurityYWCVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJwageViewController;

@interface MLSecurityYWCVC : UIViewController
@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,assign)id<cancelWageDelegates>cancelDelegates;
@property(nonatomic,assign)BOOL isAnBao;

@end
