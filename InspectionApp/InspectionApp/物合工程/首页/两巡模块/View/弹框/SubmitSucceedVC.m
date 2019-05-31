//
//  SubmitSucceedVC.m
//  物联宝管家
//
//  Created by guokang on 2019/4/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "SubmitSucceedVC.h"

@interface SubmitSucceedVC ()

@end

@implementation SubmitSucceedVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backBtnAction:(id)sender {
    ///完成事件
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(0);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
