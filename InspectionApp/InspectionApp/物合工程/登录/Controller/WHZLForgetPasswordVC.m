//
//  WHZLForgetPasswordVC.m
//  物联宝管家
//
//  Created by guokang on 2019/5/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "WHZLForgetPasswordVC.h"
#import "LoginRequest.h"

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
@property(assign,nonatomic) NSInteger count;
 @property(strong,nonatomic) NSTimer *timer;
@property (nonatomic, strong)NSMutableDictionary  *dataDict;
@end

@implementation WHZLForgetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)createUI
{
    [self showNaBar:2];
    if (self.isChange) {
          [self  setBarTitle:@"修改密码"];
    }else{
          [self  setBarTitle:@"忘记密码"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keybaordClickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    self.phoneTX.delegate = self;
    self.phoneTX.tag = 200;
    self.verificationCodeTX.delegate = self;
    self.verificationCodeTX.tag = 201;
    self.passwordTX.delegate = self;
    self.passwordTX.tag = 202;
    self.oncePasswordTX.delegate = self;
    self.oncePasswordTX.tag = 203;
    self.scanBtn.hidden = YES;
    self.onceScanBtn.hidden = YES;
    self.firstTFHeight.constant = NavBar_H + 31.0;
    self.passwordTX.secureTextEntry = YES;
    self.oncePasswordTX.secureTextEntry = YES;
    [self.phoneTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.verificationCodeTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.passwordTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self.oncePasswordTX addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
    self.getCodeBtn.layer.cornerRadius = 11.0f;
    self.getCodeBtn.layer.masksToBounds = YES;
    [self.scanBtn addTarget:self action:@selector(scanPasswordAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.onceScanBtn addTarget:self action:@selector(onceScanPasswordAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.confirmBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:self.confirmBtn withFrame:CGRectMake(0, 0, KScreenWigth - 60, 48) withCornerRadius:24.f] above:0];
    self.confirmBtn.layer.cornerRadius = 24.0f;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)keybaordClickToBack
{
    [self.view endEditing:YES];
}
- (NSMutableDictionary *)dataDict
{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 200:
        {
            if ([textField.text isEqualToString:@"请输入您的手机号"]) {
                textField.text = @"";
            }
        }
            break;
         case 201:
        {
            if ([textField.text isEqualToString:@"请输入您的验证码"]) {
                textField.text = @"";
            }
        }
            break;
            case 202:
        {
            if ([textField.text isEqualToString:@"请输入您的密码"]) {
                textField.text = @"";
            }
        }
            break;
            case 203:
        {
            if ([textField.text isEqualToString:@"请输入您的密码"]) {
                textField.text = @"";
            }
        }
        default:
            break;
    }
}
- (void)clickToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldValueChanged:(UITextField *)textField
{
    NSString *md5password;
    NSString *md5passwordcon;
    if (textField.tag == 202) {
      md5password  = [NSString md5HexDigest:textField.text];
    }else if (textField.tag == 203){
       md5passwordcon  = [NSString md5HexDigest:textField.text];
    }
    switch (textField.tag) {
        case 200:
            [self.dataDict setValue:textField.text forKey:@"mobile_phone"];
            break;
            case 201:
           [self.dataDict setValue:textField.text forKey:@"verification_code"];
            break;
            case 202:
            [self.dataDict setValue:md5password forKey:@"password_new"];
            break;
            case 203:
            [self.dataDict setValue:md5passwordcon forKey:@"password_new_confirm"];
        default:
            break;
    }
}
#pragma mark - 添加定时器
- (void)timeBegain
{
    self.count = 60;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
      [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark - 定时器事件
- (void)timeDown
{
    if (self.count != 1){
        self.count -=1;
        [self.getCodeBtn setTitleColor:HexRGB(0xBDBDBD) forState:(UIControlStateNormal)];
        [self.getCodeBtn setBackgroundImage:[UIImage imageNamed:@"剩余秒数"] forState:(UIControlStateNormal)];
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"再次获取%lds", self.count] forState:UIControlStateNormal];
        self.getCodeBtn.userInteractionEnabled = NO;
    } else {
        self.getCodeBtn.userInteractionEnabled = YES;
        [self.getCodeBtn setBackgroundImage:[UIImage imageNamed:@"获取验证码"] forState:(UIControlStateNormal)];
        [self.getCodeBtn setTitleColor:HexRGB(0x46CCD9) forState:(UIControlStateNormal)];
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
     
        [self.timer invalidate];
    }

}
- (IBAction)getVerticationCode:(id)sender {
    [self.view endEditing:YES];
    [self timeBegain];
    if ([self validateMobile:_phoneTX.text]) {
        [LoginRequest  getpwd_vercode:_phoneTX.text :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            if (resultCode == SucceedCode) {
                NSString *succeed = data;
                [GJMBProgressHUD showSuccess:succeed];
            }
        }];
    }else{
        [GJMBProgressHUD showError:@"请输入正确的手机号"];
    }
}
#pragma mark 判断是否是手机号
-(BOOL)validateMobile:(NSString *)mobile{
    NSString * MOBILE = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
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
//    NSString *mobile_phone = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"mobile_phone"]];
//    NSString *code = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"verification_code"]];
//    NSString *password_new = [NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"password_new"]];
//    NSString *password_new_confirm =[NSString stringWithFormat:@"%@",[self.dataDict objectForKey:@"password_new_confirm"]];
//    if ([self validateMobile:mobile_phone] == YES &&code.length ==6&&[password_new isEqualToString:password_new_confirm] &&password_new.length >= 8) {
        [LoginRequest get_userpwd:self.dataDict :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            if (resultCode == SucceedCode) {
                NSString *succeed = data;
                [GJMBProgressHUD showSuccess:succeed];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
//    }else{
//        [GJMBProgressHUD showError:@"请输入正确的信息"];
//    }
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
