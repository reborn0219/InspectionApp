//
//  PSWODetailsDistributeVC.h
//  InspectionApp
//
//  Created by guokang on 2019/6/5.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSWODetailsDistributeVC : UIViewController
-(void)showInVC:(UIViewController *)VC;
@property (nonatomic,copy)WorkAlertBlock block;
@property (nonatomic, assign)NSInteger  type;
@end

NS_ASSUME_NONNULL_END
