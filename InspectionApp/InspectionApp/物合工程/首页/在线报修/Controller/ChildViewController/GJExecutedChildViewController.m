//
//  GJExecutedChildViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedChildViewController.h"
#import "GJExecutedChildTableViewCell.h"
#define imageButtonW (WIDTH - 50)/4
#import "GJSDAdScrollView.h"
#import "GJExecutedChildTwoTableViewCell.h"
#import "GJCuiPickerView.h"
#import "GJFZPWorkMenus.h"
#import "GJAllWageViewController.h"

#import "GJCommunityModel.h"

@interface GJExecutedChildViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,AVAudioPlayerDelegate,CuiPickViewDelegate,worknameIDDelegates,UIAlertViewDelegate>
{
    BOOL ISOpenOne;
    BOOL ISOpenTwo;
    CGFloat cellHeight;
    UIImageView *Fouthimageview;
    UIImageView *FiveImageView;
    //存储相片视频音频
    NSDictionary *Datadict;
    //存储数据源数量
    NSMutableArray *allDataArray;
    //图片数(为了点击显示存储)
    NSMutableArray *imagedataArray;
    //图片数（为了展示存储）
    NSMutableArray *ShowImageDataArray;
    //视频数()
    NSMutableArray *videoDataArray;
    //视频图片
    NSMutableArray *videoImageArray;
    //音频数
    NSMutableArray *voiceDataArray;
    //音频时间
    NSMutableArray *voiceTimeArray;
    //视频和图片数据
    NSMutableArray *videoimageDataArray;
    //存储图片URL
    NSMutableArray *imageURLArray;
    NSArray *scrollerArray;
    //存放整体图片
    NSMutableArray *allDataImageArray;
    //输入问题描述
    UITextView *opinionView;
    UILabel *questlable;
    //线
    UILabel *linesLable;
    NSInteger *lineHeight;
    UIButton *backButtonView;
    UILabel *personLable;
    //转移工单view
    UIView *transferView;
    UILabel *appointtimeLable;
    UITextField *placeLables;
    int height;
    
    //标记无效view
    UIView *invalidView;
    
    UITextView *apportionView;
    UITextField *appointLable;
    BOOL _wasKeyboardManagerEnabled;
    
    //    //音频Url
    NSString *VoiceUrl;
    //    //音频时间
    UILabel *voiceTimeLable;
    //    //播放音频按钮
    UIButton *PlayVoiceButton;
    NSTimer *timer;
    float times;
    NSMutableArray *workNameArray;
    NSMutableArray *workID;
    NSArray *worknamearray;
    NSArray *workidarray;
    UILabel *worktimelable;
    UIWindow *window;
    NSString *state;
    //    //报修ID
    NSString *theworkID;
    int thetime;
    //音频时间
    NSString *voicetimelables;
    NSString *voicetimes;
    UIButton *discoverButton;
    int thetimes;
    UIImageView *VoiceImageView;
    BOOL ISTIMERSTR;
    int buttonTage;
    UILabel *timeLable;
    int voiceLength;
    NSTimer *changeVoiceTimer;
    int changeimagetime;
    //
    //    int phoneNumber;
    //    int userPhoneNumber;
    GJExecutedChildTwoTableViewCell *bcell;
    CGFloat QMHeight;

    NSInteger Srow;
    NSString * autograph;

}
@property (nonatomic, strong)GJCuiPickerView *cuiPickerView;
@property(nonatomic,strong)UIButton *cuiPickerViewdiscoverButton;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;


@property(nonatomic,strong)UITableView *GRtableview;

@end
////处理中工单页面
@implementation GJExecutedChildViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self getMaintenancemaster];
    autograph = [UserDefaults objectForKey:@"is_autograph"];
    if (_isAnBao) {
        autograph = [UserDefaults objectForKey:@"isAnbao_autograph"];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    //结束定时器
    [timer invalidate];
    [changeVoiceTimer invalidate];
    
    [self.audioPlayer stop];
    ISTIMERSTR = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    Srow=0;

    //    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    //    userPhoneNumber = [[userdefaults objectForKey:@"name"] integerValue];
    _cuiPickerView = [[GJCuiPickerView alloc]init];
    _cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    _cuiPickerView.backgroundColor = [UIColor whiteColor];
    _cuiPickerView.delegate = self;
    _cuiPickerView.curDate=[NSDate date];
    window = [UIApplication sharedApplication].keyWindow;
    _cuiPickerViewdiscoverButton = [[UIButton alloc]initWithFrame:window.frame];
    _cuiPickerViewdiscoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    _wasKeyboardManagerEnabled = [[GJIQKeyboardManager sharedManager] isEnabled];
    [[GJIQKeyboardManager sharedManager] setEnable:NO];
    //增加监听，当键弹起时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UILabel *titlelable = [UILabel lableWithName:@"工单详情"];
    self.navigationItem.titleView = titlelable;
    self.view.backgroundColor = viewbackcolor;
    ISTIMERSTR = NO;
    
    
    //右侧导航栏按钮
//    UIButton *rightbutton = [UIButton rightbuttonwithimageName:@"sysicon_n_66@2x (2)" target:self action:@selector(mattersDidClicked)];
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
    ISOpenOne = YES;
    ISOpenTwo = YES;
    self.tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableview.backgroundColor = viewbackcolor;
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.view = self.tableview;
    [self reloadData];
}
//返回headView行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_GRtableview==tableView) {
        return 1;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        return 4;
    }else
    {
        return 5;
        
    }
}

//返回headview高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    if (_GRtableview==tableView) {
        return 0;
    }
    
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (section == 0)
        {
            
            if ([autograph isEqualToString:@"F"]) {
                return 120+QMHeight+50;
                
            }else{
                return 120+50;
            }
        }else if (section == 3)
        {
            return WIDTH - 60;
        }
        else
        {
            return 40;
        }
    }else
    {
        if (section == 0) {
            return 68;
        }else if (section == 1)
        {
            if ([autograph isEqualToString:@"F"]) {
                return 80+QMHeight+50;
                
            }else{
                return 80+50;
                
            }

        }else if (section == 4)
        {
            return WIDTH - 60;
        }
        else
        {
            return 40;
        }
    }
    
}
//返回cell行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_GRtableview==tableView) {
        return workNameArray.count;
    }
    
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (section == 1) {
            if (ISOpenOne == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }else if (section == 2)
        {
            if (ISOpenTwo == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }
        else
        {
            return 0;
        }
        
    }
    else
    {
        if (section == 2) {
            if (ISOpenOne == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }else if (section == 3)
        {
            if (ISOpenTwo == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }
        else
        {
            return 0;
        }
        
    }
    
}
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_GRtableview==tableView) {
        return 45;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        if (indexPath.section == 1) {
            return cellHeight + 40+30;//加上报修的高度20
        }else if(indexPath.section == 2)
        {
            return 120;
        }else
        {
            return 0;
        }
        
    }else
    {
        if (indexPath.section == 2) {
            return cellHeight + 40+30+60;//加上报修的高度20
        }else if(indexPath.section == 3)
        {
            return 120;
        }else
        {
            return 0;
        }
        
    }
}
//返回尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_GRtableview==tableView) {
        return 0;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        if (section == 0) {
            return 8;
        }else
        {
            return 0;
        }
    }else{
        if (section == 0 || section == 1) {
            return 8;
        }else
        {
            return 0;
        }
    }
}

//headView 的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        if(section == 0)
        {
            
            
            UIView *threeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
            threeView.backgroundColor = [UIColor whiteColor];
            
            UILabel *gongg = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, W, 40)];
            gongg.textColor = gycolor;
            gongg.textAlignment = NSTextAlignmentCenter;
            gongg.text = @"公共区域报事工单";
            gongg.font = [UIFont fontWithName:geshi size:16];
            
            
            UIView *buttonV=[[UIView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, 50)];
            buttonV.backgroundColor=viewbackcolor;
            [threeView addSubview:buttonV];
            
            NSArray  *namearray = @[@"标记完工",@"工单转移",@"标记无效"];
            
            for (int i=0; i<3; i++) {
                
                
                UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(10+10*i+(W-40)/3*i, 0, (W-40)/3, 40)];
                if (i==0 || i==1) {
                    
                    abutton.backgroundColor = NAVCOlOUR;
                    
                }else{
                    
                    abutton.backgroundColor = gycoloer;
                    
                }
                abutton.clipsToBounds=YES;
                abutton.layer.cornerRadius=5;
                [abutton addTarget:self action:@selector(wageTypeDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                abutton.tag = i;
                [abutton setTitle:namearray[i] forState:UIControlStateNormal];
                [abutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [buttonV addSubview:abutton];

                
            }
            
            
            UILabel *workTypeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 40+50, W, 40)];
            workTypeLable.textColor = gycolor;
            workTypeLable.textAlignment = NSTextAlignmentLeft;
            workTypeLable.text = @"工作性质 : 公共区域报修";
            workTypeLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *lineLbale = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5+50, WIDTH - 10, 0.5)];
            lineLbale.backgroundColor = gycoloers;
            
            UILabel *lineLbale1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 79.5+50, WIDTH - 10, 0.5)];
            lineLbale1.backgroundColor = gycoloers;
            
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 90+50, W, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:15];
            
            topLable.textColor = gycolor;
            
            
            
            
            if ([autograph isEqualToString:@"F"]) {
                UIView *QMview=[[UIView alloc]initWithFrame:CGRectMake(0,110+20+50 , WIDTH, WIDTH-40)];
                QMview.backgroundColor=[UIColor whiteColor];
                [threeView addSubview:QMview];
                UIImageView *NameImg=[[UIImageView alloc]init];
                UILabel *kf=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, W, 20)];
                kf.text=@"客户签名 :";
                kf.font= [UIFont fontWithName:geshi size:15];
                kf.textColor=gycolor;
                kf.textAlignment=NSTextAlignmentLeft;
                [QMview addSubview:kf];
                
                [NameImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_receiveDataDic[@"repaird"][@"autograph"]]]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_receiveDataDic[@"repaird"][@"autograph"]]];
                UIImage *Tuimage = [UIImage imageWithData:data];
                
                if (Tuimage.size.width>WIDTH-40) {
                    QMview.frame=CGRectMake(0, 110+50, WIDTH, (WIDTH-40)/(Tuimage.size.width/Tuimage.size.height )+20+20);
                    NameImg.frame=CGRectMake(0,30, WIDTH-40,(WIDTH-40)/(Tuimage.size.width/Tuimage.size.height ) );
                    QMHeight=(WIDTH-40)/(Tuimage.size.width/Tuimage.size.height )+20+20;
                    
                }else{
                    QMview.frame=CGRectMake(0, 110+50, WIDTH, Tuimage.size.height+20+20);
                    
                    NameImg.frame=CGRectMake(0,30, Tuimage.size.width,Tuimage.size.height);
                    QMHeight=Tuimage.size.height+20+20;
                }
                NSLog(@"%f",Tuimage.size.width);
                NameImg.centerX=QMview.centerX;
                
                [QMview addSubview:NameImg];
                
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
            
            [threeView addSubview:gongg];
            
            [threeView addSubview:lineLbale];
            
            [threeView addSubview:topLable];
            
            [threeView addSubview:lineLbale1];
            
            [threeView addSubview:workTypeLable];
            
            return threeView;
            
            
        }
        else if(section == 1)
        {
            
            UIButton *fouthView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            fouthView.backgroundColor = [UIColor whiteColor];
            [fouthView addTarget:self action:@selector(exeFouthViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *wagedetails = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            wagedetails.text = @"工单详情";
            wagedetails.textColor = gycolor;
            wagedetails.font = [UIFont fontWithName:geshi size:17];
            
            UIImageView *yuanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            yuanImageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1,  15)];
            lineLable.backgroundColor = gycoloers;
            
            //            报修时间
            //            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, WIDTH - 160, 20)];
            //            naturelables.textAlignment = NSTextAlignmentRight;
            //            naturelables.text = _receiveDataDic[@"post_time"];
            //            naturelables.font = [UIFont fontWithName:geshi size:13];
            //            naturelables.textColor = gycoloer;
            
            UILabel *upline = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, W, 0.5)];
            upline.backgroundColor = gycoloers;
            UILabel *buttomLine = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, W, 0.5)];
            buttomLine.backgroundColor = gycoloers;
            Fouthimageview  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenOne == YES) {
                Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [fouthView addSubview:lineLable];
            [fouthView addSubview:yuanImageView];
            [fouthView addSubview:Fouthimageview];
            
            //            保修时间
            //            [fouthView addSubview:naturelables];
            [fouthView addSubview:wagedetails];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            return fouthView;
        }else if (section == 3)
        {
            UIView * wageimageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
            wageimageView.backgroundColor = [UIColor whiteColor];
            UIImageView *wageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, WIDTH - 100, WIDTH - 100)];
            [wageImageView sd_setImageWithURL:[NSURL URLWithString:_receiveDataDic[@"repair_qrcode"]] placeholderImage:[UIImage imageNamed:@"100x100"]];
            [wageimageView addSubview:wageImageView];
            UILabel *wageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(wageImageView.frame), WIDTH, 20)];
            wageLable.text = @"工单二维码";
            wageLable.textAlignment = NSTextAlignmentCenter;
            wageLable.font = [UIFont fontWithName:geshi size:14];
            [wageimageView addSubview:wageLable];
            return wageimageView;
        }else
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(exeFiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"执行情况 ";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x43"];
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            FiveImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10,20, 20)];
            if (ISOpenTwo == YES) {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [FiveView addSubview:lineLable];
            [FiveView addSubview:imageView];
            [FiveView addSubview:FiveImageView];
            [FiveView addSubview:linelable];
            [FiveView addSubview:alable];
            return FiveView;
        }
        
    }else
    {
        if(section == 0)
        {
            UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 68)];
            twoView.backgroundColor = [UIColor whiteColor];
            UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 8)];
            aview.backgroundColor = viewbackcolor;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 50, 50)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_receiveDataDic[@"user_info"][@"avatar"]]placeholderImage:[UIImage imageNamed:@"100x100"]];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(65, 18, WIDTH - 50, 20)];
            UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(65, 43, WIDTH - 50, 20)];
            UILabel *upslable = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, WIDTH, 0.5)];
            upslable.backgroundColor = gycoloers;
            UILabel *downsLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 67.5, WIDTH, 0.5)];
            downsLable.backgroundColor = gycoloers;
            NSString *nametext;
            
            nametext = _receiveDataDic[@"name"];

//            alable.text = [NSString stringWithFormat:@"%@ %@",nametext,_receiveDataDic[@"contact"]];
            alable.text = [NSString stringWithFormat:@"%@",nametext];

            alable.font = [UIFont fontWithName:geshi size:14];
            alable.textColor = gycolor;
            blable.text = _receiveDataDic[@"room_info"][@"room_address"];
            blable.font = [UIFont fontWithName:geshi size:14];
            blable.textColor = gycolor;
            [twoView addSubview:aview];
            [twoView addSubview:imageView];
            [twoView addSubview:alable];
            [twoView addSubview:blable];
            [twoView addSubview:upslable];
            [twoView addSubview:downsLable];
            
            return twoView;
        }else if(section == 1)
        {
          
            
            UIView *threeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
            threeView.backgroundColor = [UIColor whiteColor];
            
            UIView *buttonV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
            buttonV.backgroundColor=viewbackcolor;
            [threeView addSubview:buttonV];
            NSArray *namearray = @[@"标记完工",@"工单转移",@"标记无效"];
      
            for (int i=0; i<3; i++) {
                
                UIButton *abutton = [[UIButton alloc]initWithFrame:CGRectMake(10+10*i+(W-40)/3*i, 0, (W-40)/3, 40)];
                if (i==0 || i==1) {
                    
                    abutton.backgroundColor = NAVCOlOUR;
                    
                }else{
                    
                    abutton.backgroundColor = gycoloer;
                    
                }
                
                abutton.clipsToBounds=YES;
                abutton.layer.cornerRadius=5;
                [abutton addTarget:self action:@selector(wageTypeDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                abutton.tag = i;
                [abutton setTitle:namearray[i] forState:UIControlStateNormal];
                [abutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [buttonV addSubview:abutton];
            }
            
            
            
            UILabel *workTypeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, W, 40)];
            workTypeLable.textColor = gycolor;
            workTypeLable.textAlignment = NSTextAlignmentLeft;
            workTypeLable.text = @"工作性质 : 入室维修";
            if (_isAnBao) {
                workTypeLable.text = @"工作性质 : 公众服务";
            }
            workTypeLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *lineLbale = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5+50, WIDTH - 10, 0.5)];
            lineLbale.backgroundColor = gycoloers;
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50+50, W, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:15];
            
            topLable.textColor = gycolor;
            if ([autograph isEqualToString:@"F"]) {
                UIView *QMview=[[UIView alloc]initWithFrame:CGRectMake(0,70+20+50 , WIDTH, WIDTH-40)];
                QMview.backgroundColor=[UIColor whiteColor];
                [threeView addSubview:QMview];
                UIImageView *NameImg=[[UIImageView alloc]init];
                UILabel *kf=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, W, 20)];
                kf.text=@"客户签名";
                kf.font= [UIFont fontWithName:geshi size:15];
                kf.textColor=gycolor;
                kf.textAlignment=NSTextAlignmentLeft;
                [QMview addSubview:kf];
                NSLog(@"%@",_receiveDataDic[@"repaird"][@"autograph"]);
                [NameImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_receiveDataDic[@"repaird"][@"autograph"]]]];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_receiveDataDic[@"repaird"][@"autograph"]]];
                UIImage *Tuimage = [UIImage imageWithData:data];
                
                if (Tuimage.size.width>WIDTH-40) {
                    QMview.frame=CGRectMake(0, 90+50, WIDTH, (WIDTH-40)/(Tuimage.size.width/Tuimage.size.height )+20+20);
                    NameImg.frame=CGRectMake(0,30, WIDTH-40,(WIDTH-40)/(Tuimage.size.width/Tuimage.size.height ) );
                    QMHeight=(WIDTH-40)/(Tuimage.size.width/Tuimage.size.height )+20+20;
                    
                }else{
                    QMview.frame=CGRectMake(0, 90+50, WIDTH, Tuimage.size.height+20+20);
                    
                    NameImg.frame=CGRectMake(0,30, Tuimage.size.width,Tuimage.size.height);
                    QMHeight=Tuimage.size.height+20+20;
                }
                NSLog(@"%f",Tuimage.size.width);
                NameImg.centerX=QMview.centerX;
                
                [QMview addSubview:NameImg];
                
                
                
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
            
            
            [threeView addSubview:lineLbale];
            [threeView addSubview:topLable];
            [threeView addSubview:workTypeLable];
            return threeView;
        }else if(section == 2)
        {
            UIButton *fouthView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            fouthView.backgroundColor = [UIColor whiteColor];
            [fouthView addTarget:self action:@selector(exeFouthViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *wagedetails = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            wagedetails.text = @"工单详情";
            wagedetails.textColor = gycolor;
            wagedetails.font = [UIFont fontWithName:geshi size:17];
            
            UIImageView *yuanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            yuanImageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1,  15)];
            lineLable.backgroundColor = gycoloers;
            
            //            报修时间
            //            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(110, 10, WIDTH - 160, 20)];
            //            naturelables.textAlignment = NSTextAlignmentRight;
            //            naturelables.text = _receiveDataDic[@"post_time"];
            //            naturelables.font = [UIFont fontWithName:geshi size:13];
            //            naturelables.textColor = gycoloer;
            
            UILabel *upline = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, W, 0.5)];
            upline.backgroundColor = gycoloers;
            UILabel *buttomLine = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, W, 0.5)];
            buttomLine.backgroundColor = gycoloers;
            Fouthimageview  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenOne == YES) {
                Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                Fouthimageview.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [fouthView addSubview:lineLable];
            [fouthView addSubview:yuanImageView];
            [fouthView addSubview:Fouthimageview];
            
            //            报修时间
            //            [fouthView addSubview:naturelables];
            [fouthView addSubview:wagedetails];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            return fouthView;
        }else if (section == 4)
        {
            UIView * wageimageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
            wageimageView.backgroundColor = [UIColor whiteColor];
            UIImageView *wageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, WIDTH - 100, WIDTH - 100)];
            [wageImageView sd_setImageWithURL:[NSURL URLWithString:_receiveDataDic[@"repair_qrcode"]] placeholderImage:[UIImage imageNamed:@"100x100"]];
            [wageimageView addSubview:wageImageView];
            UILabel *wageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(wageImageView.frame), WIDTH, 20)];
            wageLable.text = @"工单二维码";
            wageLable.textAlignment = NSTextAlignmentCenter;
            wageLable.font = [UIFont fontWithName:geshi size:14];
            [wageimageView addSubview:wageLable];
            return wageimageView;
        }else
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(exeFiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"执行情况 ";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x43"];
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            FiveImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10,20, 20)];
            if (ISOpenTwo == YES) {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [FiveView addSubview:lineLable];
            [FiveView addSubview:imageView];
            [FiveView addSubview:FiveImageView];
            [FiveView addSubview:linelable];
            [FiveView addSubview:alable];
            return FiveView;
        }
        
    }
}

-(void)exeFouthViewDidClicked
{
    if (ISTIMERSTR == YES) {
        voicetimelables = nil;
        [changeVoiceTimer invalidate];
        changeVoiceTimer = nil;
        //结束定时器
        [timer invalidate];
        [self.audioPlayer stop];
        ISTIMERSTR = NO;
    }
    if (ISOpenOne == YES) {
        ISOpenOne = NO;
    }else
    {
        ISOpenOne = YES;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}
-(void)exeFiveViewDidClicked
{
    
    if (ISOpenTwo == YES) {
        ISOpenTwo = NO;
    }else
    {
        ISOpenTwo = YES;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else
    {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:3];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//返回cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_GRtableview) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
            UIImageView *quanImg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
            if (indexPath.row==Srow) {
                [quanImg setImage:[UIImage imageNamed:@"mlgj_a01"]];
                
            }else{
                [quanImg setImage:[UIImage imageNamed:@"mlgj_n01"]];
            }
            quanImg.tag=998;
            
            [cell addSubview:quanImg];
            
            UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(15+20+5, 0, WIDTH-15, 40)];
            nameLab.font=[UIFont systemFontOfSize:16];
            nameLab.text=workNameArray[indexPath.row];
            nameLab.textColor=gycolor;
            nameLab.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nameLab];
            
        }
        return cell;
        
    }
 
    
    
    int i;
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        i = 1;
    }else
    {
        i = 2;
    }
    if (indexPath.section == i) {
        //        添加报修时间
        GJExecutedChildTableViewCell *acell = [GJExecutedChildTableViewCell createCellWithTableView:tableView withIdentifier:@"exechildflags"];
        acell.selectionStyle = UITableViewCellSelectionStyleNone;
        linesLable = [[UILabel alloc]init];
        linesLable.backgroundColor = gycoloers;
        //问题描述
        acell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *questLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, WIDTH - 40, 40)];
        questLable.textColor = gycoloer;
        questLable.font = [UIFont fontWithName:geshi size:14];
        questLable.numberOfLines = 0;
        questLable.lineBreakMode = NSLineBreakByTruncatingTail;
        questLable.text = _receiveDataDic[@"description"];
        CGSize maximumLabelSize = CGSizeMake(WIDTH - 20, 9999);
        CGSize expectSize = [questLable sizeThatFits:maximumLabelSize];
        questLable.frame = CGRectMake(30, 10, expectSize.width, expectSize.height);
        //音频
        UIButton *voiceButton = [[UIButton alloc]init];
        [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(UNExePlayVoiceChildButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        timeLable = [[UILabel alloc]init];
        timeLable.backgroundColor = [UIColor clearColor];
        timeLable.textColor = NAVCOlOUR;
        timeLable.font = [UIFont fontWithName:geshi size:15];
        [acell.contentView addSubview:timeLable];
        [acell.contentView addSubview:voiceButton];
        VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
        
        
        
        
        if (voiceDataArray.count != 0) {
            NSInteger VoiceButtonLength;
            VoiceButtonLength = [[voiceTimeArray objectAtIndex:0]integerValue];
            if (VoiceButtonLength <= 10) {
                voiceLength = 80;
            }else if (VoiceButtonLength > 10 && VoiceButtonLength <= 20 )
            {
                voiceLength = 100;
            }else if (VoiceButtonLength > 20 && VoiceButtonLength <= 40)
            {
                voiceLength = 120;
            }else            {
                voiceLength = 140;
            }
            if (ISTIMERSTR == YES)
            {
                if (voicetimelables == nil || thetime == 0) {
                    timeLable.text = [NSString stringWithFormat:@"%@%@",[voiceTimeArray objectAtIndex:0],@"''"];
                }else
                {
                    timeLable.text = [NSString stringWithFormat:@"%@%@",voicetimelables,@"''"];
                }
                if (changeimagetime%3 == 2) {
                    [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_11@2x"]];
                }else if(changeimagetime%3 == 1)
                {
                    [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_12@2x"]];
                }else
                {
                    [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
                }
                
            }else{
                timeLable.text = [NSString stringWithFormat:@"%@%@",[voiceTimeArray objectAtIndex:0],@"''"];
                [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
                
            }
        }
        [voiceButton addSubview:VoiceImageView];
        [acell.contentView addSubview:voiceButton];
        
        CGFloat x = 10;
        CGFloat y = expectSize.height + 20;
        allDataImageArray = [NSMutableArray array];
        // 视频和图片
        if (videoDataArray.count != 0)
        {
            if (ShowImageDataArray.count != 0)
            {
                for (int i = 0; i < ShowImageDataArray.count; i++)
                {
                    [allDataImageArray addObject:ShowImageDataArray[i]];
                }
                [allDataImageArray insertObject:videoimageDataArray[0] atIndex:0];
                CGRect frame = CGRectMake(25, expectSize.height + 20, imageButtonW, imageButtonW);
                for (int i = 0 ; i < allDataImageArray.count; i ++)
                {
                    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(25, expectSize.height + 20, imageButtonW, imageButtonW)];
                    UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                    [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                    if (i == 0)
                    {
                        [imageview sd_setImageWithURL:videoimageDataArray[0] placeholderImage:[UIImage imageNamed:@"100x100"]];
                        UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageButtonW/2 - 15, imageButtonW/2 - 15, 30, 30)];
                        bofangimageView.backgroundColor = [UIColor clearColor];
                        bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
                        [imageview addSubview:bofangimageView];
                    }else
                    {
                        [imageview sd_setImageWithURL:ShowImageDataArray[i - 1] placeholderImage:[UIImage imageNamed:@"100x100"]];
                    }
                    if (i < 4) {
                        y = expectSize.height + 20;
                    }else if(i >= 8)
                    {
                        y = expectSize.height + 40 + 2 *imageButtonW;
                    }else
                    {
                        y = expectSize.height + 30 + imageButtonW;
                    }
                    if (i > 3 && i < 8) {
                        x = (i - 4) * (imageButtonW + 5) + 25;
                    }
                    else if (i == 8)
                    {
                        x = 25;
                    }else if (i == 9)
                    {
                        x = 30 + imageButtonW;
                    }
                    else
                    {
                        x = 25 + (i * imageButtonW + 5 * i);
                    }
                    frame.origin.x = x;
                    frame.origin.y = y;
                    [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                    imageButton.tag = i;
                    imageButton.frame = CGRectMake(x, y, imageButtonW, imageButtonW);
                    [imageButton addSubview:imageview];
                    [acell addSubview:imageButton];
                }
                if (voiceDataArray.count != 0) {
                    voiceButton.frame = CGRectMake(30, y + imageButtonW +10, voiceLength, 28);
                    timeLable.frame = CGRectMake(voiceLength + 40, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
                    cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
                }else
                {
                    cellHeight = y + imageButtonW + 10;
                }
            }
            else
            {
                UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(30, expectSize.height + 20, imageButtonW, imageButtonW)];
                imageButton.backgroundColor = [UIColor redColor];
                UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                NSURL *url = [videoimageDataArray objectAtIndex:0];
                [imageview sd_setImageWithURL:url];
                UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageButtonW/2 - 15, imageButtonW/2 - 15, 30, 30)];
                bofangimageView.backgroundColor = [UIColor clearColor];
                bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
                [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                [imageview addSubview:bofangimageView];
                [imageButton addSubview:imageview];
                [acell addSubview:imageButton];
                cellHeight = CGRectGetMaxY(imageButton.frame) + 10;
                if (voiceDataArray.count != 0) {
                    voiceButton.frame = CGRectMake(30,CGRectGetMaxY(imageButton.frame)+20, voiceLength, 28);
                    timeLable.frame = CGRectMake(voiceLength + 40, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
                    cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
                }
            }
        }
        else if (videoDataArray.count == 0 && ShowImageDataArray.count != 0)
        {
            CGFloat x = 30;
            CGFloat y = expectSize.height + 20;
            scrollerArray = ShowImageDataArray;
            for (int i = 0; i < ShowImageDataArray.count; i ++) {
                CGRect frame = CGRectMake(0, y, imageButtonW, imageButtonW);
                UIButton *imageButton = [[UIButton alloc]initWithFrame:frame];
                UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                [imageview sd_setImageWithURL:ShowImageDataArray[i] placeholderImage:[UIImage imageNamed:@"100x100"]];
                if (i < 4) {
                    y = expectSize.height + 20;
                }else if(i == 8)
                {
                    y = expectSize.height + 40 + 2 *imageButtonW;
                }else
                {
                    y = expectSize.height + 30 + imageButtonW;
                }
                if (i > 3 && i < 8) {
                    x = (i - 4) * (imageButtonW + 5)+25;
                }
                else if (i == 8)
                {
                    x = 25;
                }
                else
                {
                    x = 25 + (i * imageButtonW + 5 * i);
                }
                frame.origin.x = x;
                frame.origin.y = y;
                imageButton.tag = i;
                imageButton.frame = CGRectMake(x, y, imageButtonW, imageButtonW);
                [imageButton addSubview:imageview];
                [acell addSubview:imageButton];
                if (i == ShowImageDataArray.count - 1)
                {
                    cellHeight = CGRectGetMaxY(imageButton.frame)+20;
                }
            }
            if (voiceDataArray.count != 0) {
                voiceButton.frame = CGRectMake(30,y + 20 + imageButtonW, voiceLength, 28);
                timeLable.frame = CGRectMake(voiceLength + 40, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
                
                cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
            }
        }else if (videoDataArray.count == 0 && ShowImageDataArray.count == 0 && voiceDataArray.count != 0)
        {
            voiceButton.frame = CGRectMake(30, CGRectGetMaxY(questLable.frame) + 20, voiceLength, 28);
            timeLable.frame = CGRectMake(voiceLength + 40, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
            cellHeight = CGRectGetMaxY(voiceButton.frame)+20;
        }else if (videoDataArray.count == 0 && ShowImageDataArray.count == 0 && voiceDataArray.count == 0)
        {
            cellHeight = CGRectGetMaxY(questLable.frame)+20;
        }
        linesLable.frame = CGRectMake(15, 0, 1, cellHeight + 40+30+60);
        
        
#pragma mark - 这里要添加名字和电话
   if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"])
   {
       UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 8, WIDTH - 30, 0.5)];
       line1.backgroundColor = gycoloers;
       [acell.contentView addSubview:line1];
       
       UILabel *typeLable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 10, WIDTH - 50, 20)];
       typeLable.textColor = gycoloer;
       typeLable.font = [UIFont fontWithName:geshi size:14];
       if ([_receiveDataDic[@"serving_time"] isEqualToString:@""]) {
           typeLable.text = [NSString stringWithFormat:@"%@%@",@"预约时间 : ",@"尽快"];
       }else
       {
           typeLable.text = [NSString stringWithFormat:@"%@%@",@"预约时间 : ",_receiveDataDic[@"serving_time"]];
       }
       typeLable.textAlignment = NSTextAlignmentLeft;
       
       
       UILabel *blinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 29.5, WIDTH - 30, 0.5)];
       blinelable.backgroundColor = gycoloers;
       
       UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(30,blinelable.frame.origin.y+0.5 , WIDTH - 90, 30)];
       naturelables.textAlignment = NSTextAlignmentLeft;
       naturelables.text=[NSString stringWithFormat:@"报修时间：%@",_receiveDataDic[@"repaird"][@"post_time"]];
       NSLog(@"%@",_receiveDataDic);
       naturelables.font = [UIFont fontWithName:geshi size:13];
       naturelables.textColor = gycoloer;
       
       UILabel *clinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, naturelables.frame.origin.y + 30, WIDTH - 30, 0.5)];
       clinelable.backgroundColor = gycoloers;
       
       [acell.contentView addSubview:blinelable];
       [acell.contentView addSubview:typeLable];
       
       [acell.contentView addSubview:questLable];
       [acell.contentView addSubview:linesLable];
       
       [acell.contentView addSubview:clinelable];
       [acell.contentView addSubview:naturelables];

   }else{
   
   
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight+10, WIDTH-30, 29.5)];
        nameLab.text=[NSString stringWithFormat:@"报修人：%@",_receiveDataDic[@"name"]];
       if (_isAnBao) {
           nameLab.text=[NSString stringWithFormat:@"预约人：%@",_receiveDataDic[@"name"]];
       }
        nameLab.textColor = gycoloer;
        nameLab.font = [UIFont fontWithName:geshi size:13];
        [acell addSubview:nameLab];
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 10+29.5, WIDTH - 30, 0.5)];
        line1.backgroundColor = gycoloers;
        [acell.contentView addSubview:line1];
        
        UILabel *phoneLab=[[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight+10+30, WIDTH-30, 29.5)];
        phoneLab.text=[NSString stringWithFormat:@"联系电话：%@",_receiveDataDic[@"contact"]];
        phoneLab.textColor = gycoloer;
        phoneLab.font = [UIFont fontWithName:geshi size:13];
        [acell.contentView addSubview:phoneLab];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 10+30+29.5, WIDTH - 30, 0.5)];
        line2.backgroundColor = gycoloers;
        [acell.contentView addSubview:line2];
        
    
        UILabel *alinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 5, WIDTH - 40, 0.5)];
        alinelable.backgroundColor = gycoloers;
        UILabel *typeLable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 10+60, WIDTH - 50, 20)];
        typeLable.textColor = gycoloer;
        typeLable.font = [UIFont fontWithName:geshi size:14];
        if ([_receiveDataDic[@"serving_time"] isEqualToString:@""]) {
            typeLable.text = [NSString stringWithFormat:@"%@%@",@"预约时间 : ",@"尽快"];
        }else
        {
            typeLable.text = [NSString stringWithFormat:@"%@%@",@"预约时间 : ",_receiveDataDic[@"serving_time"]];
        }
        typeLable.textAlignment = NSTextAlignmentLeft;
        
        
        UILabel *blinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 35.5+60, WIDTH - 30, 0.5)];
        blinelable.backgroundColor = gycoloers;
        
        UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(30,blinelable.frame.origin.y+0.5 , WIDTH - 90, 30)];
        naturelables.textAlignment = NSTextAlignmentLeft;
        naturelables.text=[NSString stringWithFormat:@"报修时间：%@",_receiveDataDic[@"repaird"][@"post_time"]];
       if (_isAnBao) {
           naturelables.text=[NSString stringWithFormat:@"安保时间：%@",_receiveDataDic[@"repaird"][@"post_time"]];
       }

        NSLog(@"%@",_receiveDataDic);
        naturelables.font = [UIFont fontWithName:geshi size:13];
        naturelables.textColor = gycoloer;
        
        UILabel *clinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, naturelables.frame.origin.y + 30, WIDTH - 30, 0.5)];
        clinelable.backgroundColor = gycoloers;
        
        [acell.contentView addSubview:blinelable];
        [acell.contentView addSubview:typeLable];
        [acell.contentView addSubview:alinelable];
        [acell.contentView addSubview:questLable];
        [acell.contentView addSubview:linesLable];
        
        [acell.contentView addSubview:clinelable];
        [acell.contentView addSubview:naturelables];
   }
        return acell;
        
        
        
        
    }else
    {
        bcell = [GJExecutedChildTwoTableViewCell createCellWithTableView:tableView withIdentifier:@"exechildTwoflags"];
        bcell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [NSArray array];
        nameArray = @[@"执行状态",@"维修师傅",@"联系电话"];
        if (_isAnBao) {
            nameArray = @[@"执行状态",@"服务人",@"联系电话"];
        }
        NSArray *contentArray = [NSArray array];
        contentArray = @[_receiveDataDic[@"repair_status"],_receiveDataDic[@"repaird"][@"repair_master_name"],_receiveDataDic[@"repaird"][@"repair_master_phone"]];
        for (int i = 0 ; i < nameArray.count; i++) {
            if (i == 2) {
                [self buttonWithCGRect:CGRectMake(10, i * 30, WIDTH - 10, 30) leftTitle:nameArray[i] RightTitle:contentArray[i] target:self action:@selector(phoneNumberButtonDidClicked)];
            }else
            {
                [self ViewWithCGRect:CGRectMake(10, i * 30, WIDTH - 10, 30) leftTitle:nameArray[i] RightTitle:contentArray[i]];
            }
        }
        
        [bcell addSubview:opinionView];
        return bcell;
    }
}
//拨打电话功能
-(void)phoneNumberButtonDidClicked
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:_receiveDataDic[@"repaird"][@"repair_master_phone"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
    [alertview show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",_receiveDataDic[@"repaird"][@"repair_master_phone"]]]];
    }
}
-(UIButton *)buttonWithCGRect:(CGRect)rect leftTitle:(NSString *)lefttitle RightTitle:(NSString *)righttitle target:(id)target action:(SEL)action
{
    UIButton *abutton = [[UIButton alloc]initWithFrame:rect];
    [abutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    abutton.backgroundColor = [UIColor whiteColor];
    UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(30,0 , (WIDTH - 30)/2, 30)];
    leftLable.textColor = gycoloer;
    leftLable.font = [UIFont fontWithName:geshi  size:13];
    leftLable.textAlignment = NSTextAlignmentLeft;
    leftLable.text = lefttitle;
    
    UILabel *rightLabele = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 30)/2 + 10, 0, (WIDTH - 30)/2 - 10, 30)];
    rightLabele.textColor = gycolor;
    rightLabele.font = [UIFont fontWithName:geshi  size:14];
    rightLabele.textAlignment = NSTextAlignmentRight;
    rightLabele.text = righttitle;
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 29.5, WIDTH - 30, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [abutton addSubview:lineLable];
    [abutton addSubview:leftLable];
    [abutton addSubview:rightLabele];
    [bcell addSubview:abutton];
    return abutton;
    
}
-(UIView *)ViewWithCGRect:(CGRect)rect leftTitle:(NSString *)lefttitle RightTitle:(NSString *)righttitle
{
    UIView *aview = [[UIView alloc]initWithFrame:rect];
    aview.backgroundColor = [UIColor whiteColor];
    UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(30,0 , (WIDTH - 30)/2, 30)];
    leftLable.textColor = gycoloer;
    leftLable.font = [UIFont fontWithName:geshi  size:13];
    leftLable.textAlignment = NSTextAlignmentLeft;
    leftLable.text = lefttitle;
    
    UILabel *rightLabele = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 30)/2 + 10, 0, (WIDTH - 30)/2 - 10, 30)];
    rightLabele.textColor = gycoloer;
    rightLabele.font = [UIFont fontWithName:geshi  size:13];
    rightLabele.textAlignment = NSTextAlignmentRight;
    rightLabele.text = righttitle;
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 29.5, WIDTH - 30, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [aview addSubview:lineLable];
    [aview addSubview:leftLable];
    [aview addSubview:rightLabele];
    [bcell addSubview:aview];
    return aview;
}
-(void)reloadData
{
    NSLog(@"%@",_receiveDataDic);
    videoImageArray = [NSMutableArray array];
    videoimageDataArray = [NSMutableArray array];
    allDataArray = [NSMutableArray array];
    imagedataArray = [NSMutableArray array];
    voiceDataArray = [NSMutableArray array];
    videoDataArray = [NSMutableArray array];
    voiceTimeArray = [NSMutableArray array];
    ShowImageDataArray = [NSMutableArray array];
    Datadict = _receiveDataDic[@"ivv_json"];
    //    phoneNumber = [_receiveDataDic[@"user_info"][@"mobile_phone"]integerValue];
    NSArray *imageArray = [NSArray array];
    NSArray *videoArray = [NSArray array];
    NSArray *voiceArray = [NSArray array];
    imageArray = Datadict[@"images"];
    videoArray = Datadict[@"video"];
    voiceArray = Datadict[@"voice"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
    for (NSDictionary *imagedic in imageArray) {
        NSString *str;
        if (!imagedic[@"images_ico"]) {
            str = imagedic[@"images"];
        }else
        {
            str = imagedic[@"images_ico"];
        }
        NSString *imageStr = [NSString stringWithFormat:@"%@%@",@"",str];
        NSString *BigImageView = [NSString stringWithFormat:@"%@%@",@"",imagedic[@"images"]];
        [ShowImageDataArray addObject:imageStr];
        [imagedataArray addObject:[GJMHPhotoModel photoWithURL:[NSURL URLWithString:BigImageView]]];
    }
    for (NSDictionary *videoDic in videoArray) {
        NSString *str = videoDic[@"video"];
        [videoDataArray addObject:str];
        NSString *str1 = videoDic[@"video_img_ico"];
        [videoimageDataArray addObject:[NSString stringWithFormat:@"%@%@",@"",str1]];
    }
    for (NSDictionary *voiceDic in voiceArray) {
        NSString *str = voiceDic[@"voice"];
        NSString *time = [NSString stringWithFormat:@"%@",voiceDic[@"voice_time"]];
        [voiceTimeArray addObject:time];
        [voiceDataArray addObject:str];
    }
}

-(void)showimageBig:(UIButton *)sender
{
    if (videoDataArray.count != 0) {
        if (sender.tag == 0) {
            [self playVideo];
        }
        else
        {
            GJMHPhotoBrowserController *vc = [GJMHPhotoBrowserController new];
            vc.currentImgIndex = sender.tag - 1;
            vc.displayTopPage = YES;
            vc.displayDeleteBtn = NO;
            vc.imgArray = imagedataArray;
            [self presentViewController:vc animated:YES completion:nil];        }
    }else
    {
        GJMHPhotoBrowserController *vc = [GJMHPhotoBrowserController new];
        vc.currentImgIndex = sender.tag;
        vc.displayTopPage = YES;
        vc.displayDeleteBtn = NO;
        vc.imgArray = imagedataArray;
        [self presentViewController:vc animated:YES completion:nil];
    }
}


-(void)playVideo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *playVideoStr = videoDataArray[0];
    NSString *videoStr = [userDefaults objectForKey:@"app_video_url"];
    NSString *VideoUrl = [NSString stringWithFormat:@"%@%@",@"",playVideoStr];
    if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.exeDelegates PushVideoVCDidClicked:VideoUrl];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}

-(void)mattersDidClicked
{
    
    backButtonView  = [[UIButton alloc]initWithFrame:window.frame];
    backButtonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [backButtonView addTarget:self action:@selector(backbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *namearray = [NSArray array];
    namearray = @[@"标记完工",@"工单转移",@"标记无效",@"取消"];
    for (int i = 0 ; i < namearray.count; i ++) {
        if (i == 0 || i == 1 || i == 2)
        {
            [self buttonWithCGRect:CGRectMake(0, (H - 210) + i * 50, W, 50) Title:namearray[i] arget:self action:@selector(wageTypeDidClicked:) Tag:i];
        }else
        {
            [self buttonWithCGRect:CGRectMake(0, H - 50, W, 50) Title:namearray[i] arget:self action:@selector(wageTypeDidClicked:) Tag:i];
        }
    }
    [window addSubview:backButtonView];
}
-(void)wageTypeDidClicked:(UIButton *)sender
{
    if (sender.tag == 0) {
        if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushFishWageClicked:)]) {
            [self.exeDelegates PushFishWageClicked:_receiveDataDic[@"repair_id"]];
            [backButtonView removeFromSuperview];
        }
        else
        {
            NSLog(@"协议方案未实现");
        }
    }else if(sender.tag == 1)
    {
        
        
        
        [backButtonView removeFromSuperview];
        backButtonView = [[UIButton alloc]initWithFrame:window.frame];
        backButtonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        transferView = [[UIView alloc]initWithFrame:CGRectMake(20, 90, WIDTH-40 , 438)];
        transferView.layer.masksToBounds = YES;
        //设置元角度
        transferView.layer.cornerRadius = 6.0;
        //设置边线
        //    aview.layer.borderWidth = 1.0;
        transferView.backgroundColor =  [UIColor whiteColor];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, transferView.size.width, 50)];
        titleLable.text = @"工单转移";
        titleLable.font = [UIFont fontWithName:geshi size:19];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        UIButton *dismisButton = [[UIButton alloc]initWithFrame:CGRectMake(transferView.size.width - 40, 10, 30, 30)];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageview.image = [UIImage imageNamed:@"dialog_back"];
        [dismisButton addSubview:imageview];
        [dismisButton addTarget:self action:@selector(backssbuttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [transferView addSubview:dismisButton];
        
        UIView *hengL=[[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, WIDTH-40, 0.5)];
        hengL.backgroundColor=NAVCOlOUR;
        [transferView addSubview:hengL];
        
        
        UILabel *firL=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, transferView.bounds.size.width-15, 45)];
        firL.text=@"请选择转移人员";
        firL.textColor=gycolor;
        firL.font=[UIFont systemFontOfSize:16];
        firL.textAlignment=NSTextAlignmentLeft;
        [transferView addSubview:firL];
        
        UIView *hengL2=[[UIView alloc]initWithFrame:CGRectMake(15, 50+45-0.5, transferView.bounds.size.width-15, 0.5)];
        hengL2.backgroundColor=gycoloer;
        [transferView addSubview:hengL2];
        
        _GRtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 95, transferView.bounds.size.width, 45*3)];
        
        
        _GRtableview.delegate=self;
        _GRtableview.dataSource=self;
        [transferView addSubview:_GRtableview];
        
    
        
        opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 95+45*3+5,transferView.size.width, 100)];
        opinionView.backgroundColor =FZColor(245, 245, 245);
        opinionView.font = [UIFont fontWithName:geshi size:15];
        opinionView.delegate = self;
        [opinionView.layer setCornerRadius:5];
        placeLables = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
        placeLables.enabled = NO;
        placeLables.delegate = self;
        placeLables.text = @"请在此输入原因";
        placeLables.font =  [UIFont systemFontOfSize:15];
        placeLables.textColor = gycoloer;
        [opinionView addSubview:placeLables];
        UIButton *yesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 95+45*3+100+30, transferView.width - 40, 40)];
        [yesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
        [yesButton setTitle:@"确定" forState:UIControlStateNormal];
        if (_isAnBao) {
            [yesButton addTarget: self action:@selector(TransferButtoDidClicked_ls) forControlEvents:UIControlEventTouchUpInside];

        }else{
            [yesButton addTarget: self action:@selector(TransferButtoDidClicked) forControlEvents:UIControlEventTouchUpInside];

        }
        [transferView addSubview:titleLable];
        
        [transferView addSubview:opinionView];
        [transferView addSubview:yesButton];
        [backButtonView addSubview:transferView];
        [window addSubview:backButtonView];
    }else if(sender.tag == 2)
    {
        [backButtonView removeFromSuperview];
        backButtonView = [[UIButton alloc]initWithFrame:window.frame];
        backButtonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        invalidView = [[UIView alloc]initWithFrame:CGRectMake(W/2 - 140, 150, 280, 190)];
        invalidView.layer.masksToBounds = YES;
        //设置元角度
        invalidView.layer.cornerRadius = 6.0;
        //设置边线
        invalidView.backgroundColor = gycoloers;
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, invalidView.size.width, 20)];
        titleLable.text = @"标记无效";
        titleLable.font = [UIFont fontWithName:geshi size:15];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        UIButton *dismisButton = [[UIButton alloc]initWithFrame:CGRectMake(invalidView.size.width - 30, 0, 30, 30)];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        imageview.image = [UIImage imageNamed:@"dialog_back"];
        [dismisButton addSubview:imageview];
        [dismisButton addTarget:self action:@selector(backssbuttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        apportionView = [[UITextView alloc]initWithFrame:CGRectMake(30, 50,invalidView.size.width - 60, 60)];
        apportionView.backgroundColor = [UIColor whiteColor];
        apportionView.font = [UIFont fontWithName:geshi size:15];
        apportionView.delegate = self;
        [apportionView.layer setCornerRadius:5];
        appointLable = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
        appointLable.enabled = NO;
        appointLable.delegate = self;
        appointLable.text = @"没有时间";
        appointLable.font =  [UIFont systemFontOfSize:15];
        appointLable.textColor = gycoloer;
        [apportionView addSubview:appointLable];
        UIButton *yesButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 130,invalidView.size.width - 60, 40)];
        [yesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
        [yesButton setTitle:@"确定" forState:UIControlStateNormal];
        [yesButton addTarget: self action:@selector(InvalidButtonDidClickeds) forControlEvents:UIControlEventTouchUpInside];
        [invalidView addSubview:titleLable];
        [invalidView addSubview:dismisButton];
        [invalidView addSubview:apportionView];
        [invalidView addSubview:yesButton];
        [backButtonView addSubview:invalidView];
        [window addSubview:backButtonView];
    }else
    {
        [backButtonView removeFromSuperview];
    }
}
-(UIButton *)buttonWithCGRect:(CGRect)rect Title:(NSString *)title arget:(id)target action:(SEL)action Tag:(int)tags
{
    UIButton *abutton = [[UIButton alloc]initWithFrame:rect];
    abutton.backgroundColor = [UIColor whiteColor];
    [abutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    abutton.tag = tags;
    [abutton setTitle:title forState:UIControlStateNormal];
    [abutton setTitleColor:gycolor forState:UIControlStateNormal];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [abutton addSubview:lineLable];
    [backButtonView addSubview:abutton];
    return abutton;
}
-(void)backssbuttonDidClicked
{
    [backButtonView removeFromSuperview];
    Srow=0;

}
-(void)backbuttonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}
-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workidarray[worknameID]];
}

///转移工单-ls

-(void)TransferButtoDidClicked_ls
{
    [GJSVProgressHUD showWithStatus:@"转移中"];
    NSString *property_ids;
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }
    theworkID = [NSString stringWithFormat:@"%@",workidarray[Srow]];
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择安保人员！"];
    }else if (opinionView.text == nil)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入转移原因！"];
    }else
    {
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"repair_transfer" andBodyOfRequestForKeyArr:@[@"repair_id",@"repair_user_id",@"remarks",@"type"] andValueArr:@[_receiveDataDic[@"repair_id"],theworkID,opinionView.text,@"E"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.exeDelegates PushLoginVCDidClicked];
                     }
                     else
                     {
                         NSLog(@"协议方案未实现");
                     }
                 });
             }
             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }else if ([state isEqualToString:@"1"])
             {
                 [GJSVProgressHUD dismiss];
                 [GJSVProgressHUD showSuccessWithStatus:@"转移成功"];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ExecutedfishWage" object:nil];
                 for (UIViewController * vc in self.navigationController.viewControllers){
                     if ([vc isKindOfClass:[GJAllWageViewController class]]) {
                         [self.navigationController popToViewController:vc animated:YES];
                     }
                 }
//                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
         }];
        [backButtonView removeFromSuperview];
    }
}
//转移工单提交
-(void)TransferButtoDidClicked
{
    [GJSVProgressHUD showWithStatus:@"转移中"];
    NSString *property_ids;
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }
    theworkID = [NSString stringWithFormat:@"%@",workidarray[Srow]];

    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }else if (opinionView.text == nil)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入转移原因！"];
    }else
    {
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[remarks]",@"type"] andValueArr:@[property_ids,_receiveDataDic[@"repair_id"],theworkID,opinionView.text,@"E"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.exeDelegates PushLoginVCDidClicked];
                     }
                     else
                     {
                         NSLog(@"协议方案未实现");
                     }
                 });
             }
             else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
             }else if ([state isEqualToString:@"1"])
             {
                 [GJSVProgressHUD dismiss];
                 [GJSVProgressHUD showSuccessWithStatus:@"转移成功"];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ExecutedfishWage" object:nil];
                 for (UIViewController * vc in self.navigationController.viewControllers){
                     if ([vc isKindOfClass:[GJAllWageViewController class]]) {
                         [self.navigationController popToViewController:vc animated:YES];
                     }
                 }
//                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
         }];
        [backButtonView removeFromSuperview];
    }
}
//标记无效
-(void)InvalidButtonDidClickeds
{
    [GJSVProgressHUD showWithStatus:@"标记中"];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    NSString * fstr = @"repair";
    NSArray * keyArr = @[@"rep[repair_id]",@"rep[work_remarks]"];
    if (_isAnBao) {
        fstr = @"security";
        keyArr = @[@"repair_id",@"work_remarks"];
    }
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"edit_invalid" andBodyOfRequestForKeyArr:keyArr andValueArr:@[_receiveDataDic[@"repair_id"],apportionView.text] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.exeDelegates PushLoginVCDidClicked];
                 }
                 else
                 {
                     NSLog(@"协议方案未实现");
                 }
             });
         }
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }else if ([state isEqualToString:@"1"])
         {
             [GJSVProgressHUD dismiss];
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"ExecutedfishWage" object:nil];
             for (UIViewController * vc in self.navigationController.viewControllers){
                 if ([vc isKindOfClass:[GJAllWageViewController class]]) {
                     [self.navigationController popToViewController:vc animated:YES];
                 }
             }
//             [self.navigationController popToRootViewControllerAnimated:YES];
             
         }
     }];
    [backButtonView removeFromSuperview];
}
//播放音频
-(void)UNExePlayVoiceChildButtonDidClicked
{
    if (ISTIMERSTR == YES) {
        ISTIMERSTR = NO;
        if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        //结束定时器
        [timer invalidate];
        [changeVoiceTimer invalidate];
        [self.audioPlayer stop];
    }else
    {
        ISTIMERSTR = YES;
        //播放
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSString *voicetoustr = [userdefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceDataArray[0]];
        thetime = [[voiceTimeArray objectAtIndex:0] intValue];
        changeimagetime = thetime * 2;
        //设置扩音播放
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        
        
        //播放音乐
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *filePath = [NSString stringWithFormat:@"/%@.mp3",[formater stringFromDate:[NSDate date]]];
        [self downloadFileURL:VoiceUrl savePath:docDirPath fileName:filePath];
    }
}


- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    //检查附件是否存在
    if ([userDefaults objectForKey:aUrl]) {
        [self.audioPlayer playURL:[NSURL fileURLWithPath:[userDefaults objectForKey:aUrl]]];
    }else{
        //判断网络
        GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
        if(!connect.connectedToNetwork)
        {
            //            [GJSVProgressHUD showErrorWithStatus:@"网络故障,请检查您的网络!"];
            
        }else
        {
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:VoiceUrl]];
            [audioData writeToFile:fileName atomically:YES];
            [userDefaults setObject:fileName forKey:aUrl];
            [userDefaults synchronize];
            [self.audioPlayer playURL:[NSURL fileURLWithPath:fileName]];
        }
    }
    //启动定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVoiceImage:) userInfo:nil repeats:YES];
    changeVoiceTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeVoiceImages:) userInfo:nil repeats:YES];
    PlayVoiceButton.userInteractionEnabled = NO;
}

-(void)changeVoiceImage:(NSTimer *)time
{
    ISTIMERSTR = YES;
    thetime -= 1;
    voicetimelables = [NSString stringWithFormat:@"%d",thetime];
    
    if (thetime == 0) {
        voicetimelables = nil;
        //结束定时器
        ISTIMERSTR = NO;
        voicetimelables = [NSString stringWithFormat:@"%d",thetime];
        [self.audioPlayer stop];
        [timer invalidate];
    }
    
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
-(void)changeVoiceImages:(NSTimer *)time
{
    changeimagetime -= 1;
    if (thetime == 0) {
        //结束定时器
        [changeVoiceTimer invalidate];
        changeVoiceTimer = nil;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ImageDisMiss:(UIButton *)sender
{
    [sender removeFromSuperview];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    height = keyboardRect.size.height;
    

    CGRect Frame = CGRectMake(20, 90-height+45*3, WIDTH-40 , 438);
    CGRect Frames = CGRectMake (W/2 - 140, HEIGHT - height - 190, 280, 190);
    [transferView setFrame: Frame];
    [invalidView setFrame:Frames];
}
//问题描述代理事件
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [appointLable setHidden:NO];
    }else{
        [appointLable setHidden:YES];
    }
    if ([textView.text length] == 0) {
        [placeLables setHidden:NO];
    }else{
        [placeLables setHidden:YES];
    }
}
//输入结束
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    CGRect Frame = CGRectMake(20, 90, WIDTH-40 , 438);
    CGRect Frames = CGRectMake (W/2 - 140, 150, 280, 190);
    [transferView setFrame: Frame];
    [invalidView setFrame: Frames];
    
}
////维修师傅
-(void)getMaintenancemaster
{
    workNameArray = [NSMutableArray array];
    workID = [NSMutableArray array];
    worknamearray = [NSArray array];
    workidarray = [NSArray array];
    NSString *property_id;
    NSString *community_id;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    NSString * fstr = @"repair";
    if (_isAnBao) {
        fstr = @"security";
    }
    property_id = model.property_id;
    community_id = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_who" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"10",@"10"] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.exeDelegates PushLoginVCDidClicked];
                 }
                 else
                 {
                     NSLog(@"协议方案未实现");
                 }
             });
         }
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }else if ([state isEqualToString:@"1"])
         {
             for (NSDictionary *dict in dictionary[@"return_data"]) {
                 NSString *userid = dict[@"user_id"];
                 NSString *turename = dict[@"ture_name"];
                 [workID addObject:userid];
                 [workNameArray addObject:turename];
             }
             worknamearray = workNameArray;
             workidarray = workID;
         }
     }];
}
//预约时间
-(void)dropdown
{
    [_cuiPickerView showInView:_cuiPickerViewdiscoverButton];
    [_cuiPickerViewdiscoverButton addSubview:_cuiPickerView];
    [window addSubview:_cuiPickerViewdiscoverButton];
}
//赋值给cell的lable
-(void)didFinishPickView:(NSString *)date
{
    if (date==nil) {
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *DateTime = [formatter stringFromDate:date];
        worktimelable.text=DateTime;
        
    }else{
        worktimelable.text = date;
    }
}
-(void)hiddenPickerView
{
    [_cuiPickerViewdiscoverButton removeFromSuperview];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_GRtableview==tableView) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        for (UIView *vv in cell.subviews) {
            if (vv.tag==998) {
                UIImageView *bb=(UIImageView *)vv;
                [bb setImage:[UIImage imageNamed:@"mlgj_a01"] ];
                Srow=indexPath.row;
                
                theworkID = [NSString stringWithFormat:@"%@",workidarray[Srow]];
                
            }
        }
        
        [_GRtableview reloadData];
    }
}

@end
