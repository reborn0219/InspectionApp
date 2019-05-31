//
//  ConfirmationVC.h
//  物联宝管家
//
//  Created by guokang on 2019/5/13.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmationVC : BaseAlertViewController
@property (nonatomic,copy) AlertBlock block;
-(void)showInVC:(UIViewController *)VC withTitle:(NSString*)content;
@end

NS_ASSUME_NONNULL_END
