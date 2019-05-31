//  GJLoginViewController.m
//  WLBLogin
//
//  Created by 付智鹏 on 16/2/25.
//  Copyright © 2016年 付智鹏. All rights reserved.

#import "GJLoginViewController.h"
#import "GJSearchPassWordController.h"
#import "GJNavigationController.h"
#import "GJSliderViewController.h"
#import "GJQHMainGestureRecognizerViewController.h"
#import "GJSetUpController.h"
#import "JPUSHService.h"
#import "XSDLocationTools.h"
#import "GJAppDelegate.h"
#define Width (self.view.bounds.size.width)
#define Heigh (self.view.bounds.size.height)
#define USERNAME @"nameTextField"
#define PASSWORD @"pswTextField"
#define heights 185

#define isPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad   ? YES : NO)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)


@interface GJLoginViewController ()<UITextFieldDelegate>
{
    BOOL new;
    NSString *uploadUrl;
}
@property(nonatomic,strong)UIImageView *button;
@property(nonatomic,strong)NSMutableDictionary *userDic;
@property(nonatomic,strong)UIView *loginView;

@end


@implementation GJLoginViewController
{
    
    BOOL _wasKeyboardManagerEnabled;
   
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[GJIQKeyboardManager sharedManager] isEnabled];
    [[GJIQKeyboardManager sharedManager] setEnable:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [[NSUserDefaults standardUserDefaults]setObject:@(NO) forKey:@"IS_LOGIN"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [super viewWillDisappear:animated];
    [[GJIQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
} 
-(void)viewDidLoad
{
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, WIDTH, Heigh);
        [self readUserInfoFromFile];
    [self createdUI2];
}
-(void)createdUI2
{
    UIImageView *img=[[UIImageView alloc]init];
    if (isPad) {
        img.frame=CGRectMake(0, 0, WIDTH, WIDTH/2.8);
        [img setImage:[UIImage imageNamed:@"ipad_bj"]];

    }else{
        img.frame=CGRectMake(0, 0, WIDTH, WIDTH/1.4);
        [img setImage:[UIImage imageNamed:@"mldj_dl"]];

    }
    [self.view addSubview:img];
    
    
    //设置上面的图片
    UIImageView * imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-70)/2, 60, 70, 70)];
    imageview1.image = [UIImage imageNamed:@"mlgj_logo"];
    imageview1.tag = 6001;
    [self.view addSubview:imageview1];
    
    //添加下面的图片                                                                                              450  140
    UIImageView * imaheview2 = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-130)/2, 135, 130, 35)];
    imaheview2.image = [UIImage imageNamed:@"mlgj_text"];
    imaheview2.tag = 5999;
    [self.view addSubview:imaheview2];
    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(25,  img.frame.origin.y+img.bounds.size.height+20  , Width - 50, 40)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(25,  img.frame.origin.y+img.bounds.size.height+20+60 , Width - 50, 40)];
    view1.layer.cornerRadius=20;
    view1.layer.borderWidth=1;
    view1.layer.borderColor=RGB(233, 233, 233).CGColor;
    
    view2.layer.cornerRadius=20;
    view2.layer.borderWidth=1;
    view2.layer.borderColor=RGBAlpha(233, 233, 233, 1).CGColor;
    
    
    nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0  , view1.size.width - 40, 40)];
    nameTextField.placeholder = @"手机号码/用户名";
    
    nameTextField.font = [UIFont fontWithName:geshi size:17];
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    view1.backgroundColor = [UIColor whiteColor];
    nameTextField.delegate = self;
    pswTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0 , view2.size.width - 40, 40)];
    pswTextField.font = [UIFont fontWithName:geshi size:17];
    pswTextField.placeholder = @"请输入密码";
    
    pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    view2.backgroundColor = [UIColor whiteColor];
    nameTextField.keyboardType = UIKeyboardTypePhonePad;
    [pswTextField setSecureTextEntry:YES];//密码设置为暗文
    pswTextField.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:nameTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:UITextFieldTextDidChangeNotification object:pswTextField];
    //判断是否记住密码
    [self readUserInfoFromFile];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImageView *imageview11 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 10, 20, 20)];
    imageview.image = [UIImage imageNamed:@"mldj_icon_n01"];
    imageview11.image = [UIImage imageNamed:@"mldj_icon_n02"];
    [view1 addSubview:nameTextField];
    [view1 addSubview:imageview];
    [view2 addSubview:pswTextField];
    [view2 addSubview:imageview11];
    [self.view addSubview:view1];
    [self.view addSubview:view2];

    
    //
    UIButton *longbutton = [[UIButton alloc]initWithFrame:CGRectMake(30, img.frame.origin.y+img.bounds.size.height+120+25, 105, 20)];
     self.button = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 20, 20)];
    [longbutton addTarget:self action:@selector(rumber:) forControlEvents:UIControlEventTouchUpInside];
    longbutton.selected = NO;
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 70, 20)];
    alable.font = [UIFont fontWithName:geshi size:14];
    alable.text = @"记住密码";
    alable.textColor =gycoloer;
    [longbutton addSubview:self.button];
    [longbutton addSubview:alable];
    [self.view addSubview:longbutton];
    
    
    UIButton *forgetbutton = [[UIButton alloc]initWithFrame:CGRectMake(Width - 25-80, img.frame.origin.y+img.bounds.size.height+120+25, 100, 20)];
    [forgetbutton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetbutton.titleLabel.font = [UIFont fontWithName:geshi size:14];
    [forgetbutton setTitleColor:MainColor forState:UIControlStateNormal];
    [forgetbutton addTarget:self action:@selector(forgetDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetbutton];
    
    
    loginbutton = [[UIButton alloc]initWithFrame:CGRectMake(25,  forgetbutton.frame.origin.y+forgetbutton.bounds.size.height+20, Width - 50, 40)];
    loginbutton.userInteractionEnabled = NO;
//    [loginbutton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    loginbutton.alpha = 0.5;
    loginbutton.backgroundColor = RGB(112, 19, 28);
    loginbutton.layer.cornerRadius=20;
    loginbutton.clipsToBounds=YES;
    [loginbutton setTitle:@"立即登录" forState:UIControlStateNormal];
    loginbutton.titleLabel.textColor = [UIColor whiteColor];
    loginbutton.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginbutton.titleLabel.font = [UIFont fontWithName:geshi size:20];
    [loginbutton addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [loginbutton addTarget:self action:@selector(denglus) forControlEvents:UIControlEventTouchDragExit];

    if (recordPwd) {
        self.button.image = [UIImage imageNamed:@"mldi_icon_a03"];
        loginbutton.userInteractionEnabled = YES;
//        [loginbutton setBackgroundImage:[UIImage imageNamed:@"dl_1x14"] forState:UIControlStateNormal];
        loginbutton.alpha = 1.0;
    }
    else{
        self.button.image = [UIImage imageNamed:@"mldj_icon_n03"];
    }

    [self.view addSubview:loginbutton];
}
-(void)denglus
{
    NSLog(@"ssss");
}
#pragma mark textField  delagate
//11个字数

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (toBeString.length > 11 && range.length!=1){
        textField.text = [toBeString substringToIndex:11];
        return NO;
        
    }
    return YES;
    
}


//
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (isPad) {
        
        self.view.frame=CGRectMake(0, -275, WIDTH, self.view.bounds.size.height);
        
    }else{
        
        self.view.frame=CGRectMake(0, -155, WIDTH, self.view.bounds.size.height);
        
    }
    

//    if(isPad){
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect frame = self.view.frame;
//            frame.origin.y = - (self.view.size.height/6);
//            self.bigimageview.frame = CGRectMake(Width/2-75, heights+30, 40, 40);
//            self.bigimageView1.frame = CGRectMake(Width/2-20, heights+10+30,100 , 25);
//            self.view.frame = frame;
//            
//        }];
//
//    
//    }else{
//    
//        [UIView animateWithDuration:0.3 animations:^{
//            CGRect frame = self.view.frame;
//            frame.origin.y = - (self.view.size.height/6);
//            self.bigimageview.frame = CGRectMake(Width/2-75, heights-10, 40, 40);
//            self.bigimageView1.frame = CGRectMake(Width/2-20, heights,100 , 25);
//            self.view.frame = frame;
//            
//        }];
//
//    }
//    
//   
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
        
        

            self.view.frame=CGRectMake(0, 0, WIDTH, Heigh);
       
    
}
//#pragma mark textField  delagate
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//        UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height/6 * 5, WIDTH, self.view.size.height/6 * 5)];
//        aview.backgroundColor = gycoloers;
//        [self.view addSubview:aview];
//        return YES;
//}

//键盘回收
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
//记住密码
-(void)rumber:(UIButton *)sender
{
    if (recordPwd) {
    self.button.image = [UIImage imageNamed:@"mldj_icon_n03"];
        recordPwd = NO;
    }else{
    self.button.image = [UIImage imageNamed:@"mldj_icon_a03"];
        recordPwd = YES;
    }
    [self writePasswordToFile];
}
//忘记密码
-(void)forgetDidClick
{
    GJSearchPassWordController *searchVC = [[GJSearchPassWordController alloc]init];
    searchVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:searchVC animated:YES completion:nil];
}
//textField通知方法
-(void)change{
    if ([nameTextField.text isEqualToString:@""]||[pswTextField.text isEqualToString:@""]) {
        loginbutton.userInteractionEnabled = NO;
        loginbutton.alpha = 0.5;
    }else
    {
        loginbutton.userInteractionEnabled = YES;
        loginbutton.alpha = 1.0;
    }
}
//登录按钮
-(void)denglu
{

    GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
    if(!connect.connectedToNetwork)
    {
        [GJSVProgressHUD showErrorWithStatus:@"网络连接不稳定，请重试"];
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [GJSVProgressHUD showWithStatus:@"登录中"];
        loginbutton.userInteractionEnabled = NO;
        loginbutton.alpha = 0.5;
        NSLog(@"%@",[userDefaults objectForKey:@"newpassward"]);
        if ([userDefaults objectForKey:@"newpassward"])
        {
            [self MembershipInformation];
        }else
        {
//            [self MembershipInformation];

            [self newVersion];
        }
    }
}
//从plist读取数据
- (void)readUserInfoFromFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    //以上的三句话获取沙盒中data.plist的路径。
    NSMutableDictionary *saveStock = [[NSMutableDictionary alloc]initWithContentsOfFile:path];//从该路径读取文件，注意这里是读取，跟创建plist的init方法不同，看下面就知道了
    recordPwd = [[saveStock objectForKey:@"recordPwd"]boolValue];//@"recordPwd"是一个key，存到字典和从字典中取值都要用到
    if (!recordPwd)
    {
        nameTextField.placeholder = @"手机号码/用户名";
        pswTextField.placeholder = @"请输入密码";
        [saveStock removeAllObjects];//移除字典内所有元素
    }
    else{
        nameTextField.text = [saveStock objectForKey:USERNAME];
        pswTextField.text = [saveStock objectForKey:PASSWORD];
        [pswTextField setSecureTextEntry:YES];//密码设置为暗文
    }
}


//把是否记住密码信息写进data.plist文件
- (void)writePasswordToFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];//字典初始化，注意这里的init方法，跟-(void)readUserInfoFromFile方法中的字典初始化方法不同。
    if (nameTextField.text.length != 0||pswTextField.text.length != 0) {//如果输入不为空
        [data setObject:nameTextField.text forKey:USERNAME];//用户名和密码存入字典，这里的key用了宏定义，其实@"recordPwd"也可以用，在文中多次使用比较省事
        [data setObject:pswTextField.text forKey:PASSWORD];
    }
    [data setObject:[NSNumber numberWithBool:recordPwd] forKey:@"recordPwd"];
    [data writeToFile:path atomically:YES];
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

-(void)MembershipInformation
{
    //密码转md5加密
    NSString *md5password = [NSString md5HexDigest:pswTextField.text];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"login" andA:@"do_lgoin" andBodyOfRequestForKeyArr:@[@"mobile_phone",@"password"] andValueArr:@[nameTextField.text,md5password] andBlock:^(id dictionary) {
        SLog(@"dictionary___%@",dictionary);
        //获取沙盒路径
        if ([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"1"]) {
            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
            NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
            // 将返回版本号数据存进沙盒
            NSString *dataver = dictionary[@"data_ver"];
            [NSKeyedArchiver archiveRootObject:dataver toFile:path];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"user_id"]forKey:@"user_id"];
            if (dictionary[@"return_data"][@"user_info"][@"token"]) {
                [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"token"]forKey:@"token"];
                [PatrolHttpRequest checkcaptain:@{} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                    NSLog(@"%@",data);
                    NSDictionary * dic = data;
                    if (resultCode==SucceedCode) {
                        [userDefaults setObject:dic[@"iscaptain"] forKey:@"iscaptain"];
                        [userDefaults setObject:dic[@"user_id"] forKey:@"menber_id"];

                    }else{
                        NSLog(@"%@",dic);
                        [userDefaults setObject:@"3" forKey:@"iscaptain"];

                    }

                }];
            }
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"session_rndid"]forKey:@"session_key"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"mobile_phone"]forKey:@"mobile_phone"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"nick_name"]forKey:@"nick_name"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"property_name"]forKey:@"property_name"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"ture_name"]forKey:@"ture_name"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"birthday"]forKey:@"birthday"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"sex"]forKey:@"sex"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"role_name"]forKey:@"role_name"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"app_avatar_url"]forKey:@"app_avatar_url"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"avatar"]forKey:@"avatar"];
            [userDefaults setObject:dictionary[@"return_data"][@"department_info"]forKey:@"department_info"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"property_id"] forKey:@"propertyid"];
            
            NSArray *my_community =dictionary[@"return_data"][@"user_info"][@"my_community"];
            if (my_community != nil&&my_community.count>0) {

                [userDefaults setObject:my_community forKey:@"my_community"];
                //A:维修后    F:维修前   N:不需要
                
                NSString * is_autograph = dictionary[@"return_data"][@"user_info"][@"my_community"][0][@"is_autograph"];
                if (is_autograph == nil || is_autograph.length ==0) {
                    is_autograph = @"A";
                }
                [userDefaults setObject:is_autograph forKey:@"is_autograph"];
                
                NSString * isAnbao_autograph = dictionary[@"return_data"][@"user_info"][@"my_community"][0][@"isanbao_autograph"];
                if (isAnbao_autograph == nil || isAnbao_autograph.length ==0) {
                    isAnbao_autograph = @"A";
                }
                [userDefaults setObject:isAnbao_autograph forKey:@"isAnbao_autograph"];
            }
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"jpush_tag"] forKey:@"jpush_tag"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"pro_code"] forKey:@"pro_code"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"chat_pwd"] forKey:@"chat_pwd"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"chat_account"] forKey:@"chat_account"];
            [userDefaults setObject:dictionary[@"return_data"][@"user_info"][@"role"] forKey:@"role"];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            [UserDefaults setObject:arr forKey:@"MEMBERID_ARR"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getOwnerData" object:nil];

            
            //登陆成功后把用户名和密码存储到UserDefault
            NSString *username = nameTextField.text;
            NSString *password = pswTextField.text;
            [userDefaults setObject:username forKey:@"name"];
            [userDefaults setObject:password forKey:@"newpassward"];
            //这里存储是为了判断是否记住密码
            [self writePasswordToFile];
            [userDefaults synchronize];
            [self dismissViewControllerAnimated:NO completion:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"logoImage" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getuserPhoneNumber" object:nil];

            NSString *WectuserName;
            NSString *WectuserPass;
            if ([dictionary[@"return_data"][@"user_info"][@"chat_pwd"] length] == 0) {
                WectuserName = @"bbbbb";
                WectuserPass = @"040dae13ab485583f18f3efaf5bb291c";
            }else
            {
                WectuserName = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"user_info"][@"chat_account"]];
                WectuserPass = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"user_info"][@"chat_pwd"]];
                NSLog(@"____%@____%@",WectuserName,WectuserPass);
                
            }
          
            //网易云登录
//            EMError *error=[[EMClient sharedClient]loginWithUsername:WectuserName password:WectuserPass];
//            NSLog(@"%@",WectuserName);
//            NSLog(@"%@",WectuserPass);
//            if (error==nil) {
//                NSLog(@"登录成功");
//                NSMutableDictionary*dic=[[NSMutableDictionary alloc]init];
//                [dic setObject:WectuserName forKey:@"ChatUserId"];
//                [dic setObject:dictionary[@"return_data"][@"user_info"][@"nick_name"] forKey:@"ChatUserNick"];
//                [dic setObject:dictionary[@"return_data"][@"user_info"][@"avatar"]  forKey:@"ChatUserPic"];
//                [dic setObject:dictionary[@"return_data"][@"user_info"][@"session_rndid"] forKey:@"userId"];
//
//                [GJUserCacheManager saveInfo:dic];
//
//
//            }else {
//                switch (error.code)
//                {
//                    case EMErrorUserNotFound:
//                        NSLog(@"111");
//                        break;
//                    case EMErrorNetworkUnavailable:
//                        NSLog(@"444");
//                        NSLocalizedString(@"error.connectNetworkFail", @"No network connection!");
//                        break;
//                    case EMErrorServerNotReachable:
//                        NSLog(@"333");
//                        NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!");
//                        break;
//                    case EMErrorUserAuthenticationFailed:
//                        NSLog(@"222");
//                        break;
//                    case EMErrorServerTimeout:
//                        NSLog(@"55");
//                        NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!");
//                        break;
//                    case EMErrorServerServingForbidden:
//                        NSLog(@"666");
//                        NSLocalizedString(@"servingIsBanned", @"Serving is banned");
//                        break;
//                    default:
//                        NSLog(@"777");
//                        NSLocalizedString(@"login.fail", @"Login failure");
//                        break;
//                }
//            }
            
            
            NSString *str=dictionary[@"return_data"][@"user_info"][@"nick_name"];
            NSString *username111= WectuserName;
            NSString *password111= WectuserPass;

            GJAppDelegate *appDelegate = (GJAppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate startChatTimer];

            //朱滴20181012修复融云userID和缓存不一致重大bug
            [userDefaults setObject:username111 forKey:@"user_id1"];
            
            [userDefaults setBool:YES forKey:KLLRockState];
            [userDefaults setBool:YES forKey:KLLShakeState];
            [userDefaults setBool:YES forKey:KLLVoiceState];
            
            [userDefaults synchronize];
            
            [GJSVProgressHUD dismiss];
            if ([self.delegates respondsToSelector:@selector(LoginAndColse:)])
            {
                [self.delegates LoginAndColse:@"1"];
            }
            else
            {
                NSLog(@"协议方案未实现");
            }
            [[NSUserDefaults standardUserDefaults]setObject:@(YES) forKey:@"IS_LOGIN"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[XSDLocationTools shareInstance]startLocationService];
            
        }else if([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"-1"])
        {
            [GJSVProgressHUD showErrorWithStatus:@"网络不稳定，请重试"];
            loginbutton.userInteractionEnabled = YES;
            loginbutton.alpha = 1;
        }else if ([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"3"]){
            NSString *info = dictionary[@"upgrade_info"][@"info"];
            uploadUrl = dictionary[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];
        }
        else
        {
            [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
            loginbutton.userInteractionEnabled = YES;
            loginbutton.alpha = 1;
        }
        
    }];
}

-(void)newVersion
{
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"app_config" andA:@"config" andBodyOfRequestForKeyArr:@[@"data_ver"] andValueArr:@[@"0"] andBlock:^(id dictionary) {
        SLog(@"%@",dictionary);
        if ([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"-1"]) {
            [GJSVProgressHUD dismiss];
            [GJSVProgressHUD showErrorWithStatus:@"网络不稳定，请重试"];

//            [GJSVProgressHUD showErrorWithStatus:@"网络故障,请检查您的网络!"];
//            [GJSVProgressHUD showErrorWithStatus:@"请重试"];
        }else if ([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"1"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:dictionary[@"return_data"][@"app_url"][@"app_image_url"]forKey:@"app_image_url"];
            [defaults setObject:dictionary[@"return_data"][@"app_url"][@"app_avatar_url"]forKey:@"app_avatar_url"];
            [defaults setObject:dictionary[@"return_data"][@"app_url"][@"app_video_url"]forKey:@"app_video_url"];
            [defaults setObject:dictionary[@"return_data"][@"app_url"][@"app_voice_url"]forKey:@"app_voice_url"];
            [defaults setObject:dictionary[@"return_data"][@"attendance"]forKey:@"attendance"];
//            [defaults setObject:dictionary[@"return_data"][@"gps_location"]forKey:@"gps_location"];
            [defaults setObject:dictionary[@"return_data"][@"pca"]forKey:@"pca"];
            [defaults setObject:dictionary[@"return_data"][@"attendance"][@"onwork_time"] forKey:@"onwork_time"];
            [defaults setObject:dictionary[@"return_data"][@"attendance"][@"offwork_time"] forKey:@"offwork_time"];
            [defaults synchronize];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self MembershipInformation];
            });
        } else if ([[NSString stringWithFormat:@"%@",dictionary[@"state"]] isEqualToString:@"3"])
        {
            
            [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
            
        }
        else
        {
            [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
        }
        loginbutton.userInteractionEnabled = YES;
        loginbutton.alpha = 1;
    }];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==9996) {
        if (buttonIndex==0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO]) {
                
                NSDictionary *dic=[[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
            }
            
        }
    }
    else{
    
    
    if (buttonIndex == 0) {
        [GJSVProgressHUD dismiss];
        loginbutton.userInteractionEnabled = YES;
        loginbutton.alpha = 1;
        [self.shengjialert removeFromSuperview];
    }else
    {
        [GJSVProgressHUD dismiss];
        //升级
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:uploadUrl]];
    }
    }
}

- (void) alertToUpMsg:(NSString *) str withDelegate:(id) delegate{//点击升级
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9996;
    
}




@end
