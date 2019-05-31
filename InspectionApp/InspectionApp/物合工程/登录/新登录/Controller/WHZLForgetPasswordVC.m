//
//  WHZLForgetPasswordVC.m
//  物联宝管家
//
//  Created by guokang on 2019/5/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "WHZLForgetPasswordVC.h"

@interface WHZLForgetPasswordVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTFHeight;
@property (weak, nonatomic) IBOutlet UITextField *phoneTX;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTX;
@property (weak, nonatomic) IBOutlet UITextField *passwordTX;
@property (weak, nonatomic) IBOutlet UITextField *oncePasswordTX;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIButton *onceScanBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation WHZLForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isChange) {
        self.title = @"修改密码";
    }else{
        self.title = @"忘记密码";
    }
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)createUI
{
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn addTarget:self action:@selector(clickToBack) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setImage: [UIImage imageNamed:@"图标-返回黑"]forState:(UIControlStateNormal)];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    self.scanBtn.hidden = YES;
    self.onceScanBtn.hidden = YES;
    self.firstTFHeight.constant = NavBar_H + 31.0;
    self.passwordTX.secureTextEntry = YES;
    self.oncePasswordTX.secureTextEntry = YES;
    [self.passwordTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.oncePasswordTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.getCodeBtn addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.getCodeBtn.layer.cornerRadius = 11.0f;
    self.getCodeBtn.layer.masksToBounds = YES;
    [self.scanBtn addTarget:self action:@selector(scanPasswordAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.onceScanBtn addTarget:self action:@selector(onceScanPasswordAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.confirmBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:self.confirmBtn withFrame:CGRectMake(0, 0, KScreenWigth - 60, 48) withCornerRadius:24.f] above:0];
    self.confirmBtn.layer.cornerRadius = 24.0f;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)clickToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldValueChanged:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
            if (textField.text.length > 0) {
                self.scanBtn.hidden = NO;
            }else{
                self.scanBtn.hidden = YES;
            }
            break;
            case 101:
            if (textField.text.length > 0) {
                self.onceScanBtn.hidden = NO;
            }else{
                self.onceScanBtn.hidden = YES;
            }
        default:
            break;
    }
}

- (void)getVerificationCodeAction
{
    
}
- (void)scanPasswordAction:(UIButton*)sender
{
    if (!sender.isSelected) {
        self.passwordTX.secureTextEntry = NO;
        [self.scanBtn setImage:[UIImage imageNamed:@"图标-眼睛"] forState:(UIControlStateNormal)];
        sender.selected = YES;
    }else{
        self.passwordTX.secureTextEntry = YES;
        [self.scanBtn setImage:[UIImage imageNamed:@"t图标-眼睛"] forState:(UIControlStateSelected)];
        sender.selected = NO;
    }
}
- (void)onceScanPasswordAction:(UIButton*)sender
{
    if (!sender.isSelected) {
        self.oncePasswordTX.secureTextEntry = NO;
        [self.onceScanBtn setImage:[UIImage imageNamed:@"图标-眼睛"] forState:(UIControlStateNormal)];
        sender.selected = YES;
    }else{
        self.oncePasswordTX.secureTextEntry = YES;
        [self.onceScanBtn setImage:[UIImage imageNamed:@"t图标-眼睛"] forState:(UIControlStateSelected)];
        sender.selected = NO;
    }
}
-(void)confirmAction
{
    
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
