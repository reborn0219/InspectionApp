//
//  PSShowWorkOrderVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSShowWorkOrderVC.h"
#import "DistributeWorkOrderVC.h"

@interface PSShowWorkOrderVC ()
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *grabOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@end

@implementation PSShowWorkOrderVC
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
    self.bigBackView.layer.masksToBounds = YES;
    self.bigBackView.layer.cornerRadius = 8.0f;
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.masksToBounds = YES;
}
- (IBAction)grabOrderAction:(id)sender {
  
}
- (IBAction)nextAction:(id)sender {
    
}

- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
