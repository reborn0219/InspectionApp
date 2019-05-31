//
//  GJFeedbackViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/6.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFeedbackViewController.h"

@interface GJFeedbackViewController ()<UITextViewDelegate>
{
    UILabel *label;
    UITextView *opinionView;
    UITextField *Phonenumtext;
}

@end

@implementation GJFeedbackViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titlelable = [UILabel lableWithName:@"意见反馈"];
    self.navigationItem.titleView = titlelable;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //右侧导航栏按钮
    UIButton *rightbutton = [UIButton rightbuttonwithtitleName:@"提交" target:self action:@selector(submitDidClicked)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.view.backgroundColor = viewbackcolor;
    [self createdUI];
}

-(void)createdUI
{
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 120)];
    textView.backgroundColor = [UIColor whiteColor];
    opinionView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, textView.size.width - 20, 120)];
    opinionView.backgroundColor = [UIColor clearColor];
    opinionView.font = [UIFont fontWithName:geshi size:15];
    opinionView.delegate = self;
    label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    label.enabled = NO;
    label.text = @"请在此输入反馈意见";
    label.font =  [UIFont systemFontOfSize:15];
    label.textColor = gycoloer;
    
    
    UIView *PhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, WIDTH, 40)];
    PhoneView.backgroundColor = [UIColor whiteColor];
    Phonenumtext = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, PhoneView.size.width - 20, 40)];
    Phonenumtext.backgroundColor = [UIColor clearColor];
    Phonenumtext.font = [UIFont fontWithName:geshi size:15];
    Phonenumtext.placeholder = @"请输入联系方式";
    Phonenumtext.keyboardType = UIKeyboardTypeNumberPad;
    Phonenumtext.textColor = gycoloer;
    Phonenumtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    [PhoneView addSubview:Phonenumtext];
    [opinionView addSubview:label];
    [self.view addSubview:PhoneView];
    [textView addSubview:opinionView];
    [self.view addSubview:textView];
}
#pragma mark- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
    }
}


-(void)submitDidClicked
{
    if(![self connectedToNetwork])
    {
        [GJSVProgressHUD showErrorWithStatus:@"网络异常"];
    }else{
        if (opinionView.text.length!=0) {
        if ([self validateMobile:Phonenumtext.text]) {
            GJLCLNetWork *notwork=[[GJLCLNetWork alloc]init];
            [notwork submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"feedback" andBodyOfRequestForKeyArr:@[@"feedback[content]",@"feedback[contact]"] andValueArr:@[opinionView.text,Phonenumtext.text] andBlock:^(id dictionary){
                NSLog(@"%@",dictionary);
                            [GJSVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]];
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            
            //写提交反馈信息
        }else
        {
            [GJSVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        }
    }else{
//        self.navigationItem.rightBarButtonItem.enabled=NO;
        [GJSVProgressHUD showErrorWithStatus:@"请输入您要反馈的意见"];
    }
    }
}
//判断网络状况
-(BOOL) connectedToNetwork
{
   
    return YES ;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
