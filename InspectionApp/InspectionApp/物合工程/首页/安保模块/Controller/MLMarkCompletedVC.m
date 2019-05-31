//
//  MLMarkCompletedVC.m
//  物联宝管家
//
//  Created by yang on 2019/1/16.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "MLMarkCompletedVC.h"


#import "GJExecutedFishViewController.h"
#define imageButtonW (WIDTH - 50)/4
#import "GJSDAdScrollView.h"
#import "GJExecutedFishTableViewCell.h"
#import "GJSYDatePicker.h"
#import "GJExecutedFishTableViewCells.h"
#import "GJQMViewController.h"
@interface MLMarkCompletedVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,SYDatePickerDelegate>
{
    BOOL CellISOpen;
    BOOL ISMoney;
    UIImageView *Fouthimageview;
    //输入问题描述
    UITextView *opinionView;
    UILabel *questlable;
    //线
    UILabel *linesLable;
    NSInteger *lineHeight;
    UIImageView *moneyImageView;
    UIImageView *WeChatImageView;
    UILabel *rightOneLable;
    UILabel *rightTwoLable;
    //区别是进户时间还是出户时间
    NSInteger comeOutTag;
    BOOL ISOpen;
    UILabel *MaterialScienceLable;
    UIButton *MoneydisCoverButton;
    NSString *MaterialMoney;
    NSString *personMoney;
    UITextField *moneyText;
    NSString *AllMoneyStr;
    float floatMaterialMoney;
    float floatpersonMoney;
    NSString *weichatmoneyPay;
    int height;
    UIView *moneyView;
    NSString *moneya;
    NSString *moneyb;
    NSString *moneyc;
    int voiceLength;
    
    int phoneNumber;
    int userPhoneNumber;
}
@property(nonatomic,strong)UITableView *tableview;
@property GJSYDatePicker *picker;

@end

@implementation MLMarkCompletedVC
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //增加监听，当键弹起时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wageFirstkeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wageFirstkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UILabel *titlelable = [UILabel lableWithName:@"标记完工"];
    self.navigationItem.titleView = titlelable;
    self.view.backgroundColor = viewbackcolor;
    UIButton *rightbutton = [UIButton rightbuttonwithtitleName:@"提交" target:self action:@selector(SubmitDidClicked)];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightBtn;
    CellISOpen = YES;
    ISMoney = NO;
    ISOpen = YES;
    weichatmoneyPay = @"扫码支付";
    self.tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableview.backgroundColor = viewbackcolor;
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.view = self.tableview;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)SubmitDid
{
    GJQMViewController *qm=[[GJQMViewController alloc]init];
    NSLog(@"%@",rightOneLable.text);
    qm.isAnbao = YES;
    qm.WGDic=@{
               @"repair_id" : self.repairdIDStr,
               @"come_in_time" : rightOneLable.text,
               @"come_out_time" : rightTwoLable.text,
               @"material_fee" : moneyb,
               @"work_remarks" : opinionView.text,
               @"paid_type" : weichatmoneyPay,
               };
    [self.navigationController pushViewController:qm animated:YES];
}
//返回cell行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//返回headview高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 210;
    }else
    {
        return 40;
    }
}
//返回cell行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    {
        if (ISOpen == YES) {
            return 3;
        }else
        {
            return 0;
            
        }
    }
}
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

//headView 的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 210)];
        oneView.backgroundColor = [UIColor whiteColor];
        UIButton *comeinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        comeinButton.backgroundColor = [UIColor clearColor];
        UIButton *outButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 40)];
        outButton.backgroundColor = [UIColor clearColor];
        comeinButton.tag = 1200;
        outButton.tag =  1201;
        [comeinButton addTarget:self action:@selector(TimeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [outButton addTarget:self action:@selector(TimeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *leftOneLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, WIDTH/2 - 15, 39.5)];
        leftOneLable.textColor = gycoloer;
        leftOneLable.textAlignment = NSTextAlignmentLeft;
        leftOneLable.font = [UIFont fontWithName:geshi size:14];
        leftOneLable.text = @"服务开始时间";
    
        UILabel *lineLable1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 39.5, WIDTH - 15, 0.5)];
        lineLable1.backgroundColor = gycoloers;
        
        UILabel *leftTwoLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, WIDTH/2 - 15, 39.5)];
        leftTwoLable.textColor = gycoloer;
        leftTwoLable.textAlignment = NSTextAlignmentLeft;
        leftTwoLable.font = [UIFont fontWithName:geshi size:14];
        leftTwoLable.text = @"服务结束时间";
        UILabel *lineLable2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 39.5, WIDTH - 15, 0.5)];
        lineLable2.backgroundColor = gycoloers;
        
        UILabel *leftThreeLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 80, WIDTH/2 - 15, 30)];
        leftThreeLable.textColor = gycoloer;
        leftThreeLable.textAlignment = NSTextAlignmentLeft;
        leftThreeLable.font = [UIFont fontWithName:geshi size:14];
        leftThreeLable.text = @"工作备忘";
        
        rightOneLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 10, WIDTH/2 - 30, 20)];
        rightOneLable.textColor = gycoloer;
        //开始时间
        GJYTKKeyValueStore *store = [[GJYTKKeyValueStore alloc] initDBWithName:@"repaird.db"];
        NSString *tableName = repaird_table;
        [store createTableWithName:tableName];
        NSDictionary *queryUser = [store getObjectById:_repairdIDStr fromTable:tableName];
        rightOneLable.text = queryUser[Start_Time];
        rightOneLable.textAlignment = NSTextAlignmentRight;
        rightOneLable.font = [UIFont fontWithName:geshi size:14];
        
        //结束时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *overTime = [formatter stringFromDate:[NSDate date]];
        
        
        rightTwoLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 10, WIDTH/2 - 30, 20)];
        rightTwoLable.text=overTime;
        rightTwoLable.textColor = gycoloer;
        rightTwoLable.textAlignment = NSTextAlignmentRight;
        rightTwoLable.font = [UIFont fontWithName:geshi size:14];
        
        UIImageView *rightImageViewOne = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 25, 12.5, 15, 15)];
        rightImageViewOne.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
        
        UIImageView *rightimageViewTwo = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 25, 12.5, 15, 15)];
        rightimageViewTwo.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
        
        
        
        
        opinionView = [[UITextView alloc]initWithFrame:CGRectMake(15, 115, W - 40, 80)];
        opinionView.backgroundColor = [UIColor clearColor];
        opinionView.font = [UIFont fontWithName:geshi size:17];
        opinionView.delegate = self;
        opinionView.returnKeyType  = UIReturnKeyDone;
        
        
        questlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 200, 20)];
        questlable.enabled = NO;
        questlable.text = @"请在此输入工作备忘";
        questlable.font =  [UIFont fontWithName:geshi size:14];
        questlable.textColor = gycoloer;
        
        [opinionView addSubview:questlable];
        
        UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 209.5, WIDTH, 0.5)];
        downLineLable.backgroundColor = gycoloers;
        [comeinButton addSubview:leftOneLable];
        [comeinButton addSubview:lineLable1];
        [comeinButton addSubview:rightOneLable];
        [comeinButton addSubview:rightImageViewOne];
        [outButton addSubview:leftTwoLable];
        [outButton addSubview:lineLable2];
        [outButton addSubview:rightTwoLable];
        [outButton addSubview:rightimageViewTwo];
        [oneView addSubview:comeinButton];
        [oneView addSubview:outButton];
        [oneView addSubview:downLineLable];
        [oneView addSubview:leftThreeLable];
        [oneView addSubview:opinionView];
        
        UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(15, 115, WIDTH-15, 0.5)];
        lin.backgroundColor=gycoloers;
        [oneView addSubview:lin];
        
        return oneView;
    }else
    {
        
        UIButton *secondView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        secondView.backgroundColor = [UIColor whiteColor];
        UILabel *UplineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
        UplineLable.backgroundColor = gycoloers;
        [secondView addTarget:self action:@selector(secondViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
        Fouthimageview  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
        if (ISOpen == YES) {
            Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
        }else
        {
            Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
        }
        UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH, 39.5)];
        alable.textColor = gycolor;
        alable.textAlignment = NSTextAlignmentLeft;
        alable.font = [UIFont fontWithName:geshi size:17];
        alable.text = @"费用金额";
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, WIDTH, 0.5)];
        lineLable.backgroundColor = gycoloers;
        [secondView addSubview:Fouthimageview];
        [secondView addSubview:lineLable];
        [secondView addSubview:UplineLable];
        [secondView addSubview:alable];
        return secondView;
    }
    
    
}
//返回尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else
    {
        return 0;
    }
}
//返回cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *namearray = [NSArray array];
    namearray = @[@"服务费用",@"住户承担金额"];
    if (indexPath.row < 2) {
        GJExecutedFishTableViewCell *ExecutedFishTableViewCell = [GJExecutedFishTableViewCell createCellWithTableView:tableView withIdentifier:@"FishTableViewCellflag"];
        ExecutedFishTableViewCell.leftLable.text = namearray[indexPath.row];
        
        if (indexPath.row == 0)
        {
            ExecutedFishTableViewCell.rightLable.text = personMoney;
            ExecutedFishTableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            
        }else if(indexPath.row == 1)
        {
            ExecutedFishTableViewCell.rightLable.text = AllMoneyStr;
            ExecutedFishTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return ExecutedFishTableViewCell;
    }else
    {
        GJExecutedFishTableViewCells *ExecutedFishTableViewCells = [GJExecutedFishTableViewCells createCellWithTableView:tableView withIdentifier:@"FishTableViewCellflags"];
        ExecutedFishTableViewCells.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *moneyButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2 - 15, 0, 100, 39.5)];
        moneyButton.backgroundColor = [UIColor clearColor];
        [moneyButton addTarget: self action:@selector(moneyButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [moneyImageView removeFromSuperview];
        moneyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        if (ISMoney == YES) {
            [moneyImageView setImage:[UIImage imageNamed:@"sysiocn-2x20"]];
        }else
        {
            [moneyImageView setImage:[UIImage imageNamed:@"sysiocn-2x21"]];
        }
        UILabel *moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 75, 39.5)];
        moneyLable.textColor = gycoloer;
        moneyLable.font = [UIFont fontWithName:geshi size:14];
        moneyLable.text = @"现金支付";
        [moneyButton addSubview:moneyImageView];
        [moneyButton addSubview:moneyLable];
        
        UIButton *weChatButton = [[UIButton alloc]initWithFrame:CGRectMake(W - 90, 0, 80, 39.5)];
        [weChatButton addTarget:self action:@selector(wechatButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        weChatButton.backgroundColor = [UIColor clearColor];
        [WeChatImageView removeFromSuperview];
        WeChatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        if (ISMoney == NO) {
            [WeChatImageView setImage:[UIImage imageNamed:@"sysiocn-2x20"]];
        }else
        {
            
            [WeChatImageView setImage:[UIImage imageNamed:@"sysiocn-2x21"]];
        }
        UILabel *WeChatLable = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 75, 39.5)];
        WeChatLable.textColor = gycoloer;
        WeChatLable.font = [UIFont fontWithName:geshi size:14];
        WeChatLable.text = @"在线支付";
        [weChatButton addSubview:WeChatImageView];
        [weChatButton addSubview:WeChatLable];
//        [ExecutedFishTableViewCells addSubview:moneyButton];
        [ExecutedFishTableViewCells addSubview:weChatButton];
        return ExecutedFishTableViewCells;
        
    }
}
//cell被选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MoneydisCoverButton  = [[UIButton alloc]initWithFrame:window.frame];
        MoneydisCoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        [MoneydisCoverButton addTarget:self action:@selector(MoneydisCoverButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        moneyView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2 - 140, HEIGHT/2 - 90, 280, 180)];
        moneyView.backgroundColor = [UIColor whiteColor];
        moneyView.layer.cornerRadius = 8;
        moneyView.layer.masksToBounds = YES;
        moneyView.layer.borderWidth = 0.5;
        moneyView.layer.borderColor = gycoloers.CGColor;
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, moneyView.width, 40)];
        titleLable.textColor = gycolor;
        titleLable.font = [UIFont fontWithName:geshi size:15];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"请选择支付金额";
        moneyText  = [[UITextField alloc]initWithFrame:CGRectMake(moneyView.width/2 - 100, 60, 200, 40)];
        moneyText.textColor = gycolor;
        moneyText.keyboardType = UIKeyboardTypeDecimalPad;
        moneyText.textAlignment = NSTextAlignmentCenter;
        moneyText.font = [UIFont fontWithName:geshi size:15];
        moneyText.layer.cornerRadius = 5;
        moneyText.layer.borderWidth = 1;
        moneyText.layer.borderColor = gycoloer.CGColor;
        [moneyText becomeFirstResponder];
        
        UIButton *yesButton = [[UIButton alloc]initWithFrame:CGRectMake(moneyView.width/2 - 80, 120, 160, 40)];
        yesButton.tag = indexPath.row + 1000;
        [yesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
        [yesButton setTitle:@"确定" forState:UIControlStateNormal];
        [yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [yesButton addTarget:self action:@selector(yesButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [moneyView addSubview:titleLable];
        [moneyView addSubview:moneyText];
        [moneyView addSubview:yesButton];
        [MoneydisCoverButton addSubview:moneyView];
        [window addSubview:MoneydisCoverButton];
    }
}

-(void)secondViewDidClicked
{
    if (ISOpen == YES) {
        ISOpen = NO;
    }else
    {
        ISOpen = YES;
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
//付款方式点击事件
//现金支付
-(void)moneyButtonDidClicked
{
    ISMoney = YES;
    weichatmoneyPay = @"现金支付";
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

//微信支付
-(void)wechatButtonDidClicked
{
    ISMoney = NO;
    weichatmoneyPay = @"扫码支付";
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //    if (AllMoneyStr == nil) {
    //        [GJSVProgressHUD showErrorWithStatus:@"请输入支付金额"];
    //    }else{
    //        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    //        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_qrc" andBodyOfRequestForKeyArr:@[@"rep[repair_id]",@"rep[total_cost]"] andValueArr:@[self.repairdIDStr,AllMoneyStr] andBlock:^(id dictionary)
    //         {
    //             NSLog(@"%@,%@",self.repairdIDStr,AllMoneyStr);
    //             NSLog(@"dictionary____%@",dictionary);
    //             NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
    //             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
    //                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
    //                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
    //                     [self presentViewController:loginVC animated:YES completion:nil];
    //                 });
    //             }
    //             else if([state isEqualToString:@"0"])
    //             {
    //                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
    //             }else if ([state isEqualToString:@"-1"])
    //             {
    //                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
    //             }
    //             else if([state isEqualToString:@"1"])
    //             {
    //
    //                 UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //                 UIButton *disCoverButton = [[UIButton alloc]initWithFrame:window.frame];
    //                 disCoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    //                 [disCoverButton addTarget:self action:@selector(discoverDisMiss:) forControlEvents:UIControlEventTouchUpInside];
    //                 UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 120, HEIGHT/2 - 120, 240, 240)];
    //                 [imageView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"return_data"]] placeholderImage:[UIImage imageNamed:@"100x100"]];
    //                 [disCoverButton addSubview:imageView];
    //                 [window addSubview:disCoverButton];
    //                 NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:1];
    //                 [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //             }
    //         }];
    //    }
}

-(void)discoverDisMiss:(UIButton *)sender
{
    [sender removeFromSuperview];
}
//问题描述代理事件
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [questlable setHidden:NO];
    }else{
        [questlable setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)ImageDisMiss:(UIButton *)sender
{
    [sender removeFromSuperview];
}
//进出户时间选择
-(void)TimeButtonDidClicked:(UIButton *)sender
{
    comeOutTag = sender.tag;
    if (!self.picker) {
        self.picker = [[GJSYDatePicker alloc] init];
    }
    
    [self.picker showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) andDatePickerMode:UIDatePickerModeDateAndTime];
    self.picker.delegate = self;
}
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm";
    if (comeOutTag == 1200) {
        rightOneLable.text = [fm stringFromDate:date];
    }else if(comeOutTag == 1201)
    {
        rightTwoLable.text = [fm stringFromDate:date];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.picker dismiss];
}
-(void)SubmitDidClicked
{
    if (rightOneLable.text.length == 0) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择服务开始时间！"];
    }else if(rightTwoLable.text.length == 0)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请选择服务结束时间！"];
    }else if (personMoney == nil)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入服务费用！"];
        
    }else
    {
        [self SubmitDid];
        //        [GJSVProgressHUD showWithStatus:@"提交中"];
        //        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        //        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"edit_finished" andBodyOfRequestForKeyArr:@[@"rep[repair_id]",@"rep[come_in_time]",@"rep[come_out_time]",@"rep[finished_time]",@"rep[service_charge]",@"rep[material_fee]",@"rep[owner_cost]",@"rep[work_remarks]",@"rep[paid_type]"] andValueArr:@[self.repairdIDStr,rightOneLable.text,rightTwoLable.text,@"",moneya,moneyb,moneyc,opinionView.text,weichatmoneyPay] andBlock:^(id dictionary)
        //         {
        //             NSLog(@"%@",dictionary);
        //             NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
        //             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
        //                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
        //                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
        //                     [self presentViewController:loginVC animated:YES completion:nil];
        //                 });
        //             }
        //             else if([state isEqualToString:@"0"])
        //             {
        //                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
        //             }else if ([state isEqualToString:@"-1"])
        //             {
        //                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
        //             }else if ([state isEqualToString:@"1"])
        //             {
        //                 [GJSVProgressHUD dismiss];
        //                 [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
        //                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ExecutedfishWage" object:nil];
        //                 [self.navigationController popToRootViewControllerAnimated:YES];
        //             }
        //         }];
    }
    
}
-(void)MoneydisCoverButtonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}
-(void)yesButtonDidClicked:(UIButton *)sender
{
    
   if(sender.tag == 1000){
        if (moneyText.text.length == 0) {
            [GJSVProgressHUD showErrorWithStatus:@"请输入支付金额！"];
        }else
        {
            moneyb = moneyText.text;
            personMoney = [NSString stringWithFormat:@"￥%@",moneyText.text];
            floatpersonMoney = [moneyText.text floatValue];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    float allmoney = floatpersonMoney + floatMaterialMoney;
    moneyc =  [NSString stringWithFormat:@"%.2f",allmoney];
    AllMoneyStr = [NSString stringWithFormat:@"￥%.2f",allmoney];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [MoneydisCoverButton removeFromSuperview];
    
}
////当键盘出现或改变时调用
- (void)wageFirstkeyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    height = keyboardRect.size.height;
    CGRect Frame = CGRectMake (WIDTH/2 - 140, HEIGHT - height - 180, 280, 180);
    [moneyView setFrame: Frame];
}

//输入结束
- (void)wageFirstkeyboardWillHide:(NSNotification *)aNotification
{
    CGRect Frame = CGRectMake (WIDTH/2 - 140, HEIGHT/2 - 90, 280, 180);
    [moneyView setFrame: Frame];
}



@end
