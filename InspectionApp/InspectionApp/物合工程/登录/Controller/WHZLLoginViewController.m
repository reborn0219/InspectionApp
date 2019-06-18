//
//  WHZLLoginViewController.m
//  物联宝管家
//
//  Created by guokang on 2019/5/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "WHZLLoginViewController.h"
#import "WHZLForgetPasswordVC.h"
#import "PSHomePageViewController.h"
#import "LoginRequest.h"
@interface WHZLLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *scanBut;

@property (weak, nonatomic) IBOutlet UIButton *forgetCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFeild;
@end

@implementation WHZLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.codeTextFeild.secureTextEntry = YES;
    [self.navigationController.navigationBar setHidden:YES];

//    _codeTextFeild.text = @"123456789";
//    _phoneTextFeild.text = @"13403110724";
    _codeTextFeild.text = @"88998600";
    _phoneTextFeild.text = @"18810000002";

}
- (IBAction)scanPasswordAction:(id)sender {
    UIButton *btn = sender;
    if (!btn.isSelected) {
        self.codeTextFeild.secureTextEntry = NO;
        [btn setImage:[UIImage imageNamed:@"图标-眼睛"] forState:(UIControlStateNormal)];
        btn.selected = YES;
    }else{
        self.codeTextFeild.secureTextEntry = YES;
        [btn setImage:[UIImage imageNamed:@"t图标-眼睛"] forState:(UIControlStateNormal)];
         btn.selected = NO;
    }
}
- (IBAction)forgetCodeAction:(id)sender {
    WHZLForgetPasswordVC *passwordVC = [[WHZLForgetPasswordVC alloc]init];
    passwordVC.isChange = NO;
    [self.navigationController pushViewController:passwordVC animated:YES];
}
- (IBAction)loginAction:(id)sender {
    
    NSString *md5password = [NSString md5HexDigest:_codeTextFeild.text];
    NSDictionary *dic = @{@"mobile_phone":_phoneTextFeild.text,@"password":md5password};
    [LoginRequest do_lgoin:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        NSDictionary *dictionary = data;
        SLog(@"dictionary___%@",dictionary);

        if (resultCode == SucceedCode) {
            
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate startChatTimer];
            NSDictionary *userInfo =   dictionary[@"user_info"];
            NSDictionary *about =   dictionary[@"about"];
            [UserManager saveAboutModel:[AboutModel yy_modelWithJSON:about]];
            [UserManager saveUserInfo:[UserManagerModel yy_modelWithJSON:userInfo]];
            [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:@"IS_LOGIN"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //[[XSDLocationTools shareInstance]startLocationService];
            PSHomePageViewController *homeVC = [[PSHomePageViewController alloc]init];
            UINavigationController *homenav = [[UINavigationController alloc]initWithRootViewController:homeVC];
            APP_DELEGATE.window.rootViewController=homenav;
            ///绑定标签
            //[AppSystemSetPresenters getBindingTag];
            CATransition * animation =  [AnimtionUtils getAnimation:7 subtag:2];
            [homenav.view.window.layer addAnimation:animation forKey:nil];
        }else{
            
        }
     
    }];
    

}



@end
