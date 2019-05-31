//
//  BaseAlertViewController.m
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "BaseAlertViewController.h"

@interface BaseAlertViewController ()

@end

@implementation BaseAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)showInVC:(UIViewController *)VC {
    
    if (self.isBeingPresented) {
        return;
    }
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    /**
     *  根据系统版本设置显示样式
     */
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        self.modalPresentationStyle=UIModalPresentationOverFullScreen;
    }else {
        self.modalPresentationStyle=UIModalPresentationCustom;
    }
    [VC presentViewController:self animated:YES completion:nil];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
