//
//  PSShowWorkOrderVC.h
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSShowWorkOrderVC : UIViewController
@property (nonatomic,copy) WorkAlertBlock block;
@property (nonatomic,strong) NewOrderModel *controllerModel;
-(void)nextOrder;
-(void)showInVC:(UIViewController *)VC;
-(void)showInVC:(UIViewController *)VC withModel:(NewOrderModel*)model;

@end

NS_ASSUME_NONNULL_END
