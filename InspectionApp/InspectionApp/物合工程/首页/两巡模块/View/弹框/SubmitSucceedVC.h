//
//  SubmitSucceedVC.h
//  物联宝管家
//
//  Created by guokang on 2019/4/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubmitSucceedVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (nonatomic,copy) AlertBlock block;

-(void)showInVC:(UIViewController *)VC;
@end

NS_ASSUME_NONNULL_END
