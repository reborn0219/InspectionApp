//
//  MLSecurityYCLVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJwageViewController;

@interface MLSecurityYCLVC : UIViewController
@property (nonatomic, weak)GJwageViewController *parentController;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,assign)id<FishedWageDelegates>fishDelegates;
@property(nonatomic,assign)BOOL isAnBao;

@end
