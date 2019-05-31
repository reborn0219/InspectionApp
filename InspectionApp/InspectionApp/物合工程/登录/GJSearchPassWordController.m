//
//  GJSearchPassWordController.m
//  WLBLogin
//
//  Created by 付智鹏 on 16/2/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJSearchPassWordController.h"
#import "GJLoginViewController.h"
@interface GJSearchPassWordController()<UITextFieldDelegate>
#define HIGH  self.view.size.height
#define NUMBERS @"0123456789"
#define ACCOUNT_MAX_CHARS 11
@end

@implementation GJSearchPassWordController

-(void)viewDidLoad
{
    [self createdUI];
    [self createdPassWord];
}
-(void)backDidClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createdUI
{
    self.view.backgroundColor = viewbackcolor;
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 64)];
    barView.backgroundColor = NAVCOlOUR;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 25, 30, 30)];
    [leftButton addTarget:self action:@selector(backDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLables = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 25, 200, 30)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [barView addSubview:leftButton];
    [barView addSubview:titleLables];
    titleLables.text = @"重置密码";
    titleLables.textColor = [UIColor whiteColor];
    titleLables.font = [UIFont fontWithName:geshi size:22];
    titleLables.backgroundColor = [UIColor clearColor];
    titleLables.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:barView];
}


-(void)createdPassWord
{
    
    UIView *numberView = [[UIView alloc]initWithFrame:CGRectMake(0,75 , WIDTH, 81)];
    numberView.backgroundColor = [UIColor whiteColor];
    UILabel *numberLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60, 20)];
    UILabel *VerificationLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 51, 60, 20)];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, WIDTH - 20, 1)];
    lineLable.backgroundColor = viewbackcolor;
    self.numberTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, WIDTH - 65, 20)];
    self.numberTextFiled.delegate = self;
    self.VerificationTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(80, 51, WIDTH - 180, 20)];
    self.getbutton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 100,40 , 100, 41)];
    [_getbutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getbutton.titleLabel.font = [UIFont fontWithName:geshi size:13];
    _getbutton.backgroundColor = gycoloer;
    [_getbutton setTitleColor:viewbackcolor forState:UIControlStateNormal];
    [_getbutton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
    _getbutton.userInteractionEnabled = NO;
    _getbutton.alpha = 0.5;
    [_getbutton addTarget:self action:@selector(getVeriFicationClicked:) forControlEvents:UIControlEventTouchUpInside];
    numberLable.text = @"手机号 : ";
    numberLable.font = [UIFont fontWithName:geshi size:15];
    VerificationLable.text = @"验证码 : ";
    VerificationLable.font = [UIFont fontWithName:geshi size:15];
    _numberTextFiled.placeholder = @"请输入手机号";
    _numberTextFiled.font = [UIFont fontWithName:geshi size:15];
    self.VerificationTextFiled.placeholder = @"请输入验证码";
    self.VerificationTextFiled.font = [UIFont fontWithName:geshi size:15];
    _numberTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.VerificationTextFiled.keyboardType = UIKeyboardTypePhonePad;

    [numberView addSubview:numberLable];
    [numberView addSubview:_numberTextFiled];
    [numberView addSubview:VerificationLable];
    [numberView addSubview:self.VerificationTextFiled];
    [numberView addSubview:lineLable];
    [numberView addSubview:_getbutton];
    [self.view addSubview:numberView];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 165, WIDTH, 81)];
    view2.backgroundColor = [UIColor whiteColor];
    self.NewpassWordTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, WIDTH, 40)];
   self.NewpassWordTextFiledagen = [[UITextField alloc]initWithFrame:CGRectMake(20, 41, WIDTH, 40)];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, WIDTH - 40, 1)];
    self.NewpassWordTextFiled.placeholder = @"请输入新密码";
    self.NewpassWordTextFiled.secureTextEntry = YES;
    self.NewpassWordTextFiledagen.placeholder = @"请确认新密码";
    self.NewpassWordTextFiledagen.secureTextEntry = YES;
    self.NewpassWordTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.NewpassWordTextFiledagen.keyboardType = UIKeyboardTypePhonePad;
    self.NewpassWordTextFiled.font = [UIFont boldSystemFontOfSize:15];
    self.NewpassWordTextFiledagen.font = [UIFont fontWithName:geshi size:15];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:_numberTextFiled];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:_VerificationTextFiled];    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:_NewpassWordTextFiled];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:_NewpassWordTextFiledagen];
    alable.backgroundColor = viewbackcolor;
    [view2 addSubview:self.NewpassWordTextFiledagen];
    [view2 addSubview:self.NewpassWordTextFiled];
    [view2 addSubview:alable];
    [self.view addSubview:view2];
    _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 255, WIDTH - 40, 50)];
    [_confirmButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [_confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    _confirmButton.userInteractionEnabled = NO;
    _confirmButton.alpha = 0.5;
    [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmButton];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
////判断输入的是否是数字
//- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
//{
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    BOOL basicTest = [string isEqualToString:filtered];
//    if(!basicTest) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确手机号格式"delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
//        [alert show];
//        return NO;
//        
//    }
//    return YES;
//}
//判断手机号位数
-(void)getVeriFicationClicked:(UIButton *)sender
{
    __block int timeout = 60;
    if ([self validateMobile:self.numberTextFiled.text]) {
        [self Sendverificationcode];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout <= 0)
            { //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                    sender.userInteractionEnabled = YES;
                });
            }
            else if((sender.selected = YES))
            {
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [sender setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateNormal];
                    sender.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
    else
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入正确手机号!"];
    }
        
}
//确认提交按钮
-(void)confirmButtonClicked
{
    if([_ReceiveNewpassWordagen isEqualToString:_ReceiveNewpassWord])
    {
        [self searchPassword];

    }else
    {
        [GJSVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];

    }
}

#pragma mark 四个textfield的通知
-(void)change
{
    if ([self validateMobile:self.numberTextFiled.text]) {
        _getbutton.userInteractionEnabled = YES;
        _getbutton.alpha = 1.0;
    }else
    {
        _getbutton.userInteractionEnabled = NO;
        _getbutton.alpha = 0.5;
    }
    if ([self validateMobile:self.numberTextFiled.text] == NO||[_VerificationTextFiled.text isEqualToString:@""]||(_NewpassWordTextFiled.text.length < 6)||(_NewpassWordTextFiledagen.text.length < 6)) {
        _confirmButton.userInteractionEnabled = NO;
        _confirmButton.alpha = 0.5;
    }
    else
    {
        self.ReceiveNewpassWord = _NewpassWordTextFiled.text;
        self.ReceiveNewpassWordagen = _NewpassWordTextFiledagen.text;
        _confirmButton.userInteractionEnabled = YES;
        _confirmButton.alpha = 1.0;
    }

}

#pragma mark 判断是否是手机号
-(BOOL)validateMobile:(NSString *)mobile{
    NSString * MOBILE = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//获取验证码数据
-(void)Sendverificationcode
{
    NSString *phonenumber = self.numberTextFiled.text;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"sendsms" andA:@"getpwd_vercode" andBodyOfRequestForKeyArr:@[@"mobile_phone"] andValueArr:@[phonenumber] andBlock:^(id dictionary) {
        NSString *returandate = [NSString stringWithFormat:@"%@",dictionary[@"ico"]];
        if ([returandate isEqualToString:@"success"]) {
            [GJSVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]]];
        }else{
            [GJSVProgressHUD showErrorWithStatus:@"发送失败"];
        }
    }];
}



//获取新密码数据
-(void)searchPassword
{
    NSString *passnew = [NSString md5HexDigest:_NewpassWordTextFiled.text];
    NSString *passnewagen = [NSString md5HexDigest:_NewpassWordTextFiledagen.text];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"sendsms" andA:@"get_userpwd" andBodyOfRequestForKeyArr:@[@"mobile_phone",@"password_new",@"password_new_confirm",@"verification_code"] andValueArr:@[_numberTextFiled.text,passnew,passnewagen,_VerificationTextFiled.text] andBlock:^(id dictionary) {
        NSString *returandate = [NSString stringWithFormat:@"%@",dictionary[@"ico"]];
        if ([returandate isEqualToString:@"success"]) {
            [GJSVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]]];
            NSString *newpassward = _NewpassWordTextFiled.text;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //修改成功后把新密码存储到UserDefault
            [userDefaults setObject:newpassward forKey:@"newpassward"];
            [userDefaults synchronize];
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [GJSVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]]];
        }
    }];
}
@end
