//
//  PSFeedBackViewController.m
//  InspectionApp
//
//  Created by guokang on 2019/6/15.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSFeedBackViewController.h"
#import "MyselfRequest.h"

@interface PSFeedBackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textViewBackView;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIView *phoneBackView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@end

@implementation PSFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNaBar:201];
    self.textViewBackView.layer.cornerRadius = 8.0f;
    self.textViewBackView.layer.shadowOffset = CGSizeMake(0, 0);
    self.textViewBackView.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.textViewBackView.layer.shadowRadius = 2;
    self.textViewBackView.layer.shadowOpacity = 0.2;
    self.contentTV.layer.cornerRadius = 8.0f;
    self.contentTV.delegate = self;
    self.phoneBackView.layer.cornerRadius = 8.0f;
    self.phoneBackView.layer.shadowOffset = CGSizeMake(0, 0);
    self.phoneBackView.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.phoneBackView.layer.shadowRadius = 2;
    self.phoneBackView.layer.shadowOpacity = 0.2;
    self.phoneTF.layer.cornerRadius = 8.0f;
    self.phoneTF.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keybaordClickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    [self setBarTitle:@"意见反馈"];
}
- (void)keybaordClickToBack
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入您的意见或建议"]) {
        textView.text = @"";
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@"请输入联系方式"]) {
        textField.text = @"";
    }
}
-(void)markOverAction
{
    [MyselfRequest feedback:_contentTV.text contact:_phoneTF.text :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *succeed = data;
            [GJMBProgressHUD showSuccess:succeed];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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
