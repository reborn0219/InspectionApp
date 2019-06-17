//
//  PSOfficialWechatVC.m
//  物联宝管家
//
//  Created by guokang on 2019/5/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PSOfficialWechatVC.h"

@interface PSOfficialWechatVC ()
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;

@end

@implementation PSOfficialWechatVC
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
    [self.wechatImage sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
}
- (IBAction)cancleBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
