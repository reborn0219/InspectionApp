//
//  PSWOHeaderInvalidMarkVC.h
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSWOHeaderInvalidMarkVC : UIViewController
-(void)showInVC:(UIViewController *)VC;
@property (nonatomic, copy)WorkAlertBlock block;
@end

NS_ASSUME_NONNULL_END
