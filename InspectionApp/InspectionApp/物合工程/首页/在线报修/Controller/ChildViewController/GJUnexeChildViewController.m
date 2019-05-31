//第二个进去的      第一个   进去的详情


//  GJUnexeChildViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJUnexeChildViewController.h"
#import "GJUnexeChildTableViewCell.h"
#define imageButtonW (WIDTH - 50)/4
#import "GJSDAdScrollView.h"
#import "FMDB.h"
#import "GJUnexecutedViewController.h"
#import "GJCommunityModel.h"
#import "GJFZPWorkMenus.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "GJCuiPickerView.h"
//repair_id=53&m=mlgj_api&f=repair&a=receive&app_id=WLBGJ10002110&app_secret=765e5da307ec2ea9e4d0655d32dbf5b4&access_token=19dde6e2d35a2da4e9076d34b756e135&save_token=893bb26f8540061d56512b1229d66709&user_id=+sYyVoEwaGWtjaVlvQoe2A==&session_key=aa1973945d5a062e843afa88a25e7f9f
@interface GJUnexeChildViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,AVAudioPlayerDelegate,workNameIDDelegates,CuiPickViewDelegate,worknameIDDelegates>
{
    BOOL ISOpen;
    
    UIImageView *theimageview;
    
    //存储相片视频音频
    NSDictionary *Datadict;
    
    //存储数据源数量
    //    NSMutableArray *allDataArray;
    //图片数(为了点击显示存储)
    NSMutableArray *imagedataArray;
    //图片数（为了展示存储）
    NSMutableArray *ShowImageDataArray;
    //视频数
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
    
    CGFloat cellHeight;
    //存放整体图片
    NSMutableArray *allDataImageArray;
    UIView *apportionView;
    UITextView *opinionView;
    UITextField *placeLables;
    UIView *cancelView;
    int height;
    //音频Url
    NSString *VoiceUrl;
    //音频时间
    UILabel *voiceTimeLable;
    //播放音频按钮
    UIButton *PlayVoiceButton;
    NSTimer *timer;
    NSTimer *changeImagetimer;
    
    float times;
    NSMutableArray *workNameArray;
    NSMutableArray *workIdarray;
    NSString *state;
    NSString *theworkID;
    int thetime;
    NSString *servingtime;
    //音频时间
    NSString *voicetimelables;
    NSString *voicetimes;
    UILabel *personLable;
    UILabel *appointtimeLable;
    UIButton *discoverButton;
    UIView *transferView;
    int thetimes;
    UIImageView *VoiceImageView;
    BOOL ISTIMERSTR;
    int buttonTage;
    UILabel *timeLable;
    int voiceLength;
    int ImageChange;
    
    //    int phoneNumber;
    //    int userPhoneNumber;
    UIButton *backButtonView;
    UIWindow *window;
    
    UILabel *worktimelable;
    
    NSInteger Srow;

}
@property (nonatomic, strong)GJCuiPickerView *cuiPickerView;
@property(nonatomic,strong)UIButton *cuiPickerViewdiscoverButton;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,strong)UIAlertView *ReceiveWagealert;
@property(nonatomic,strong) GJFMDatabase *db;


@property(nonatomic,strong)UITableView *GRtableview;

@end

@implementation GJUnexeChildViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    //结束定时器
    [timer invalidate];
    [changeImagetimer invalidate];
    [self.audioPlayer stop];
    ISTIMERSTR = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Srow=0;
    _cuiPickerView = [[GJCuiPickerView alloc]init];
    _cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    _cuiPickerView.backgroundColor = [UIColor whiteColor];
    _cuiPickerView.delegate = self;
    _cuiPickerView.curDate=[NSDate date];
    window = [UIApplication sharedApplication].keyWindow;
    _cuiPickerViewdiscoverButton = [[UIButton alloc]initWithFrame:window.frame];
    _cuiPickerViewdiscoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    //数据的路径，放在沙盒的cache下面
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"contact.db"];
    //创建并且打开一个数据库
    _db = [GJFMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_db open];
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    workNameArray = [NSMutableArray array];
    workIdarray = [NSMutableArray array];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    workNameArray = [userdefaults objectForKey:@"UNexeworkNameArray"];
    workIdarray = [userdefaults objectForKey:@"UNexeworkIDArray"];
    //增加监听，当键弹起时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unexechildkeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unexechildkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    UILabel *titlelable = [UILabel lableWithName:@"工单详情"];
    self.navigationItem.titleView = titlelable;
    self.tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableview.backgroundColor = viewbackcolor;
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    ISOpen = YES;
    ISTIMERSTR = NO;
    self.view = self.tableview;
    [self reloadData];
    
    
}

//返回headview行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_GRtableview==tableView) {
        return 1;
    }
    
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        return 5;
    }else
    {
        return 6;
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
            return 100;
        }else if(section == 1)
        {
            return 80;
        }else if(section == 2)
        {
            return 40;
        }else if(section == 4)
        {
            return WIDTH - 60;
        }
        {
            return 30+30;
        }
    }else
    {
        
        if (section == 0) {
            return 68;
        }else if (section == 1)
        {
            return 60;
        }else if(section == 2)
        {
            return 80;
        }else if(section == 3)
        {
            return 40;
        }else if(section == 5)
        {
            return WIDTH - 60;
        }else
        {
            return 30+30+60;
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
        if (section == 2) {
            if (ISOpen == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }else
        {
            return 0;
        }
        
    }else
    {
        if (section == 3) {
            if (ISOpen == NO) {
                return 0;
            }else
            {
                return 1;
            }
        }else
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
    return cellHeight;
}
//返回尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (section == 1) {
            return 8;
        }else
        {
            return 0;
        }
        
    }else
    {
        if (section == 2) {
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if(section == 0)
        {
            
            UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
            twoView.backgroundColor = viewbackcolor;
            
            UILabel *gongg = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, W, 40)];
            gongg.textColor = gycolor;
            
            gongg.textAlignment = NSTextAlignmentCenter;
            gongg.text = @"公共区域报事工单";
            gongg.font = [UIFont fontWithName:geshi size:16];
            
            
            
            UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 40, W/2 - 40, 40)];
            leftButton.backgroundColor = FZColor(112, 19,28);
            leftButton.titleLabel.textColor = [UIColor whiteColor];
            UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2 + 20, 40, W/2 - 40, 40)];
            [leftButton addTarget: self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            leftButton.tag = 2110;
            leftButton.layer.cornerRadius = 5;
            if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
                if ([_STYLE isEqualToString:@"1"]) {
                    
                    [leftButton setTitle:@"分派工单" forState:UIControlStateNormal];
                }else{
                    
                    [leftButton setTitle:@"转移工单" forState:UIControlStateNormal];
                    
                }
                [rightButton setTitle:@"标记无效" forState:UIControlStateNormal];
                rightButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
                rightButton.layer.cornerRadius = 5;
                [rightButton setBackgroundColor:[UIColor blackColor]];
                [rightButton setBackgroundImage:[UIImage imagewithColor:gycoloer] forState:UIControlStateHighlighted];
                rightButton.tag = 2111;
                [rightButton addTarget:self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                rightButton.alpha = 0.3;
                [twoView addSubview:rightButton];
                
            }else
            {
                if ([_STYLE isEqualToString:@"1"]) {
                    
                    [leftButton setTitle:@"抢单" forState:UIControlStateNormal];
                    leftButton.frame = CGRectMake(20, 10, W - 40, 40);
                    
                }else{
                    
                    [leftButton setTitle:@"处理工单" forState:UIControlStateNormal];
                    
                    [rightButton setTitle:@"标记无效" forState:UIControlStateNormal];
                    rightButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
                    rightButton.layer.cornerRadius = 5;
                    [rightButton setBackgroundColor:[UIColor blackColor]];
                    [rightButton setBackgroundImage:[UIImage imagewithColor:gycoloer] forState:UIControlStateHighlighted];
                    rightButton.tag = 2111;
                    [rightButton addTarget:self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                    rightButton.alpha = 0.3;
                    [twoView addSubview:rightButton];
                    
                }
                
            }
            
            
            
            [twoView addSubview:gongg];
            [twoView addSubview:leftButton];
            return twoView;
        }else if(section == 1)
        {
            UIView *fouthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 80)];
            fouthView.backgroundColor = [UIColor whiteColor];
            UILabel *natureLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
            natureLable.text = @"工作性质 :";
            natureLable.textColor = gycolor;
            natureLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 80, 20)];
            naturelables.text = @"公共区域报修";
            naturelables.textColor = gycoloer;
            
            UILabel *upline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
            upline.backgroundColor = gycoloers;
            UILabel *buttomLine = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, W, 0.5)];
            buttomLine.backgroundColor = gycoloers;
            
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, W-50, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:14];
            topLable.textColor = gycolor;
            topLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, WIDTH, 0.5)];
            downLable.backgroundColor = gycoloers;
            
            [fouthView addSubview:downLable];
            [fouthView addSubview:topLable];
            [fouthView addSubview:naturelables];
            [fouthView addSubview:natureLable];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            
            return fouthView;
        }else if(section == 2)
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(FiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
            uplable.backgroundColor = gycoloers;
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
            alable.text = @"工单详情";
            alable.textColor = gycolor;
            //            UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, W - 160, 20)];
            //            blable.text = _receiveDataDic[@"post_time"];
            //            blable.textColor = gycoloer;
            //            blable.textAlignment = NSTextAlignmentRight;
            //            blable.font = [UIFont fontWithName:geshi size:14];
            theimageview  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10,20, 20)];
            if (ISOpen == NO) {
                theimageview.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }else
            {
                theimageview.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, WIDTH, 0.5)];
            downLineLable.backgroundColor = gycoloers;
            [FiveView addSubview:theimageview];
            [FiveView addSubview:downLineLable];
            [FiveView addSubview:uplable];
            [FiveView addSubview:alable];
            //            [FiveView addSubview:blable];
            return FiveView;
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
        }
        else
        {
            UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
            aview.backgroundColor = [UIColor whiteColor];
            
#pragma mark - 这里要添加名字和电话
            //            UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0.5, WIDTH-10, 29.5)];
            //            nameLab.text=[NSString stringWithFormat:@"报修人：%@",_receiveDataDic[@"name"]];
            //            nameLab.textColor = gycoloer;
            //            nameLab.font = [UIFont fontWithName:geshi size:13];
            //            [aview addSubview:nameLab];
            
            //            UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, WIDTH, 0.5)];
            //            line1.backgroundColor = gycoloers;
            //            [aview addSubview:line1];
            //
            //            UILabel *phoneLab=[[UILabel alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y, WIDTH-30, 29.5)];
            //            phoneLab.text=[NSString stringWithFormat:@"联系电话：%@",_receiveDataDic[@"user_info"][@"mobile_phone"]];
            //            phoneLab.textColor = gycoloer;
            //            phoneLab.font = [UIFont fontWithName:geshi size:13];
            //            [aview addSubview:phoneLab];
            //
            UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH, 0.5)];
            line2.backgroundColor = gycoloers;
            [aview addSubview:line2];
            
            
            UILabel *typeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, WIDTH - 10, 20)];
            typeLable.textColor = gycoloer;
            typeLable.font = [UIFont fontWithName:geshi size:14];
            if ([servingtime isEqualToString:@""]) {
                typeLable.text = [NSString stringWithFormat:@"预约时间 : %@",@"尽快"];
            }else
            {
                typeLable.text = [NSString stringWithFormat:@"预约时间 : %@",servingtime];
            }
            typeLable.textAlignment = NSTextAlignmentLeft;
            
            UILabel *linesLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 29.5, WIDTH, 0.5)];
            UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+60, WIDTH - 10, 0.5)];
            uplable.backgroundColor = gycoloers;
            linesLable.backgroundColor = gycoloers;
            
            
            UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, WIDTH-10, 20)];
            blable.text =[NSString stringWithFormat:@"报修时间%@",_receiveDataDic[@"post_time"]];
            blable.textColor = gycoloer;
            blable.textAlignment = NSTextAlignmentLeft;
            blable.font = [UIFont fontWithName:geshi size:14];
            UILabel *blinesLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59.5+60, WIDTH, 0.5)];
            blinesLable.backgroundColor = gycoloers;
            
            
            
            
            [aview addSubview:uplable];
            [aview addSubview:linesLable];
            [aview addSubview:typeLable];
            
            [aview addSubview:blable];
            [aview addSubview:blinesLable];
            
            if (ISOpen == YES) {
                aview.hidden = NO;
            }else
            {
                aview.hidden = YES;
            }
            return aview;
        }
        
    }else
    {
        if(section == 1)
        {
            UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
            twoView.backgroundColor = viewbackcolor;
            UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, W/2 - 40, 40)];
            leftButton.backgroundColor = FZColor(112, 19,28);
            leftButton.titleLabel.textColor = [UIColor whiteColor];
            UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2 + 20, 10, W/2 - 40, 40)];
            [leftButton addTarget: self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            leftButton.tag = 2110;
            leftButton.layer.cornerRadius = 5;
            if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
                
                if ([_STYLE isEqualToString:@"1"]) {
                    
                    [leftButton setTitle:@"分派工单" forState:UIControlStateNormal];
                }else{
                    
                    [leftButton setTitle:@"转移工单" forState:UIControlStateNormal];
                    
                }
                [rightButton setTitle:@"标记无效" forState:UIControlStateNormal];
                rightButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
                rightButton.layer.cornerRadius = 5;
                [rightButton setBackgroundColor:[UIColor blackColor]];
                [rightButton setBackgroundImage:[UIImage imagewithColor:gycoloer] forState:UIControlStateHighlighted];
                rightButton.tag = 2111;
                [rightButton addTarget:self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                rightButton.alpha = 0.3;
                [twoView addSubview:rightButton];
                
                
            }else
            {
                if ([_STYLE isEqualToString:@"1"]) {
                    
                    [leftButton setTitle:@"抢单" forState:UIControlStateNormal];
                    leftButton.frame = CGRectMake(20, 10, W - 40, 40);
                    
                }else{
                    [leftButton setTitle:@"处理工单" forState:UIControlStateNormal];
                    [rightButton setTitle:@"标记无效" forState:UIControlStateNormal];
                    rightButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
                    rightButton.layer.cornerRadius = 5;
                    [rightButton setBackgroundColor:[UIColor blackColor]];
                    [rightButton setBackgroundImage:[UIImage imagewithColor:gycoloer] forState:UIControlStateHighlighted];
                    rightButton.tag = 2111;
                    [rightButton addTarget:self action:@selector(leftbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                    rightButton.alpha = 0.3;
                    [twoView addSubview:rightButton];
                    
                }
            }
            
            [twoView addSubview:leftButton];
            return twoView;
        }else if(section == 0)
        {
            UIView *threeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 78)];
            threeView.backgroundColor = [UIColor whiteColor];
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
            [threeView addSubview:aview];
            [threeView addSubview:imageView];
            [threeView addSubview:alable];
            [threeView addSubview:blable];
            [threeView addSubview:upslable];
            [threeView addSubview:downsLable];
            return threeView;
        }
        else if(section == 2)
        {
            UIView *fouthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 80)];
            fouthView.backgroundColor = [UIColor whiteColor];
            UILabel *natureLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
            natureLable.text = @"工作性质 :";
            natureLable.textColor = gycolor;
            natureLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 80, 20)];
            naturelables.text = @"入室维修";
            if (_isAnBao) {
                naturelables.text = @"公众服务";
            }
            naturelables.textColor = gycoloer;
            
            UILabel *upline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
            upline.backgroundColor = gycoloers;
            UILabel *buttomLine = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, W, 0.5)];
            buttomLine.backgroundColor = gycoloers;
            
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, W-50, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:14];
            topLable.textColor = gycolor;
            topLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, WIDTH, 0.5)];
            downLable.backgroundColor = gycoloers;
            
            [fouthView addSubview:downLable];
            [fouthView addSubview:topLable];
            [fouthView addSubview:naturelables];
            [fouthView addSubview:natureLable];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            return fouthView;
        }else if(section == 3)
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(FiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
            uplable.backgroundColor = gycoloers;
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
            alable.text = @"工单详情";
            alable.textColor = gycolor;
            //            UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, W - 160, 20)];
            //            blable.text = _receiveDataDic[@"post_time"];
            //            blable.textColor = gycoloer;
            //            blable.textAlignment = NSTextAlignmentRight;
            //            blable.font = [UIFont fontWithName:geshi size:14];
            theimageview  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10,20, 20)];
            if (ISOpen == NO) {
                theimageview.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }else
            {
                theimageview.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, WIDTH, 0.5)];
            downLineLable.backgroundColor = gycoloers;
            [FiveView addSubview:theimageview];
            [FiveView addSubview:downLineLable];
            [FiveView addSubview:uplable];
            [FiveView addSubview:alable];
            //            [FiveView addSubview:blable];
            return FiveView;
        }else if (section == 5)
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
        }
        else
        {
            UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40+60)];
            aview.backgroundColor = [UIColor whiteColor];
            
#pragma mark - 这里要添加名字和电话
            UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0.5, WIDTH-10, 29.5)];
            nameLab.text=[NSString stringWithFormat:@"报修人：%@",_receiveDataDic[@"name"]];
            if (_isAnBao) {
                nameLab.text=[NSString stringWithFormat:@"预约人：%@",_receiveDataDic[@"name"]];
            }
            nameLab.textColor = gycoloer;
            nameLab.font = [UIFont fontWithName:geshi size:13];
            [aview addSubview:nameLab];
            UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, WIDTH, 0.5)];
            line1.backgroundColor = gycoloers;
            [aview addSubview:line1];
            
            UILabel *phoneLab=[[UILabel alloc]initWithFrame:CGRectMake(10, line1.frame.origin.y, WIDTH-30, 29.5)];
            phoneLab.text=[NSString stringWithFormat:@"联系电话：%@",_receiveDataDic[@"contact"]];
            phoneLab.textColor = gycoloer;
            phoneLab.font = [UIFont fontWithName:geshi size:13];
            [aview addSubview:phoneLab];
            
            UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH - 30, 0.5)];
            line2.backgroundColor = gycoloers;
            [aview addSubview:line2];
            
            UILabel *typeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5+60, WIDTH - 10, 20)];
            typeLable.textColor = gycoloer;
            typeLable.font = [UIFont fontWithName:geshi size:14];
            if ([servingtime isEqualToString:@""]) {
                typeLable.text = [NSString stringWithFormat:@"预约时间 : %@",@"尽快"];
                
            }else
            {
                typeLable.text = [NSString stringWithFormat:@"预约时间 : %@",servingtime];
                
            }
            typeLable.textAlignment = NSTextAlignmentLeft;
            UILabel *linesLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 29.5+60, WIDTH, 0.5)];
            UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0+60, WIDTH - 10, 0.5)];
            uplable.backgroundColor = gycoloers;
            linesLable.backgroundColor = gycoloers;
            
            UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(10, 35+60, WIDTH-10, 20)];
            blable.text =[NSString stringWithFormat:@"报修时间:%@",_receiveDataDic[@"post_time"]];
            if (_isAnBao) {
                blable.text =[NSString stringWithFormat:@"安保时间：%@",_receiveDataDic[@"post_time"]];
            }
            blable.textColor = gycoloer;
            blable.textAlignment = NSTextAlignmentLeft;
            blable.font = [UIFont fontWithName:geshi size:14];
            UILabel *blinesLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59.5+60, WIDTH, 0.5)];
            blinesLable.backgroundColor = gycoloers;
            
            
            [aview addSubview:uplable];
            [aview addSubview:linesLable];
            [aview addSubview:typeLable];
            
            [aview addSubview:blable];
            [aview addSubview:blinesLable];
            
            
            if (ISOpen == YES) {
                aview.hidden = NO;
            }else
            {
                aview.hidden = YES;
            }
            return aview;
        }
        
    }
}
-(void)FiveViewDidClicked
{
    if (ISTIMERSTR == YES) {
        voicetimelables = nil;
        [changeImagetimer invalidate];
        changeImagetimer = nil;
        //结束定时器
        [timer invalidate];
        [self.audioPlayer stop];
        ISTIMERSTR = NO;
    }
    if (ISOpen == NO) {
        ISOpen = YES;
    }else
    {
        ISOpen = NO;
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

    
    GJUnexeChildTableViewCell *acell = [GJUnexeChildTableViewCell createCellWithTableView:tableView withIdentifier:@"unexechildflags"];
    //问题描述
    acell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *questLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH - 20, 40)];
    questLable.textColor = gycoloer;
    questLable.font = [UIFont fontWithName:geshi size:14];
    questLable.numberOfLines = 0;
    questLable.lineBreakMode = NSLineBreakByTruncatingTail;
    questLable.text = _receiveDataDic[@"description"];
    CGSize maximumLabelSize = CGSizeMake(WIDTH - 20, 9999);
    CGSize expectSize = [questLable sizeThatFits:maximumLabelSize];
    questLable.frame = CGRectMake(10, 10, expectSize.width, expectSize.height);
    //音频
    UIButton *voiceButton = [[UIButton alloc]init];
    [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
    [voiceButton addTarget:self action:@selector(UNExePlayVoiceChildButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    timeLable = [[UILabel alloc]init];
    timeLable.backgroundColor = [UIColor clearColor];
    timeLable.textColor = NAVCOlOUR;
    timeLable.font = [UIFont fontWithName:geshi size:15];
    timeLable.textAlignment = NSTextAlignmentLeft;
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
        }else
        {
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
            if (ImageChange%3 == 2) {
                [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_11@2x"]];
            }else if(ImageChange%3 == 1)
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
    CGFloat x = 10;
    CGFloat y = expectSize.height + 20;
    allDataImageArray = [NSMutableArray array];
    // 视频和图片
    if (videoDataArray.count != 0)
    {
        if (ShowImageDataArray.count != 0)
        {
            for (int i = 0; i < ShowImageDataArray.count; i++) {
                [allDataImageArray addObject:ShowImageDataArray[i]];
            }
            [allDataImageArray insertObject:videoimageDataArray[0] atIndex:0];
            CGRect frame = CGRectMake(25, expectSize.height + 20, imageButtonW, imageButtonW);
            for (int i = 0 ; i < allDataImageArray.count; i ++)
            {
                UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, expectSize.height + 20, imageButtonW, imageButtonW)];
                UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0)
                {
                    if ([_ISLOCATION isEqualToString:@"YES"]) {
                        [imageview setImage:videoimageDataArray[0]];
                    }else
                    {
                        [imageview sd_setImageWithURL:videoimageDataArray[0] placeholderImage:[UIImage imageNamed:@"100x100"]];
                    }
                    UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageButtonW/2 - 15, imageButtonW/2 - 15, 30, 30)];
                    bofangimageView.backgroundColor = [UIColor clearColor];
                    bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
                    [imageview addSubview:bofangimageView];
                }else
                {
                    if ([_ISLOCATION isEqualToString:@"YES"]) {
                        [imageview setImage:ShowImageDataArray[i - 1]];
                    }else
                    {
                        [imageview sd_setImageWithURL:ShowImageDataArray[i - 1] placeholderImage:[UIImage imageNamed:@"100x100"]];
                    }
                }
                if (i < 4) {
                    y = expectSize.height + 20;
                }else if(i >= 8)
                {
                    y = expectSize.height + 40 + 2 *imageButtonW;
                }else
                {
                    y = expectSize.height + 25 + imageButtonW;
                }
                if (i > 3 && i < 8) {
                    x = (i - 4) * (imageButtonW + 10)+10;
                }
                else if (i == 8)
                {
                    x = 10;
                }else if (i == 9)
                {
                    x = 20 + imageButtonW;
                }
                else
                {
                    x = 10*(i+1)+i*imageButtonW;
                }
                frame.origin.x = x;
                frame.origin.y = y;
                [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                imageButton.tag = i;
                imageButton.frame = CGRectMake(x, y, imageButtonW, imageButtonW);
                [imageButton addSubview:imageview];
                [acell.contentView addSubview:imageButton];
                
            }
            if (voiceDataArray.count != 0) {
                voiceButton.frame = CGRectMake(10, y + imageButtonW +10, voiceLength, 28);
                timeLable.frame = CGRectMake(voiceLength + 20, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
                cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
            }else
            {
                cellHeight = y + imageButtonW + 10;
            }
        }
        else
        {
            UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(10, expectSize.height + 20, imageButtonW, imageButtonW)];
            UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
            if ([_ISLOCATION isEqualToString:@"YES"]) {
                [imageview setImage:videoimageDataArray[0]];
            }else
            {
                NSURL *url = [videoimageDataArray objectAtIndex:0];
                [imageview sd_setImageWithURL:url];
            }
            
            UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageButtonW/2 - 15, imageButtonW/2 - 15, 30, 30)];
            bofangimageView.backgroundColor = [UIColor clearColor];
            bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
            [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
            [imageview addSubview:bofangimageView];
            [imageButton addSubview:imageview];
            [acell.contentView addSubview:imageButton];
            cellHeight = CGRectGetMaxY(imageButton.frame) + 10;
            if (voiceDataArray.count != 0) {
                voiceButton.frame = CGRectMake(10,CGRectGetMaxY(imageButton.frame)+20, voiceLength, 28);
                timeLable.frame = CGRectMake(voiceLength+ 20, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
                cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
            }
        }
    }
    else if (videoDataArray.count == 0 && ShowImageDataArray.count != 0)
    {
        CGFloat x = 10;
        CGFloat y = expectSize.height + 20;
        for (int i = 0; i < ShowImageDataArray.count; i ++) {
            CGRect frame = CGRectMake(0, y, imageButtonW, imageButtonW);
            UIButton *imageButton = [[UIButton alloc]initWithFrame:frame];
            UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
            [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
            if ([_ISLOCATION isEqualToString:@"YES"]) {
                [imageview setImage:ShowImageDataArray[i]];
            }else
            {
                [imageview sd_setImageWithURL:ShowImageDataArray[i] placeholderImage:[UIImage imageNamed:@"100x100"]];
            }
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
                x = (i - 4) * (imageButtonW + 10)+10;
            }
            else if (i == 8)
            {
                x = 10;
            }
            else
            {
                x = 10 * (i+1)+i * imageButtonW;
            }
            frame.origin.x = x;
            frame.origin.y = y;
            imageButton.tag = i;
            imageButton.frame = CGRectMake(x, y, imageButtonW, imageButtonW);
            [imageButton addSubview:imageview];
            [acell.contentView addSubview:imageButton];
            if (i == ShowImageDataArray.count - 1)
            {
                cellHeight = CGRectGetMaxY(imageButton.frame)+20;
            }
        }
        if (voiceDataArray.count != 0) {
            voiceButton.frame = CGRectMake(10,y + 20 + imageButtonW, voiceLength, 28);
            timeLable.frame = CGRectMake(voiceLength + 20, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
            cellHeight = CGRectGetMaxY(voiceButton.frame)+10;
        }
    }else if (videoDataArray.count == 0 && ShowImageDataArray.count == 0 && voiceDataArray.count != 0)
    {
        voiceButton.frame = CGRectMake(10, CGRectGetMaxY(questLable.frame) + 20, voiceLength, 28);
        timeLable.frame = CGRectMake(voiceLength + 20, CGRectGetMinY(voiceButton.frame) - 3, 160, 30);
        cellHeight = CGRectGetMaxY(voiceButton.frame)+20;
    }else if (videoDataArray.count == 0 && ShowImageDataArray.count == 0 && voiceDataArray.count == 0)
    {
        cellHeight = CGRectGetMaxY(questLable.frame)+20;
    }
    [acell.contentView addSubview:questLable];
    return acell;
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
                
                theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];
                
            }
        }
        
        [_GRtableview reloadData];
    }
}

-(void)leftbuttonDidClicked:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (sender.tag == 2110) {
        if ([[userdefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            
            [self getMaintenancemaster];
            
            
        }else
        {
            
            if ([_STYLE isEqualToString:@"1"]) {
                
                
#pragma mark - 抢单功能实现
                NSString *repairID = _receiveDataDic[@"repair_id"];
                NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
                GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
                
                if ([model.property_id isEqualToString:@""]) {
                    //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
                    //return;
                }
                
                // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *property_ids = model.property_id;
                
                NSString * fstr = @"repair";
                
                if (_isAnBao) {
                    fstr = @"security";
                }
                GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
                [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"grab" andBodyOfRequestForKeyArr:@[@"repair_id",@"property_id"] andValueArr:@[repairID,property_ids] andBlock:^(id dictionary)
                 {
                     
                     NSLog(@"%@",property_ids);
                     NSLog(@"%@",repairID);
                     NSLog(@"%@",dictionary);
                     
                     state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
                     if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                         [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                             [self presentViewController:loginVC animated:YES completion:nil];
                         });
                     }
                     else if([state isEqualToString:@"0"])
                     {
                         [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
                     }else if ([state isEqualToString:@"-1"])
                     {
                         [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
                     }
                     else if([state isEqualToString:@"1"])
                     {
                         
                         [GJSVProgressHUD showWithStatus:dictionary[@"return_data"]];
                         
                         double delayInSeconds = 1.0;
                         //创建一个调度时间,相对于默认时钟或修改现有的调度时间。
                         dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                         //推迟两纳秒执行
                         dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                         dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
                             [self yanzheng:repairID];
                             
                         });
                         
                         //                 再走个接口实现这三个
                         //                 [GJSVProgressHUD showSuccessWithStatus:@"抢单成功"];
                         //                 [backGroundButton removeFromSuperview];
                         //                 [self getVoicewageDataWork];
                     }
                 }];
            }else{
                self.ReceiveWagealert = [[UIAlertView alloc] initWithTitle:nil message:@"确定现在处理工单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                self.ReceiveWagealert.delegate = self;
                [self.ReceiveWagealert show];
                
            }
            
            
            
        }
    }else
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.coverButton = [[UIButton alloc]initWithFrame:window.frame];;
        self.coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        [window addSubview:self.coverButton];
        cancelView = [[UIView alloc]initWithFrame:CGRectMake(20, HEIGHT/2 - 200, WIDTH - 40,320 )];
        cancelView.backgroundColor = [UIColor whiteColor];
        cancelView.layer.cornerRadius = 8.0;
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 5,WIDTH - 140, 49)];
        titleLable.backgroundColor = [UIColor whiteColor];
        titleLable.textColor = gycolor;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont fontWithName:geshi size:22];
        titleLable.text = @"标记无效";
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, WIDTH - 40, 1)];
        lineLable.backgroundColor = NAVCOlOUR;
        UIButton *CloseButton = [[UIButton alloc]initWithFrame:CGRectMake(10,20 , 20, 20)];
        CloseButton.backgroundColor = [UIColor clearColor];
        [CloseButton setBackgroundImage:[UIImage imageNamed:@"icon_n_20x@2x"] forState:UIControlStateNormal];
        [CloseButton addTarget:self action:@selector(CoverClosebutton) forControlEvents:UIControlEventTouchUpInside];
        [cancelView addSubview:CloseButton];
        
        
        
        opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, WIDTH - 40, 180)];
        opinionView.backgroundColor = buttonHighcolor;
        opinionView.font = [UIFont fontWithName:geshi size:17];
        opinionView.delegate = self;
        placeLables = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, WIDTH - 40, 40)];
        placeLables.backgroundColor = [UIColor clearColor];
        placeLables.text = @"请输入取消原因";
        placeLables.textAlignment = NSTextAlignmentLeft;
        placeLables.enabled = NO;
        placeLables.textColor = gycoloers;
        [opinionView addSubview:placeLables];
        
        
        UIButton *CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 260, WIDTH - 80, 40)];
        CancelButton.layer.cornerRadius = 8.0;
        [CancelButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
        [CancelButton setTitle:@"确定" forState:UIControlStateNormal];
        [CancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [CancelButton addTarget:self action:@selector(YESCaleButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [cancelView addSubview:titleLable];
        [cancelView addSubview:lineLable];
        [cancelView addSubview:opinionView];
        [cancelView addSubview:CancelButton];
        [self.coverButton addSubview:cancelView];
        [window addSubview:self.coverButton];
        
    }
}
-(void)yanzheng:(NSString *)str
{
    NSString * fstr = @"repair";
    if (_isAnBao) {
        fstr = @"security";
    }
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"confirm_grab" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[str] andBlock:^(id dictionary)
     {
         
         
         
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [GJSVProgressHUD dismiss];
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }
         else if([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }
         else if([state isEqualToString:@"1"])
         {
             
             
             
             
             //                 再走个接口实现这三个
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
             
             [self.navigationController popViewControllerAnimated:YES];
             
             //                      创建fmdb
             GJYTKKeyValueStore *store = [[GJYTKKeyValueStore alloc] initDBWithName:@"repaird.db"];
             NSString *tableName = repaird_table;
             // 创建名为user_table的表，如果已存在，则忽略该操作
             [store createTableWithName:tableName];
             
             //             添加fmdb
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             // 设置时间格式
             formatter.dateFormat = @"yyyy-MM-dd HH:mm";
             NSString *start_time = [formatter stringFromDate:[NSDate date]];
             
             NSString *key =str;
             NSDictionary *user = @{@"id": str, Start_Time: start_time};
             [store putObject:user withId:key intoTable:tableName];

             
         }
     }];
    
}

#pragma mark - 分派工单
-(void)getOwnerDatas
{
    self.coverButton = [[UIButton alloc]init];
    self.coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.coverButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
    window = [UIApplication sharedApplication].keyWindow;
    self.coverButton.frame = window.bounds;
    apportionView = [[UIView alloc]initWithFrame:CGRectMake(20, 90, WIDTH-40 , 438)];
    
    
    apportionView.layer.masksToBounds = YES;
    //设置元角度
    apportionView.layer.cornerRadius = 6.0;
    //设置边线
    //    apportionView.backgroundColor = viewbackcolor;
    apportionView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, apportionView.size.width, 50)];
    titleLable.text = @"分派工单";
    titleLable.font = [UIFont fontWithName:geshi size:19];
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    UIButton *dismisButton = [[UIButton alloc]initWithFrame:CGRectMake(apportionView.size.width - 40, 10, 30, 30)];
    [dismisButton setBackgroundImage:[UIImage imageNamed:@"dialog_back"] forState:UIControlStateNormal];
    [dismisButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
    [apportionView addSubview:dismisButton];
    
    UIView *hengL=[[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, WIDTH-40, 0.5)];
    hengL.backgroundColor=NAVCOlOUR;
    [apportionView addSubview:hengL];
    
    
    //              第一个选项
    //转移人员array     workNameArray
    
    //    GJFZPWorkMenuView *menuView = [[GJFZPWorkMenuView alloc]initWithFrame:CGRectMake(20, 50+15, apportionView.size.width - 40, 40)];
    //    menuView.worknameDelegates = self;
    //    menuView.backgroundColor = [UIColor whiteColor];
    //    menuView.tableArray = workNameArray;
    //    [apportionView addSubview:menuView];
    
    UILabel *firL=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, apportionView.bounds.size.width-15, 45)];
    firL.text=@"请选择维修人员";
    if (_isAnBao) {
         firL.text=@"请选择安保人员";
    }
    firL.textColor=gycolor;
    firL.font=[UIFont systemFontOfSize:16];
    firL.textAlignment=NSTextAlignmentLeft;
    [apportionView addSubview:firL];
    
    
    UIView *hengL2=[[UIView alloc]initWithFrame:CGRectMake(15, 50+45-0.5, apportionView.bounds.size.width-15, 0.5)];
    hengL2.backgroundColor=gycoloer;
    [apportionView addSubview:hengL2];
    NSLog(@"%@",workNameArray);
    _GRtableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 95, apportionView.bounds.size.width, 45*3)];
    
    
    _GRtableview.delegate=self;
    _GRtableview.dataSource=self;
    [apportionView addSubview:_GRtableview];
    
    
    
    
    //              备注
    opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 95+45*3+10,apportionView.size.width, 100)];
    opinionView.backgroundColor =FZColor(245, 245, 245);
    opinionView.font = [UIFont fontWithName:geshi size:15];
    opinionView.delegate = self;
    
    placeLables = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
    placeLables.enabled = NO;
    placeLables.delegate = self;
    placeLables.text = @"请在此输入备注...";
    placeLables.font =  [UIFont systemFontOfSize:15];
    placeLables.textColor = gycoloer;
    [opinionView addSubview:placeLables];
    
    
    
    UIButton *yesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 95+45*3+100+30, apportionView.width - 40, 40)];
    
    [yesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [yesButton setTitle:@"确定" forState:UIControlStateNormal];
    if (_isAnBao) {
        [yesButton addTarget: self action:@selector(YESButtonDidClicked_ls) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [yesButton addTarget: self action:@selector(YESButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [apportionView addSubview:opinionView];
    [apportionView addSubview:titleLable];
    [apportionView addSubview:yesButton];
    [self.coverButton addSubview:apportionView];
    [window addSubview:self.coverButton];
}

-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[worknameID]];
}
-(void)Closebutton
{
    [_coverButton removeFromSuperview];
    Srow=0;
}
-(void)reloadData
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
    NSString *property_id = model.property_id;
    NSString *community_id = model.community_id;
    NSString *role = [userDefaults objectForKey:@"role"];
    NSString *repairdID = [NSString stringWithFormat:@"%@",_receiveDataDic[@"repair_id"]];
    NSString *SQLrepairdID = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",mobile_phone,property_id,community_id,role,repairdID];
    BOOL update = [_db executeUpdate:@"update contact set phone = ? where name = ?",@"1",SQLrepairdID];
    if (update) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新数据失败");
    }
    
    
    
    videoImageArray = [NSMutableArray array];
    videoimageDataArray = [NSMutableArray array];
    imagedataArray = [NSMutableArray array];
    voiceDataArray = [NSMutableArray array];
    videoDataArray = [NSMutableArray array];
    voiceTimeArray = [NSMutableArray array];
    ShowImageDataArray = [NSMutableArray array];
    Datadict = _receiveDataDic[@"ivv_json"];
    NSArray *imageArray = [NSArray array];
    NSArray *videoArray = [NSArray array];
    NSArray *voiceArray = [NSArray array];
    imageArray = Datadict[@"images"];
    videoArray = Datadict[@"video"];
    voiceArray = Datadict[@"voice"];
    servingtime = _receiveDataDic[@"serving_time"];
    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
    if ([_ISLOCATION isEqualToString:@"YES"]) {
        for (int i = 0; i < imageArray.count; i ++) {
            [imagedataArray addObject:[GJMHPhotoModel photoWithImage:imageArray[i]]];
            [ShowImageDataArray addObject:imageArray[i]];
        }
    }else
    {
        for (NSDictionary *imagedic in imageArray)
        {
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
    }
    if ([_ISLOCATION isEqualToString:@"YES"]) {
        for (NSDictionary *videoDic in videoArray) {
            [videoDataArray addObject:videoDic[@"video"]];
            [videoimageDataArray addObject:videoDic[@"video_img"]];
        }
    }else
    {
        for (NSDictionary *videoDic in videoArray) {
            NSString *str = videoDic[@"video"];
            [videoDataArray addObject:str];
            NSString *str1 = videoDic[@"video_img_ico"];
            [videoimageDataArray addObject:[NSString stringWithFormat:@"%@%@",@"",str1]];
        }
    }
    for (NSDictionary *voiceDic in voiceArray) {
        NSString *str = voiceDic[@"voice"];
        NSString *time = [NSString stringWithFormat:@"%@",voiceDic[@"voice_time"]];
        [voiceTimeArray addObject:time];
        [voiceDataArray addObject:str];
    }
}

//播放音频
-(void)UNExePlayVoiceChildButtonDidClicked
{
    if (ISTIMERSTR == YES) {
        ISTIMERSTR = NO;
        if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }else
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
        //结束定时器
        [timer invalidate];
        [changeImagetimer invalidate];
        [self.audioPlayer stop];
    }else
    {
        ISTIMERSTR = YES;
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        //播放
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        NSString *voicetoustr = [userdefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceDataArray[0]];
        //播放本地音乐
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *filePath = [NSString stringWithFormat:@"/%@.mp3",[formater stringFromDate:[NSDate date]]];
        [self downloadFileURL:VoiceUrl savePath:docDirPath fileName:filePath];
        thetime = [[voiceTimeArray objectAtIndex:0] intValue];
        ImageChange = thetime * 2;
        voiceTimeLable.text = [voiceTimeArray objectAtIndex:0];
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
            NSLog(@"VoiceUrl___%@",VoiceUrl);
            NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:VoiceUrl]];
            [audioData writeToFile:fileName atomically:YES];
            [userDefaults setObject:fileName forKey:aUrl];
            [userDefaults synchronize];
            [self.audioPlayer playURL:[NSURL URLWithString:VoiceUrl]];
        }
    }
    //启动定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVoiceImage:) userInfo:nil repeats:YES];
    changeImagetimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeVoiceImages:) userInfo:nil repeats:YES];
}

-(void)changeVoiceImage:(NSTimer *)time
{
    ISTIMERSTR = YES;
    thetime -= 1;
    voicetimelables = [NSString stringWithFormat:@"%d",thetime];
    
    if (thetime == 0) {
        voicetimelables = nil;
        //结束定时器
        [timer invalidate];
        [self.audioPlayer stop];
        ISTIMERSTR = NO;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
-(void)changeVoiceImages:(NSTimer *)time
{
    ImageChange -= 1;
    if (thetime == 0) {
        //结束定时器
        [changeImagetimer invalidate];
        changeImagetimer = nil;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
        [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
    NSString *VideoUrl;
    if ([_ISLOCATION isEqualToString:@"YES"]) {
        VideoUrl = [videoDataArray[0] absoluteString];
    }else
    {
        VideoUrl = [NSString stringWithFormat:@"%@%@",@"",playVideoStr];
    }
    
    
//    if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
//
//        [self.unexeDelegates PushVideoVCDidClicked:VideoUrl];
//        
//    }
//    else
//    {
//        NSLog(@"协议方案未实现");
//    }
    NSLog(@"PlayvideoStr___%@",VideoUrl);
    GJZXVideo *video = [[GJZXVideo alloc] init];
    video.playUrl = VideoUrl;
    //video.title = @"Rollin'Wild 圆滚滚的";
    GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
    vc.video = video;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)ImageDisMiss:(UIButton *)sender
{
    [sender removeFromSuperview];
}
-(void)CoverClosebutton
{
    [self.coverButton removeFromSuperview];
    

}
-(void)YESCaleButtonDidClicked
{
    if (opinionView.text == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请输入无效原因！"];
    }else
    {
        [GJSVProgressHUD showWithStatus:@"标记中"];
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        NSString * fstr = @"repair";
        NSArray * keyArr = @[@"rep[repair_id]",@"rep[work_remarks]"];
        if (_isAnBao) {
            fstr = @"security";
            keyArr = @[@"repair_id",@"work_remarks"];
        }
        
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"edit_invalid" andBodyOfRequestForKeyArr:keyArr andValueArr:@[_receiveDataDic[@"repair_id"],opinionView.text] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.unexeDelegates PushLoginVCDidClicked];
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
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }];
        [self.coverButton removeFromSuperview];
    }
}
///转移工单-ls
-(void)YESButtonDidClicked_ls
{
    NSString *property_ids;
    
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];
    
    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择安保人员！"];
    }else
    {
        [GJSVProgressHUD showWithStatus:@"分派中"];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"repair_transfer" andBodyOfRequestForKeyArr:@[@"repair_id",@"repair_user_id",@"appointed_time",@"remarks",@"type"] andValueArr:@[_receiveDataDic[@"repair_id"],theworkID,servingtime,opinionView.text,@"S"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.unexeDelegates PushLoginVCDidClicked];
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
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }];
        [self.coverButton removeFromSuperview];
    }
}

-(void)YESButtonDidClicked
{
    NSString *property_ids;
    
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];

    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }else
    {
        [GJSVProgressHUD showWithStatus:@"分派中"];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[appointed_time]",@"rep[remarks]",@"type"] andValueArr:@[property_ids,_receiveDataDic[@"repair_id"],theworkID,servingtime,opinionView.text,@"S"] andBlock:^(id dictionary)
         {
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.unexeDelegates PushLoginVCDidClicked];
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
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
                 [self.navigationController popViewControllerAnimated:YES];
             }
         }];
        [self.coverButton removeFromSuperview];
    }
}
#pragma mark- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [placeLables setHidden:NO];
    }else{
        [placeLables setHidden:YES];
    }
}
//当键盘出现或改变时调用
- (void)unexechildkeyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    height = keyboardRect.size.height;
    CGRect Frame =  CGRectMake (20, 90-height+45*3, WIDTH-40 , 438);
    
    [apportionView setFrame: Frame];
    
    CGRect Frames = CGRectMake (20,HEIGHT/2 -200 - (height - (HEIGHT - HEIGHT/2 - 120))  ,WIDTH - 40, 320);
    [cancelView setFrame:Frames];
    
    CGRect Fvrame =  CGRectMake (20, 90-height+45*3, WIDTH-40 , 438);
    [transferView setFrame: Fvrame];
    
}
//输入结束
- (void)unexechildkeyboardWillHide:(NSNotification *)aNotification
{
    
    CGRect Frame = CGRectMake (20, 90, WIDTH-40 , 438);
    CGRect Frames = CGRectMake (20, HEIGHT/2 - 200, WIDTH - 40,320);
    [apportionView setFrame: Frame];
    [cancelView setFrame: Frames];
    
    CGRect Fvrame = CGRectMake (20, 90, WIDTH-40 , 438);
    [transferView setFrame: Fvrame];
}
-(void)getMaintenancemaster
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        // return;
    }
    
    
    NSString *property_ids;
    NSString *community_ids;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    property_ids = model.property_id;
    community_ids = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_who" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"start_num",@"per_pager_nums"] andValueArr:@[property_ids,community_ids,@"0",@"10"] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.unexeDelegates PushLoginVCDidClicked];
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
             workIdarray = [NSMutableArray array];
             workNameArray = [NSMutableArray array];
             for (NSDictionary *dict in dictionary[@"return_data"]) {
                 NSString *userid = dict[@"user_id"];
                 NSString *turename = dict[@"ture_name"];
                 [workIdarray addObject:userid];
                 [workNameArray addObject:turename];
             }
             if ([_STYLE isEqualToString:@"1"]) {
                 [self getOwnerDatas];
                 
             }else{
                 [self zhuanyi];
                 
                 
                 
             }
             
         }
         
     }];
}

#pragma mark - 转移工单
-(void)zhuanyi
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
    
    
    
    
    
    opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 95+45*3+10,transferView.size.width, 100)];
    opinionView.backgroundColor =FZColor(245, 245, 245);
    opinionView.font = [UIFont fontWithName:geshi size:15];
    opinionView.delegate = self;
    
    placeLables = [[UITextField alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
    placeLables.enabled = NO;
    placeLables.delegate = self;
    placeLables.text = @"请在此输入备注...";
    placeLables.font =  [UIFont systemFontOfSize:15];
    placeLables.textColor = gycoloer;
    [opinionView addSubview:placeLables];
    
    UIButton *yesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 95+45*3+100+30, transferView.width - 40, 40)];
    [yesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [yesButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [yesButton addTarget: self action:@selector(TransferButtoDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [transferView addSubview:titleLable];
    
    
    [transferView addSubview:opinionView];
    [transferView addSubview:yesButton];
    [backButtonView addSubview:transferView];
    [window addSubview:backButtonView];
    
}
//提交工单
-(void)TransferButtoDidClicked:(NSInteger) tag
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
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];

    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }
//    else if (worktimelable == nil)
//    {
//        [GJSVProgressHUD showErrorWithStatus:@"请选择预约时间！"];
//    }
    else if (opinionView.text == nil)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入转移原因！"];
    }else
    {
        
        NSString *repairID = _receiveDataDic[@"repair_id"];
        
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[remarks]",@"type"] andValueArr:@[property_ids,repairID,theworkID,opinionView.text,@"E"] andBlock:^(id dictionary)
         {
             NSLog(@"%@",dictionary);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.unexeDelegates PushLoginVCDidClicked];
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
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
                 
                 [self.navigationController popToRootViewControllerAnimated:YES];
                 
                 
             }
         }];
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
}
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



//弹窗
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [alertView removeFromSuperview];
    }else
    {
        NSString *repairID = _receiveDataDic[@"repair_id"];
        
#pragma mark - QQQ判断要不要签名
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        NSString *qM;
        if (_isAnBao) {
            qM=[NSString stringWithFormat:@"%@",[def objectForKey:@"isAnbao_autograph"]];
        }else{
            qM=[NSString stringWithFormat:@"%@",[def objectForKey:@"is_autograph"]];
        }
        
        if ([qM isEqualToString:@"F"]) {
            
            if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(QianMing:)]) {
                [self.unexeDelegates QianMing:repairID];
            }
            else
            {
                NSLog(@"协议方案未实现");
            }
        }else{
        
        [self ReceiveWage];
        }
    }
}
//接受工单
-(void)ReceiveWage
{
    NSString *property_ids;
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        return;
    }else{
        property_ids = model.property_id;
    }
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [GJSVProgressHUD showWithStatus:@"接受中"];
    NSString * fstr = @"repair";
    if (_isAnBao) {
        fstr = @"security";
    }
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"receive" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[_receiveDataDic[@"repair_id"]] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.unexeDelegates && [self.unexeDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.unexeDelegates PushLoginVCDidClicked];
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
             [[NSNotificationCenter defaultCenter]postNotificationName:@"unExecutedfishWage" object:nil];
             [self.navigationController popViewControllerAnimated:YES];
             
             
             //                      创建fmdb
             GJYTKKeyValueStore *store = [[GJYTKKeyValueStore alloc] initDBWithName:@"repaird.db"];
             NSString *tableName = repaird_table;
             // 创建名为user_table的表，如果已存在，则忽略该操作
             [store createTableWithName:tableName];
             
             //             添加fmdb
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             // 设置时间格式
             formatter.dateFormat = @"yyyy-MM-dd HH:mm";
             NSString *start_time = [formatter stringFromDate:[NSDate date]];
             
             NSString *key =_receiveDataDic[@"repair_id"];
             NSDictionary *user = @{@"id": _receiveDataDic[@"repair_id"], Start_Time: start_time};
             [store putObject:user withId:key intoTable:tableName];
             
             
             
             
         }
     }];
}
@end
