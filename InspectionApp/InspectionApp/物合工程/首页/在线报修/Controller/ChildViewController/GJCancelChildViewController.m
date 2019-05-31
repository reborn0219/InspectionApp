//
//  GJCancelChildViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

//已经取消

#import "GJCancelChildViewController.h"
#define imageButtonW (WIDTH - 50)/4
#import "GJSDAdScrollView.h"
#import "GJOverChildTableViewCell.h"
#import "GJOverChildTableViewTwoCell.h"
#import "GJOverChildTableViewThreeCell.h"
#import "GJOverTableViewFouthCell.h"

@interface GJCancelChildViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
{
    BOOL ISOpenOne;
    BOOL ISOpenTwo;
    BOOL ISOpenThree;
    BOOL ISOpenFouth;
    CGFloat cellHeight;
    UIImageView *Fouthimageview;
    UIImageView *FiveImageView;
    UIImageView *sixImageView;
    UIImageView *senvenImageView;
    
    //存储数据源数量
    NSMutableArray *allDataArray;
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
    NSArray *scrollerArray;
    //存放整体图片
    NSMutableArray *allDataImageArray;
    NSArray *acceptanceArray;
    //线
    UILabel *linesLable;
    NSInteger *lineHeight;
    GJOverChildTableViewTwoCell *bcell;
    GJOverChildTableViewThreeCell *CCell;
    //存储相片视频音频
    NSDictionary *Datadict;
    
    //服务费
    NSString *servicecharge;
    //材料费
    NSString *materialfee;
    //业主承担总费用
    NSString *ownercost;
    //业主网上支付费用
    NSString *online_pay_cost;
    //入户时间
    NSString *comeintime;
    //出户时间
    NSString *comeouttime;
    //完成时间
    NSString *finishedtime;
    
    //音频Url
    NSString *VoiceUrl;
    //音频时间
    UILabel *voiceTimeLable;
    //播放音频按钮
    UIButton *PlayVoiceButton;
    NSTimer *timer;
    float times;
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
    
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;

@end

@implementation GJCancelChildViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
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
    UILabel *titlelable = [UILabel lableWithName:@"工单详情"];
    self.navigationItem.titleView = titlelable;
    self.view.backgroundColor = viewbackcolor;
    ISOpenOne = YES;
    ISOpenTwo = YES;
    ISOpenThree = YES;
    ISOpenFouth = YES;
    ISTIMERSTR = NO;
    self.tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableview.backgroundColor = viewbackcolor;
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.view = self.tableview;
    [self reloadData];
}
//返回cell行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        return 6;
        
    }else{
        return 7;
        
    }
}
//返回headview高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (section == 0)
        {
            return 120;
        }else if (section == 5)
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
            return 80;
        }else if (section == 6)
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
        }else if(section == 3)
        {
            if (ISOpenThree == NO)
            {
                return 0;
            }else
            {
                return 1;
            }
        }else if (section == 4)
        {
            if (ISOpenFouth == NO) {
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
        
    }else{
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
        }else if(section == 4)
        {
            if (ISOpenThree == NO)
            {
                return 0;
            }else
            {
                return 1;
            }
        }else if (section == 5)
        {
            if (ISOpenFouth == NO) {
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
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (indexPath.section == 1) {
            return cellHeight + 40+30;
        }else if(indexPath.section == 2)
        {
            return 240;
        }else if (indexPath.section == 3)
        {
            return 90;
        }
        else if(indexPath.section == 4)
        {
            return 30;
        }
        else
        {
            return 0;
        }
        
    }else
    {
        if (indexPath.section == 2) {
            return cellHeight + 40+30+60;
        }else if(indexPath.section == 3)
        {
            return 240;
        }else if (indexPath.section == 4)
        {
            return 90;
        }
        else if(indexPath.section == 5)
        {
            return 30;
        }
        else
        {
            return 0;
        }
        
    }
}
//返回尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        if (section == 0) {
            return 8;
        }else
        {
            return 0;
        }
    }else
    {
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
            
            
            
            UILabel *workTypeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, W, 40)];
            workTypeLable.textColor = gycolor;
            workTypeLable.textAlignment = NSTextAlignmentLeft;
            workTypeLable.text = @"工作性质 : 公共区域报修";
            workTypeLable.font = [UIFont fontWithName:geshi size:15];
            UILabel *lineLbale1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 79.5, WIDTH - 10, 0.5)];
            lineLbale1.backgroundColor = gycoloers;
            
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, WIDTH - 10, 0.5)];
            lineLable.backgroundColor = gycoloers;
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, W, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:15];
            topLable.textColor = gycolor;
            [threeView addSubview:gongg];
            [threeView addSubview:lineLable];
            [threeView addSubview:topLable];
            [threeView addSubview:workTypeLable];
            [threeView addSubview:lineLbale1];
            
            return threeView;
        }else if(section == 1)
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
            //            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, WIDTH - 160, 20)];
            //            naturelables.text = _receiveDataDic[@"post_time"];
            //            naturelables.textAlignment = NSTextAlignmentRight;
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
            //            [fouthView addSubview:naturelables];
            [fouthView addSubview:wagedetails];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            return fouthView;
        }else if(section == 2)
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(exeFiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"执行情况";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1, 15)];
            downLineLable.backgroundColor = gycoloers;
            UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, WIDTH - 170, 20)];
            rightLable.textColor = gycoloer;
            rightLable.font = [UIFont fontWithName:geshi  size:13];
            rightLable.textAlignment = NSTextAlignmentRight;
            rightLable.text = [_receiveDataDic objectForKey:@"repair_status"];
            FiveImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenTwo == YES) {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [FiveView addSubview:downLineLable];
            [FiveView addSubview:lineLable];
            [FiveView addSubview:imageView];
            [FiveView addSubview:FiveImageView];
            [FiveView addSubview:linelable];
            [FiveView addSubview:alable];
            [FiveView addSubview:rightLable];
            return FiveView;
        }else if (section == 3)
        {
            UIButton *sixView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [sixView addTarget:self action:@selector(OversixViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            sixView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"验收状态";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, WIDTH - 170, 20)];
            rightLable.textColor = gycoloer;
            rightLable.font = [UIFont fontWithName:geshi  size:13];
            rightLable.textAlignment = NSTextAlignmentRight;
            rightLable.text = @"已验收";
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1, 15)];
            downLineLable.backgroundColor = gycoloers;
            sixImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenThree == YES) {
                sixImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                sixImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [sixView addSubview:downLineLable];
            [sixView addSubview:lineLable];
            [sixView addSubview:imageView];
            [sixView addSubview:sixImageView];
            [sixView addSubview:linelable];
            [sixView addSubview:alable];
            [sixView addSubview:rightLable];
            return sixView;
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
        }else
        {
            UIButton *senvenView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [senvenView addTarget:self action:@selector(OversenvenViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            senvenView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"物业反馈";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x43"];
            UILabel *DownLineLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH, 0.5)];
            DownLineLable.backgroundColor = gycoloers;
            senvenImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenFouth == YES) {
                senvenImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                senvenImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [senvenView addSubview:DownLineLable];
            [senvenView addSubview:lineLable];
            [senvenView addSubview:imageView];
            [senvenView addSubview:senvenImageView];
            [senvenView addSubview:alable];
            return senvenView;
        }
    }else
    {
        if(section == 0)
        {
            UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 68)];
            twoView.backgroundColor = [UIColor whiteColor];
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 8)];
            headView.backgroundColor = viewbackcolor;
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
            
            UIImageView *fishimagview = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 70, 14, 50, 50)];
            //            fishimagview.image = [UIImage imageNamed:@"icon_n_01@2x"];
            
            [twoView addSubview:fishimagview];
            [twoView addSubview:headView];
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
            UILabel *workTypeLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, W, 40)];
            workTypeLable.textColor = gycolor;
            workTypeLable.textAlignment = NSTextAlignmentLeft;
            workTypeLable.text = @"工作性质 : 入室维修";
            if (_isAnBao) {
                workTypeLable.text = @"工作性质 : 公众服务";

            }
            workTypeLable.font = [UIFont fontWithName:geshi size:15];
            
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, WIDTH - 10, 0.5)];
            lineLable.backgroundColor = gycoloers;
            UILabel *topLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, W, 20)];
            topLable.text = [NSString stringWithFormat:@"工单编号 : %@",_receiveDataDic[@"repair_no"]];
            topLable.font = [UIFont fontWithName:geshi size:15];
            topLable.textColor = gycolor;
            
            [threeView addSubview:lineLable];
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
            //            UILabel *naturelables = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, WIDTH - 160, 20)];
            //            naturelables.text = _receiveDataDic[@"post_time"];
            //            naturelables.textAlignment = NSTextAlignmentRight;
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
            //            [fouthView addSubview:naturelables];
            [fouthView addSubview:wagedetails];
            [fouthView addSubview:upline];
            [fouthView addSubview:buttomLine];
            return fouthView;
        }else if(section == 3)
        {
            UIButton *FiveView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [FiveView addTarget:self action:@selector(exeFiveViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            FiveView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"执行情况";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1, 15)];
            downLineLable.backgroundColor = gycoloers;
            UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, WIDTH - 170, 20)];
            rightLable.textColor = gycoloer;
            rightLable.font = [UIFont fontWithName:geshi  size:13];
            rightLable.textAlignment = NSTextAlignmentRight;
            rightLable.text = [_receiveDataDic objectForKey:@"repair_status"];
            FiveImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenTwo == YES) {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                FiveImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [FiveView addSubview:downLineLable];
            [FiveView addSubview:lineLable];
            [FiveView addSubview:imageView];
            [FiveView addSubview:FiveImageView];
            [FiveView addSubview:linelable];
            [FiveView addSubview:alable];
            [FiveView addSubview:rightLable];
            return FiveView;
        }else if (section == 4)
        {
            UIButton *sixView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [sixView addTarget:self action:@selector(OversixViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            sixView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"验收状态";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x40"];
            UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, WIDTH - 170, 20)];
            rightLable.textColor = gycoloer;
            rightLable.font = [UIFont fontWithName:geshi  size:13];
            rightLable.textAlignment = NSTextAlignmentRight;
            rightLable.text = @"已验收";
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH - 20, 0.5)];
            linelable.backgroundColor = gycoloers;
            UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 1, 15)];
            downLineLable.backgroundColor = gycoloers;
            sixImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenThree == YES) {
                sixImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                sixImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [sixView addSubview:downLineLable];
            [sixView addSubview:lineLable];
            [sixView addSubview:imageView];
            [sixView addSubview:sixImageView];
            [sixView addSubview:linelable];
            [sixView addSubview:alable];
            [sixView addSubview:rightLable];
            return sixView;
        }else if (section == 6)
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
            UIButton *senvenView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
            [senvenView addTarget:self action:@selector(OversenvenViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
            senvenView.backgroundColor = [UIColor whiteColor];
            UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 80, 20)];
            alable.text = @"物业反馈";
            alable.textColor = gycolor;
            alable.font = [UIFont fontWithName:geshi size:17];
            UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 15)];
            lineLable.backgroundColor = gycoloers;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 10, 10)];
            imageView.image = [UIImage imageNamed:@"mlgj-2x43"];
            UILabel *DownLineLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 39.5, WIDTH, 0.5)];
            DownLineLable.backgroundColor = gycoloers;
            senvenImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
            if (ISOpenFouth == YES) {
                senvenImageView.image = [UIImage imageNamed:@"sysicon_n_39@2x"];
            }else
            {
                senvenImageView.image = [UIImage imageNamed:@"sysicon_n_36@2x"];
            }
            [senvenView addSubview:DownLineLable];
            [senvenView addSubview:lineLable];
            [senvenView addSubview:imageView];
            [senvenView addSubview:senvenImageView];
            [senvenView addSubview:alable];
            return senvenView;
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
    }else{
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
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:3];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)OversixViewDidClicked
{
    if (ISOpenThree == YES) {
        ISOpenThree = NO;
    }else
    {
        ISOpenThree = YES;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:3];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:4];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)OversenvenViewDidClicked
{
    if (ISOpenFouth == YES) {
        ISOpenFouth = NO;
    }else
    {
        ISOpenFouth = YES;
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:4];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:5];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//返回cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int i;
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        i = 1;
    }else
    {
        i = 2;
    }
    
    if (indexPath.section == i) {
        GJOverChildTableViewCell *acell = [GJOverChildTableViewCell createCellWithTableView:tableView withIdentifier:@"Overchildflags"];
        acell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        linesLable = [[UILabel alloc]init];
        linesLable.backgroundColor = gycoloers;
        //问题描述
        UILabel *questLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, WIDTH - 40, 40)];
        questLable.textColor = gycoloer;
        questLable.font = [UIFont fontWithName:geshi size:13];
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
        CGFloat x = 30;
        CGFloat y = expectSize.height + 20;
        allDataImageArray = [NSMutableArray array];
        // 视频和图片
        if (videoDataArray.count != 0) {
            if (ShowImageDataArray.count != 0) {
                for (int i = 0; i < ShowImageDataArray.count; i++) {
                    [allDataImageArray addObject:ShowImageDataArray[i]];
                }
                [allDataImageArray insertObject:videoimageDataArray[0] atIndex:0];
                CGRect frame = CGRectMake(25, expectSize.height + 20, imageButtonW, imageButtonW);
                for (int i = 0 ; i < allDataImageArray.count; i ++)
                {
                    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(25, expectSize.height + 20, imageButtonW, imageButtonW)];
                    imageButton.backgroundColor = [UIColor redColor];
                    UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                    [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                    [imageButton addSubview:imageview];
                    
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
                    }else if(i == 8)
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
                    }
                    else
                    {
                        x = 25 + (i * imageButtonW + 5 * i);
                    }
                    frame.origin.x = x;
                    frame.origin.y = y;
                    [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                    imageButton.tag = i;
                    if (i == 0) {
                        x = 25;
                    }
                    imageButton.frame = CGRectMake(x, y, imageButtonW, imageButtonW);
                    [acell addSubview:imageButton];
                }
                if (voiceDataArray.count != 0) {
                    voiceButton.frame = CGRectMake(30, y + 2 * imageButtonW + 20, voiceLength, 28);
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
                [acell.contentView addSubview:imageButton];
                cellHeight = CGRectGetMaxY(imageButton.frame) + 10;
                if (voiceDataArray.count != 0) {
                    voiceButton.frame = CGRectMake(30,CGRectGetMaxY(imageButton.frame)+20, voiceLength ,28);
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
                CGRect frame = CGRectMake(30, y, imageButtonW, imageButtonW);
                UIButton *imageButton = [[UIButton alloc]initWithFrame:frame];
                UIImageView * imageview  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageButtonW, imageButtonW)];
                [imageButton addTarget:self action:@selector(showimageBig:) forControlEvents:UIControlEventTouchUpInside];
                [imageview sd_setImageWithURL:ShowImageDataArray[i] placeholderImage:[UIImage imageNamed:@"100x100"]];
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
        UILabel *alinelable = [[UILabel alloc]initWithFrame:CGRectMake(30, cellHeight + 5, WIDTH - 40, 0.5)];
        
        alinelable.backgroundColor = gycoloers;
        
        
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
    }else if(indexPath.section == i+1)
    {
        bcell = [GJOverChildTableViewTwoCell createCellWithTableView:tableView withIdentifier:@"overchildTwoflags"];
        bcell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *nameArray = [NSArray array];
        
        nameArray = @[@"维修师傅",@"联系电话",@"手续费",@"材料费",@"住户承担费用",@"网上支付费用",@"入户时间",@"出户时间"];
        if (_isAnBao) {
            nameArray = @[@"服务人",@"联系电话",@"手续费",@"材料费",@"住户承担费用",@"网上支付费用",@"服务开始时间",@"服务结束时间"];
        }
        
        NSArray *contentArray = [NSArray array];
        
        contentArray = @[_receiveDataDic[@"repaird"][@"repair_master_name"],_receiveDataDic[@"repaird"][@"repair_master_phone"],servicecharge,materialfee,ownercost,online_pay_cost,_receiveDataDic[@"repaird"][@"come_in_time"],_receiveDataDic[@"repaird"][@"come_out_time"]];
        for (int i = 0 ; i < nameArray.count; i++) {
            if (i == 1) {
                [self buttonWithCGRect:CGRectMake(10, i * 30, WIDTH - 10, 30) leftTitle:nameArray[i] RightTitle:contentArray[i] target:self action:@selector(phoneNumberButtonDidClicked)];
            }else
            {
                [self ViewWithCGRect:CGRectMake(10, i * 30, WIDTH - 10, 30) leftTitle:nameArray[i] RightTitle:contentArray[i]];
            }
        }
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 240)];
        lineLable.backgroundColor = gycoloers;
        [bcell addSubview:lineLable];
        return bcell;
    }else if (indexPath.section == i+2)
    {
        
        NSArray *namearray = [NSArray array];
        namearray = @[@"服务质量",@"满意度",@"其他建议"];
        NSArray *titleArray = [NSArray array];
        if (acceptanceArray.count == 0) {
            titleArray = @[@"无",@"无",@"无"];
        }else
        {
            titleArray = @[_receiveDataDic[@"acceptance"][@"service_quality"],_receiveDataDic[@"acceptance"][@"satisfied"],_receiveDataDic[@"acceptance"][@"contents"]];
        }
        CCell = [GJOverChildTableViewThreeCell createCellWithTableView:tableView withIdentifier:@"overchildThreeflags"];
        CCell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0; i < namearray.count; i ++) {
            [self CViewWithCGRect:CGRectMake(10, i * 30, WIDTH - 10, 30) leftTitle:namearray[i] RightTitle:titleArray[i]];
        }
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 1, 120)];
        lineLable.backgroundColor = gycoloers;
        [CCell addSubview:lineLable];
        return CCell;
    }else
    {
        GJOverTableViewFouthCell *fouthCell = [GJOverTableViewFouthCell createCellWithTableView:tableView withIdentifier:@"overFouthflags"];
        fouthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, (WIDTH - 30)/2, 30)];
        leftLable.textColor = gycoloer;
        leftLable.font = [UIFont fontWithName:geshi  size:13];
        leftLable.text = @"谢谢您的反馈!";
        UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 30)/2 + 10, 0, (WIDTH - 30)/2 - 20, 30)];
        rightLable.textColor = gycoloer;
        rightLable.font = [UIFont fontWithName:geshi size:13];
        if (acceptanceArray.count == 0) {
            rightLable.text = @"";
        }else
        {
            rightLable.text = _receiveDataDic[@"acceptance"][@"reply_time"];
        }
        rightLable.textAlignment = NSTextAlignmentRight;
        [fouthCell addSubview:leftLable];
        [fouthCell addSubview:rightLable];
        return fouthCell;
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
    
    UILabel *rightLabele = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 30)/2, 0, (WIDTH - 30)/2 - 10, 30)];
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

-(void)rightButtonDidClicked:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",sender.titleLabel.text]]];
    
}
-(UIView *)CViewWithCGRect:(CGRect)rect leftTitle:(NSString *)lefttitle RightTitle:(NSString *)righttitle
{
    UIView *aview = [[UIView alloc]initWithFrame:rect];
    aview.backgroundColor = [UIColor whiteColor];
    UILabel *leftLable = [[UILabel alloc]initWithFrame:CGRectMake(30,0 , (WIDTH - 30)/2, 30)];
    leftLable.textColor = gycoloer;
    leftLable.font = [UIFont fontWithName:geshi  size:13];
    leftLable.textAlignment = NSTextAlignmentLeft;
    leftLable.text = lefttitle;
    
    UILabel *rightLabele = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH - 30)/2 + 10, 0, (WIDTH - 30)/2 - 20, 30)];
    rightLabele.textColor = gycoloer;
    rightLabele.font = [UIFont fontWithName:geshi  size:13];
    rightLabele.textAlignment = NSTextAlignmentRight;
    rightLabele.text = righttitle;
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 29.5, WIDTH - 30, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [aview addSubview:lineLable];
    [aview addSubview:leftLable];
    [aview addSubview:rightLabele];
    [CCell addSubview:aview];
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
    acceptanceArray = [NSArray array];
    Datadict = _receiveDataDic[@"ivv_json"];
    NSArray *imageArray = [NSArray array];
    NSArray *videoArray = [NSArray array];
    NSArray *voiceArray = [NSArray array];
    imageArray = Datadict[@"images"];
    videoArray = Datadict[@"video"];
    voiceArray = Datadict[@"voice"];
    acceptanceArray = _receiveDataDic[@"acceptance"];
    servicecharge = [NSString stringWithFormat:@"%@元",_receiveDataDic[@"repaird"][@"service_charge"]];
    materialfee = [NSString stringWithFormat:@"%@元",_receiveDataDic[@"repaird"][@"material_fee"]];
    ownercost = [NSString stringWithFormat:@"%@元",_receiveDataDic[@"repaird"][@"owner_cost"]];
    online_pay_cost=[NSString stringWithFormat:@"%@元",_receiveDataDic[@"repaird"][@"online_pay_cost"]];
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
    if (self.CancelDelegates && [self.CancelDelegates respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.CancelDelegates PushVideoVCDidClicked:VideoUrl];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}


//播放音频
-(void)UNExePlayVoiceChildButtonDidClicked
{
    if (ISTIMERSTR == YES) {
        ISTIMERSTR = NO;
        if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
            [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }else{
            NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:3];
            [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
        
        
        //播放本地音乐
        //设置扩音播放
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        thetime = [[voiceTimeArray objectAtIndex:0] intValue];
        changeimagetime = thetime * 2;
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
    thetime -= 1;
    voicetimelables = [NSString stringWithFormat:@"%d",thetime];
    if (thetime == 0) {
        voicetimelables = nil;
        //结束定时器
        [timer invalidate];
        [self.audioPlayer stop];
        ISTIMERSTR = NO;
        [changeVoiceTimer invalidate];
        
    }
    if ([_receiveDataDic[@"is_op"] isEqualToString:@"P"]) {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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

@end

