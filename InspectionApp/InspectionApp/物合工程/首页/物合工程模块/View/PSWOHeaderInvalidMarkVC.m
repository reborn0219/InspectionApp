//
//  PSWOHeaderInvalidMarkVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHeaderInvalidMarkVC.h"

@interface PSWOHeaderInvalidMarkVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bigView;

@end

@implementation PSWOHeaderInvalidMarkVC
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
    self.bigView.layer.cornerRadius = 8.0f;
    self.bigView.clipsToBounds = YES;
    self.backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    self.backView.layer.shadowOpacity = 0.2;
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowRadius = 2.0f;
    self.remarkTV.layer.cornerRadius = 8.0f;
    self.remarkTV.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keybaordClickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}
- (void)keybaordClickToBack
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入"]) {
        textView.text = @"";
    }
}
- (IBAction)confirmAction:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(self.remarkTV.text,WorkOrderAlertMarkInvalid);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)closeAction:(id)sender {
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
