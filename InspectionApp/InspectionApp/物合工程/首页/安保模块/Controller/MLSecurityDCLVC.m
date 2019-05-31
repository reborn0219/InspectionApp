//
//  MLSecurityDCLVC.m
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "MLSecurityDCLVC.h"
#import "GJQMViewController.h"

#import "GJLoginViewController.h"
#import "GJWageFirstTableViewCell.h"
#import "GJWageSecondTableViewCell.h"
#import "GJWageFouthTableViewCell.h"
#import "GJWageThirdTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "GJSDAdScrollView.h"
#import "GJCuiPickerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GJWageFirstImageTableViewCell.h"
#import "GJWageSecondImageTableViewCell.h"
#import "GJWagethirdImageTableViewCell.h"
#import "GJWageFouthImageTableViewCell.h"
#import "GJSingleTon.h"
#import "GJMViewController.h"
#import "FMDB.h"

#import "GJCommunityModel.h"

@interface MLSecurityDCLVC ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,UIAlertViewDelegate,UITextViewDelegate,UITextFieldDelegate,workNameIDDelegates,CuiPickViewDelegate,worknameIDDelegates>
{
    NSString *state;
    NSMutableArray *repairNumArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *parentclassArray;
    NSMutableArray *ivvjsonArray;
    NSMutableArray *repairtimeArray;
    NSMutableArray *repairdidArray;
    NSMutableArray *SQLRepairIDArray;
    NSMutableArray *servingTimeArray;
    NSString *voiceTimeStr;
    NSString *voicetimelables;
    NSString *voicetimes;
    NSString *VoiceUrl;
    NSURL *LocationVoiceUrl;
    NSString *VideoUrl;
    NSString *videoImageUrl;
    NSString *imagesUrl;
    UIButton *PlayVoiceButton;
    NSTimer *timer;
    float time;
    UILabel *voiceTimeLable;
    NSMutableArray *imageUrlArray;
    NSString *startNum;
    int pagenum;
    NSString *property_id;
    NSString *community_id;
    NSMutableArray *unexedataArray;
    NSMutableArray *unexeAllDataArray;
    UIImageView *placeimageView;
    UILabel *placelable;
    NSString *uploadUrl;
    UITextView *opinionView;
    UITextField *placeLables;
    int height;
    UIView *cancelView;
    UIView *apportionView;
    NSMutableArray *workNameArray;
    
    NSMutableArray *workIdarray;
    NSString *theworkID;
    UIButton *discoVerButton;
    NSMutableArray *ivvarrays;
    BOOL ISshang;
    UIImageView *VoiceImageView;
    int thetimes;
    int ImageChange;
    NSInteger VoiceButtonLength;
    BOOL ISTIMERSTR;
    NSTimer *VoiceImageTimer;
    NSTimer *VoiceChangeImageTimer;
    int buttonTage;
    UIImageView *leftVoiceImageView;
    UIImageView *rightVoiceImageView;
    UILabel *VoiceTimeLable;
    UIButton *VoicePlayButton;
    UIButton *backGroundButton;
    NSInteger OWNERTAG;
    NSDictionary *Locationdicts;
    NSInteger imageDataTag;
    UIWindow *window;
    NSMutableArray *WageID;
    NSMutableString *Mstr;
    
    
    UIButton *backButtonView;
    UIView *transferView;
    UILabel *worktimelable;
    NSInteger Srow;
    
}
@property(nonatomic,strong) GJFMDatabase *db;

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIScrollView *scrollview;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;

@property (nonatomic, strong)GJCuiPickerView *cuiPickerView;
@property(nonatomic,strong)UIButton *cuiPickerViewdiscoverButton;

@property(nonatomic,strong)UITableView *GRtableview;

@end

@implementation MLSecurityDCLVC
-(void)viewWillAppear:(BOOL)animated
{
    [self SQL];
    [self getMaintenancemaster];
    [self.tableview.mj_header beginRefreshing];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //结束定时器
    [VoiceImageTimer invalidate];
    [VoiceChangeImageTimer invalidate];
    [self.audioPlayer stop];
    [self.tableview reloadData];
    ISTIMERSTR = NO;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    Srow=0;
    
    window = [UIApplication sharedApplication].keyWindow;
    
    
    _cuiPickerView = [[GJCuiPickerView alloc]init];
    _cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    _cuiPickerView.backgroundColor = [UIColor whiteColor];
    _cuiPickerView.delegate = self;
    _cuiPickerView.curDate=[NSDate date];
    window = [UIApplication sharedApplication].keyWindow;
    _cuiPickerViewdiscoverButton = [[UIButton alloc]initWithFrame:window.frame];
    _cuiPickerViewdiscoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unExecutedfishWage) name:@"unExecutedfishWage" object:nil];
    
    //    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 153) style:UITableViewStylePlain];
    
    if (IS_iPhoneX) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, KScreenHeight- 88-34-40) style:UITableViewStylePlain];
        
    }else{
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64-40) style:UITableViewStylePlain];
        
    }
    
    
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    WageID = [NSMutableArray array];
    placeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableview.width/2 - 80, 80, 160, 160)];
    placeimageView.layer.cornerRadius = 80;
    placeimageView.layer.masksToBounds = YES;
    //placeimageView.layer.cornerRadius = placeimageView.size.width/2;
    placeimageView.backgroundColor = [UIColor clearColor];
    placeimageView.image = [UIImage imageNamed:@"100x100"];
    placelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, WIDTH, 30)];
    placelable.textColor = gycolor;
    placelable.text = @"暂无报修工单";
    if (_isAnBao) {
        placelable.text = @"暂无安保工单";
    }
    placelable.textAlignment = NSTextAlignmentCenter;
    descriptionArray = [NSMutableArray array];
    repairNumArray = [NSMutableArray array];
    repairtimeArray = [NSMutableArray array];
    parentclassArray = [NSMutableArray array];
    ivvjsonArray = [NSMutableArray array];
    unexeAllDataArray = [NSMutableArray array];
    servingTimeArray = [NSMutableArray array];
    repairdidArray = [NSMutableArray array];
    SQLRepairIDArray = [NSMutableArray array];
    startNum = @"0";
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.backgroundColor = viewbackcolor;
    startNum = @"0";
    pagenum = 0;
    
    //数据的路径，放在沙盒的cache下面
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"contact.db"];
    
    NSLog(@"%@",filePath);
    //创建并且打开一个数据库
    _db = [GJFMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_db open];
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
    //创建表
    BOOL create =  [_db executeUpdate:@"create table if not exists contact(number integer primary key autoincrement, name varchar(20),phone varchar(20))"];
    if (create) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    [self Notassigned];
    //下拉刷新 设置回调(一旦进入刷新状态,就回调 target的action,也就是回调self的reloadNewData方法)
    self.tableview.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (Locationdicts == nil) {
            startNum = @"0";
            pagenum = 0;
            ISshang = NO;
            [self Notassigned];
        }else
        {
            [self.tableview.mj_header endRefreshing];
        }
    }];
}
-(void)unExecutedfishWage
{
    
    [self.tableview.mj_header beginRefreshing];
}
// 自定义cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)backbuttonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_GRtableview==tableView) {
        return workNameArray.count;
    }
    
    return ivvjsonArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_GRtableview==tableView) {
        return 45;
    }
    return [GJWageFirstTableViewCell height];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_GRtableview==tableView) {
        return 0;
    }
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    //时间
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = ivvjsonArray[indexPath.row];
    NSArray *videoArray = [NSArray array];
    NSArray *imageArray = [NSArray array];
    NSArray *VoiceArray = [NSArray array];
    NSMutableArray *imageMutableArray = [NSMutableArray array];
    videoArray = dict[@"video"];
    imageArray = dict[@"images"];
    VoiceArray = dict[@"voice"];
    if (videoArray.count != 0){
        GJWageFouthTableViewCell *fouthTableVCell = [GJWageFouthTableViewCell createCellWithTableView:tableView withIdentifier:@"Fouthflags"];
        fouthTableVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    分派工单按钮
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"转移工单" forState:UIControlStateNormal];
        }else
        {
            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            
            [self.dispatchButton setTitle:@"处理工单" forState:UIControlStateNormal];
            //            }
        }
        //   标记无效按钮
        self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
        [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
        self.invalidButton.layer.cornerRadius = 5;
        self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
        [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
        self.invalidButton.tag = indexPath.row;
        [fouthTableVCell addSubview:self.dispatchButton];
        [fouthTableVCell addSubview:self.invalidButton];
        UIButton *videoButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 40, 40)];
        UIImageView *videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        videoButton.tag =indexPath.row + 1000;
        [videoButton addTarget:self action:@selector(videoButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        for (NSDictionary *dict in videoArray)
        {
            if (Locationdicts != nil)
            {
                if (indexPath.row == 0)
                {
                    [videoImageView setImage:dict[@"video_img_ico"]];
                } else
                {
                    NSString *videoimgStr = dict[@"video_img_ico"];
                    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                    videoImageUrl = [NSString stringWithFormat:@"%@%@",@"",videoimgStr];
                    [videoImageView sd_setImageWithURL:[NSURL URLWithString:videoImageUrl] placeholderImage:[UIImage imageNamed:@"100x100"]];
                }
                
            }   else
            {
                NSString *videoimgStr = dict[@"video_img_ico"];
                NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                videoImageUrl = [NSString stringWithFormat:@"%@%@",@"",videoimgStr];
                [videoImageView sd_setImageWithURL:[NSURL URLWithString:videoImageUrl] placeholderImage:[UIImage imageNamed:@"100x100"]];
            }
        }
        if (Locationdicts != nil) {
            if (indexPath.row == 0)
            {
                self.dispatchButton.backgroundColor = gycoloer;
                self.invalidButton.backgroundColor = gycoloer;
                self.dispatchButton.userInteractionEnabled = NO;
                self.invalidButton.userInteractionEnabled = NO;
            }else
            {
                self.dispatchButton.backgroundColor =NAVCOlOUR;
                [self.invalidButton setBackgroundColor:gycoloer];
                self.dispatchButton.userInteractionEnabled = YES;
                self.invalidButton.userInteractionEnabled = YES;
            }
            
        } else
        {
            self.dispatchButton.backgroundColor = NAVCOlOUR;
            [self.invalidButton setBackgroundColor:gycoloer];
            self.dispatchButton.userInteractionEnabled = YES;
            self.invalidButton.userInteractionEnabled = YES;
        }
        UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(videoButton.width/2 - 7, videoButton.width/2 - 7, 14, 14)];
        bofangimageView.backgroundColor = [UIColor clearColor];
        bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
        [videoImageView addSubview:bofangimageView];
        [videoButton addSubview:videoImageView];
        [fouthTableVCell addSubview:videoButton];
        fouthTableVCell.numberLable.text = repairNumArray[indexPath.row];
        fouthTableVCell.dataLable.text = repairtimeArray[indexPath.row];
        NSLog(@"SQLRepairIDArray_____%@",SQLRepairIDArray);
        
        GJFMResultSet *set = [_db executeQuery:@"select * from contact where name = ?",[NSString stringWithFormat:@"%@",SQLRepairIDArray[indexPath.row]]];
        while ([set next]) {
            NSString *phone = [set stringForColumn:@"phone"];
            if ([phone isEqualToString:@"0"]) {
                fouthTableVCell.RedLoadbutton.hidden = NO;
            }else
            {
                fouthTableVCell.RedLoadbutton.hidden = YES;
            }
        }
        return fouthTableVCell;
    }
    else if(VoiceArray.count != 0)
    {
        for (NSDictionary *dict in VoiceArray) {
            NSString *times = dict[@"voice_time"];
            VoiceButtonLength = [times integerValue];
            //            NSString *voiceurl = [userDefaults objectForKey:@"app_voice_url"];
            NSString *voiceStr = dict[@"voice"];
            VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceStr];
        }
        GJWageSecondTableViewCell *secondacell = [GJWageSecondTableViewCell createCellWithTableView:tableView withIdentifier:@"Secondflags"];
        
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.backgroundColor = NAVCOlOUR;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"转移工单" forState:UIControlStateNormal];
        }else
        {
            //            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            //            if ([danOne[@"allot_type"] isEqualToString:@"RND"]) {
            //                [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            //            }else{
            
            [self.dispatchButton setTitle:@"处理工单" forState:UIControlStateNormal];
            //            }
        }
        //   标记无效按钮
        self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
        [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
        self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        self.invalidButton.layer.cornerRadius = 5.0f;
        [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
        self.invalidButton.tag = indexPath.row;
        [self.invalidButton setBackgroundColor:gycoloer];
        [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
        
        
        
        
        
        if (Locationdicts != nil) {
            if (indexPath.row == 0)
            {
                self.dispatchButton.backgroundColor = gycoloer;
                self.invalidButton.backgroundColor = gycoloer;
                self.dispatchButton.userInteractionEnabled = NO;
                self.invalidButton.userInteractionEnabled = NO;
            }else
            {
                self.dispatchButton.backgroundColor = NAVCOlOUR;
                [self.invalidButton setBackgroundColor:gycoloer];
                self.dispatchButton.userInteractionEnabled = YES;
                self.invalidButton.userInteractionEnabled = YES;
            }
        }else
        {
            self.dispatchButton.backgroundColor = NAVCOlOUR;
            [self.invalidButton setBackgroundColor:gycoloer];
            self.dispatchButton.userInteractionEnabled = YES;
            self.invalidButton.userInteractionEnabled = YES;
            
        }
        
        [secondacell.contentView addSubview:self.dispatchButton];
        [secondacell.contentView addSubview:self.invalidButton];
        
        self.timeLable = [[UILabel alloc]init];
        self.timeLable.textColor = NAVCOlOUR;
        self.timeLable.font = [UIFont fontWithName:geshi size:15];
        [secondacell.contentView addSubview:self.timeLable];
        VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
        [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
        self.timeLable.text = [NSString stringWithFormat:@"%ld''",(long)VoiceButtonLength];
        int voiceLength = 0;
        if (VoiceButtonLength <= 10) {
            voiceLength = 80;
            self.timeLable.frame = CGRectMake(100, 45, 30, 22);
        }else if (VoiceButtonLength > 10 && VoiceButtonLength <= 20 )
        {
            voiceLength = 100;
            self.timeLable.frame = CGRectMake(120, 45, 30, 22);
            
        }else if (VoiceButtonLength > 20 && VoiceButtonLength <= 40)
        {
            voiceLength = 120;
            self.timeLable.frame = CGRectMake(140, 45, 30, 22);
            
        }else if (VoiceButtonLength > 40 && VoiceButtonLength <= 60)
        {
            voiceLength = 140;
            self.timeLable.frame = CGRectMake(160, 45, 30, 22);
        }
        UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 42, voiceLength, 28)];
        voiceButton.tag = indexPath.row + 2000;
        [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(UNExePlayVoiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [voiceButton addSubview:VoiceImageView];
        NSLog(@"SQLRepairIDArray_____%@",SQLRepairIDArray);
        GJFMResultSet *set = [_db executeQuery:@"select * from contact where name = ?",[NSString stringWithFormat:@"%@",SQLRepairIDArray[indexPath.row]]];
        while ([set next]) {
            NSString *phone = [set stringForColumn:@"phone"];
            if ([phone isEqualToString:@"0"]) {
                secondacell.RedWagebutton.hidden = NO;
            }else
            {
                secondacell.RedWagebutton.hidden = YES;
            }
        }
        [secondacell.contentView addSubview:voiceButton];
        secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondacell.numberLable.text = repairNumArray[indexPath.row];
        secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondacell.dataLable.text = repairtimeArray[indexPath.row];
        return secondacell;
    }
    else if(imageArray.count != 0)
    {
        GJWageThirdTableViewCell *thirdTableVCell = [GJWageThirdTableViewCell createCellWithTableView:tableView withIdentifier:@"Thirdflags"];
        //    分派工单按钮
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.backgroundColor =NAVCOlOUR;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"转移工单" forState:UIControlStateNormal];
        }else
        {
            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            //            if ([danOne[@"allot_type"] isEqualToString:@"RND"]) {
            //                [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            //            }else{
            
            [self.dispatchButton setTitle:@"处理工单" forState:UIControlStateNormal];
            //            }
            
        }
        //   标记无效按钮
        self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
        [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
        self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        self.invalidButton.layer.cornerRadius = 5.0f;
        
        [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
        self.invalidButton.tag = indexPath.row;
        [self.invalidButton setBackgroundColor:gycoloer];
        [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
        if (Locationdicts != nil) {
            if (indexPath.row == 0)
            {
                self.dispatchButton.backgroundColor = gycoloer;
                self.invalidButton.backgroundColor = gycoloer;
                self.dispatchButton.userInteractionEnabled = NO;
                self.invalidButton.userInteractionEnabled = NO;
            }else
            {
                self.dispatchButton.backgroundColor =NAVCOlOUR;
                [self.invalidButton setBackgroundColor:gycoloer];
                self.dispatchButton.userInteractionEnabled = YES;
                self.invalidButton.userInteractionEnabled = YES;
            }
        }else
        {
            self.dispatchButton.backgroundColor = NAVCOlOUR;
            [self.invalidButton setBackgroundColor:gycoloer];
            self.dispatchButton.userInteractionEnabled = YES;
            self.invalidButton.userInteractionEnabled = YES;
            
        }
        if (Locationdicts != nil)
        {
            if (indexPath.row == 0) {
                for (int i = 0;i < imageArray.count;i++)
                {
                    [imageMutableArray addObject:imageArray[i]];
                }
            }else
            {
                for (NSDictionary *dict in imageArray)
                {
                    NSString *str;
                    str = dict[@"images_ico"];
                    [imageMutableArray addObject:str];
                }
            }
        }else
        {
            for (NSDictionary *dict in imageArray)
            {
                NSString *str;
                str = dict[@"images_ico"];
                [imageMutableArray addObject:str];
            }
        }
        
        [thirdTableVCell addSubview:self.dispatchButton];
        [thirdTableVCell addSubview:self.invalidButton];
        if (imageMutableArray.count > 5) {
            for (int i = 0; i < 5; i ++) {
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 50*i, 35, 40, 40)];
                imagebutton.tag = i + 4000;
                imagebutton.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row +1000];
                imagebutton.titleLabel.textColor = [UIColor clearColor];
                [imagebutton addTarget:self action:@selector(imagebuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                imagesUrl = [NSString stringWithFormat:@"%@%@",@"",imageMutableArray[i]];
                self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                if (Locationdicts != nil) {
                    if (indexPath.row == 0) {
                        [self.showImageView setImage:imageMutableArray[i]];
                    }else
                    {
                        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                    }
                    
                }  else
                {
                    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                }
                [imagebutton addSubview:self.showImageView];
                UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(270, 40, 30, 20)];
                alable.text = @"...";
                alable.textColor = gycoloer;
                alable.font = [UIFont fontWithName:geshi size:20];
                [thirdTableVCell.contentView addSubview:alable];
                [thirdTableVCell.contentView addSubview:imagebutton];
            }
        }else
        {
            for (int i = 0; i < imageMutableArray.count; i ++) {
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 50*i, 35, 40, 40)];
                imagebutton.tag = i + 4000;
                imagebutton.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row +1000];
                imagebutton.titleLabel.textColor = [UIColor clearColor];
                [imagebutton addTarget:self action:@selector(imagebuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                if (Locationdicts != nil) {
                    if (indexPath.row == 0) {
                        [self.showImageView setImage:imageMutableArray[i]];
                    }else
                    {
                        NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                        imagesUrl = [NSString stringWithFormat:@"%@%@",@"",imageMutableArray[i]];
                        self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                    }
                }else
                {
                    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                    imagesUrl = [NSString stringWithFormat:@"%@%@",@"",imageMutableArray[i]];
                    self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                }
                [imagebutton addSubview:self.showImageView];
                [thirdTableVCell.contentView addSubview:imagebutton];
            }
        }
        NSLog(@"SQLRepairIDArray_____%@",SQLRepairIDArray);
        
        GJFMResultSet *set = [_db executeQuery:@"select * from contact where name = ?",[NSString stringWithFormat:@"%@",SQLRepairIDArray[indexPath.row]]];
        while ([set next]) {
            NSString *phone = [set stringForColumn:@"phone"];
            if ([phone isEqualToString:@"0"]) {
                thirdTableVCell.RedWagebutton.hidden = NO;
            }else
            {
                thirdTableVCell.RedWagebutton.hidden = YES;
            }
        }
        
        thirdTableVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        thirdTableVCell.numberLable.text = repairNumArray[indexPath.row];
        thirdTableVCell.dataLable.text = repairtimeArray[indexPath.row];
        return thirdTableVCell;
    }else{
        GJWageFirstTableViewCell *firstcell = [GJWageFirstTableViewCell createCellWithTableView:tableView withIdentifier:@"FirstFlags"];
        //    分派工单按钮
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.backgroundColor = NAVCOlOUR;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"转移工单" forState:UIControlStateNormal];
        }else
        {
            
            
            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            
            //            if ([danOne[@"allot_type"] isEqualToString:@"RND"]) {
            //                [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            //            }else{
            
            [self.dispatchButton setTitle:@"处理工单" forState:UIControlStateNormal];
            //            }
        }
        //   标记无效按钮
        self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
        [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
        self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        self.invalidButton.layer.cornerRadius = 5.0f;
        [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
        [self.invalidButton setBackgroundColor:gycoloer];
        [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
        self.invalidButton.tag = indexPath.row;
        if (Locationdicts != nil) {
            if (indexPath.row == 0)
            {
                self.dispatchButton.backgroundColor = gycoloer;
                self.invalidButton.backgroundColor = gycoloer;
                self.dispatchButton.userInteractionEnabled = NO;
                self.invalidButton.userInteractionEnabled = NO;
                
            }else
            {
                self.dispatchButton.backgroundColor = NAVCOlOUR;
                [self.invalidButton setBackgroundColor:gycoloer];
                self.dispatchButton.userInteractionEnabled = YES;
                self.invalidButton.userInteractionEnabled = YES;
            }
        }else
        {
            self.dispatchButton.backgroundColor =NAVCOlOUR;
            [self.invalidButton setBackgroundColor:gycoloer];
            self.dispatchButton.userInteractionEnabled = YES;
            self.invalidButton.userInteractionEnabled = YES;
            
        }
        
        NSLog(@"SQLRepairIDArray_____%@",SQLRepairIDArray);
        
        GJFMResultSet *set = [_db executeQuery:@"select * from contact where name = ?",[NSString stringWithFormat:@"%@",SQLRepairIDArray[indexPath.row]]];
        while ([set next]) {
            NSString *phone = [set stringForColumn:@"phone"];
            if ([phone isEqualToString:@"0"]) {
                firstcell.redLoadbutton.hidden = NO;
            }else
            {
                firstcell.redLoadbutton.hidden = YES;
            }
        }
        [firstcell addSubview:self.dispatchButton];
        [firstcell addSubview:self.invalidButton];
        firstcell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstcell.WageTyperLable.text =  [NSString stringWithFormat:@"%@%@",parentclassArray[indexPath.row],@" :"];
        if (_isAnBao) {
            firstcell.WageTyperLable.text = @"公众服务 :";
        }
        firstcell.numberLable.text = repairNumArray[indexPath.row];
        firstcell.dataLable.text = repairtimeArray[indexPath.row];
        firstcell.bodytextLable.text = descriptionArray[indexPath.row];
        return firstcell;
    }
}

//取消headView粘性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
#pragma mark cell 的点击事件
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
    }else{
        NSString *location;
        if ([repairNumArray[indexPath.row] isEqualToString:@"正在上传..."]) {
            location = @"YES";
        }else
        {
            location = @"NO";
        }
        if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(UnexeCellDidClicked:Islocation:)]) {
            [self.Unexedelegate UnexeCellDidClicked:unexeAllDataArray[indexPath.row] Islocation:location];
        }
        else
        {
            NSLog(@"协议方案未实现");
        }
    }
}

-(void)Notassigned
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
    property_id = model.property_id;
    community_id = model.community_id;
    NSString *role = [userDefaults objectForKey:@"role"];
    if (ISshang == YES) {
        NSLog(@"shang");
    }else
    {
        if ([userDefaults objectForKey:@"AdminWageexedataArray"] != nil) {
            [self removeData];
            [placeimageView removeFromSuperview];
            [placelable removeFromSuperview];
            if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                unexedataArray = [userDefaults objectForKey:@"AdminWageunexedataArray"];
            }else
            {
                unexedataArray = [userDefaults objectForKey:@"NormalWageunexedataArray"];
            }
            for (NSDictionary *dict in unexedataArray) {
                NSString *TherepairID = [NSString stringWithFormat:@"%@",dict[@"repair_id"]];
                NSString *SQLrepairdID = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",mobile_phone,property_id,community_id,role,TherepairID];
                [SQLRepairIDArray addObject:SQLrepairdID];
                if (dict[@"description"]) {
                    [descriptionArray addObject:dict[@"description"]];
                }
                if (dict[@"ivv_json"]) {
                    [ivvjsonArray addObject:dict[@"ivv_json"]];
                }
                [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                [parentclassArray addObject:dict[@"parent_class"]];
                [repairtimeArray addObject:dict[@"repair_time"]];
                [repairdidArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_id"]]];
                [servingTimeArray addObject:dict[@"serving_time"]];
            }
            for (int i = 0; i < unexedataArray.count; i++) {
                [unexeAllDataArray addObject:unexedataArray[i]];
            }
            [self.tableview reloadData];
        }
    }
    
    
    if (community_id == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请返回首页选择小区"];
        [self.tableview.mj_header endRefreshing];
    }else{
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
         [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"security_list" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"repair_status",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"待处理",startNum,@"10"] andBlock:^(id dictionary)
         {
             NSLog(@"%@",dictionary);
             NSArray * arr = [dictionary objectForKey:@"return_data"];
             
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.Unexedelegate PushLoginVCDidClicked];
                     }
                     else
                     {
                         NSLog(@"协议方案未实现");
                     }
                 });
             }else if ([state isEqualToString:@"3"]){
                 NSString *info = dictionary[@"upgrade_info"][@"info"];
                 uploadUrl = dictionary[@"upgrade_info"][@"url"];
                 self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                 self.shengjialert.delegate = self;
                 self.shengjialert.tag = 11;
                 [self.shengjialert show];
             }
             else if ([state isEqualToString:@"0"] && [startNum isEqualToString:@"0"])
             {
                 [self removeData];
                 [self SQL];
                 
                 [self.tableview addSubview:placelable];
                 [self.tableview addSubview:placeimageView];
             }else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
             }
             else if([state isEqualToString:@"1"])
             {
                 if (ISshang == NO) {
                     [self removeData];
                 }
                 [placeimageView removeFromSuperview];
                 [placelable removeFromSuperview];
                 unexedataArray = [NSMutableArray array];
                 unexedataArray = dictionary[@"return_data"][@"repair_data"];
                 for (NSDictionary *dict in unexedataArray) {
                     [descriptionArray addObject:dict[@"description"]];
                     [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                     [parentclassArray addObject:dict[@"parent_class"]];
                     [ivvjsonArray addObject:dict[@"ivv_json"]];
                     [repairtimeArray addObject:dict[@"repair_time"]];
                     [repairdidArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_id"]]];
                     [servingTimeArray addObject:dict[@"serving_time"]];
                 }
                 [userDefaults setObject:ivvjsonArray forKey:@"TheivvjsonArray"];
                 [userDefaults setObject:unexedataArray[0] forKey:@"unexedataArray0Data"];
                 [discoVerButton removeFromSuperview];
                 for (int i = 0; i < unexedataArray.count; i++) {
                     [unexeAllDataArray addObject:unexedataArray[i]];
                 }
                 [SQLRepairIDArray removeAllObjects];
                 for (NSDictionary *dict in unexeAllDataArray) {
                     NSString *TherepairID = [NSString stringWithFormat:@"%@",dict[@"repair_id"]];
                     NSString *SQLrepairdID = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",mobile_phone,property_id,community_id,role,TherepairID];
                     [SQLRepairIDArray addObject:SQLrepairdID];
                     GJFMResultSet *sets = [_db executeQuery:@"select * from contact where name = ?",SQLrepairdID];
                     if([sets next]) {
                         //                         NSString *name =  [sets stringForColumn:@"name"];
                         //                         NSString *phone = [sets stringForColumn:@"phone"];
                         //                         NSLog(@"name : %@ phone: %@",name,phone);
                     }else
                     {
                         BOOL insert = [_db executeUpdate:@"insert into contact (name,phone) values(?,?)",SQLrepairdID,@"0"];
                         if (insert) {
                             NSLog(@"插入数据成功");
                         }else{
                             NSLog(@"插入数据失败");
                         }
                     }
                 }
                 NSLog(@"SQLRepairIDArray___%@",SQLRepairIDArray);
                 [self SQL];
                 // 上划加载
                 self.tableview.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                     [self loadMoreData];
                 }];
                 if ([startNum isEqualToString:@"0"]) {
                     if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                         [userDefaults setObject:unexeAllDataArray forKey:@"AdminWageunexedataArray"];
                     }else
                     {
                         [userDefaults setObject:unexeAllDataArray forKey:@"NormalWageunexedataArray"];
                     }
                     
                 }
                 [userDefaults synchronize];
                 NSLog(@"%@",[userDefaults objectForKey:@"AdminWageunexedataArray"]);
             }
             [self.tableview.mj_header endRefreshing];
             [self.tableview.mj_footer endRefreshing];
             [self.tableview reloadData];
         }];
    }
}

-(void)SQL
{
    NSString *sqlstr;
    [WageID removeAllObjects];
    for (int i = 0; i < SQLRepairIDArray.count; i ++) {
        sqlstr = SQLRepairIDArray[i];
        GJFMResultSet *set = [_db executeQuery:@"select * from contact"];
        while ([set next]) {
            NSString *name = [set stringForColumn:@"name"];
            NSString *phone = [set stringForColumn:@"phone"];
            if ([name isEqualToString:sqlstr]) {
                [WageID addObject:phone];
            }
        }
    }
    NSLog(@"WageID___%@",WageID);
    Mstr = [[NSMutableString alloc] init];
    for (int i = 0; i < WageID.count; i ++) {
        [Mstr appendFormat:@"%@",WageID[i]];
    }
    NSLog(@"Mstr****%@",Mstr);
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:Mstr forKey:@"ThewageRedMstr"];
    [userdefaults synchronize];
    if ([Mstr rangeOfString:@"0"].location == NSNotFound) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HiddenRedWage" object:nil];
    }else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"displayRedWage" object:nil];
    }
}



-(void)removeData
{
    [ivvjsonArray removeAllObjects];
    [servingTimeArray removeAllObjects];
    [parentclassArray removeAllObjects];
    [descriptionArray removeAllObjects];
    [repairNumArray removeAllObjects];
    [repairtimeArray removeAllObjects];
    [repairdidArray removeAllObjects];
    [unexeAllDataArray removeAllObjects];
}

//弹窗
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 12)
    {
        if (buttonIndex == 0) {
            [alertView removeFromSuperview];
        }else
        {
            NSString *repairID = repairdidArray[OWNERTAG];
            
#pragma mark - QQQ判断要不要签名
            NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
            NSString *qM=[NSString stringWithFormat:@"%@",[def objectForKey:@"isAnbao_autograph"]];
            if ([qM isEqualToString:@"F"]) {
                
                if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(QianMing:)]) {
                    [self.Unexedelegate QianMing:repairID];
                }
                else
                {
                    NSLog(@"协议方案未实现");
                }
            }else{
                
                
                
                [self receiveWage];
            }
        }
        
    }else//升级
    {
        if (buttonIndex == 0) {
            [alertView removeFromSuperview];
        }else
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:uploadUrl]];
        }
    }
}


//播放视频
-(void)videoButtonDidClicked:(UIButton *)bt
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ivvjsonArray objectAtIndex:(bt.tag - 1000)];
    NSArray *videoArray = [NSArray array];
    videoArray = dict[@"video"];
    for (NSDictionary *dict in videoArray) {
        NSString *playVideoStr = dict[@"video"];
        NSString *videoStr = [userDefaults objectForKey:@"app_video_url"];
        if (Locationdicts != nil) {
            if (bt.tag == 1000) {
                VideoUrl = [dict[@"video"] absoluteString];
            }else
            {
                VideoUrl = [NSString stringWithFormat:@"%@%@",@"",playVideoStr];
            }
        }else
        {
            VideoUrl = [NSString stringWithFormat:@"%@%@",@"",playVideoStr];
        }
    }
    
    if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.Unexedelegate PushVideoVCDidClicked:VideoUrl];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
//播放音频
-(void)UNExePlayVoiceButtonDidClicked:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ivvjsonArray objectAtIndex:(sender.tag - 2000)];
    [userDefaults setObject:@"buttonTage" forKey:@"buttonTage"];
    NSArray *voiceArray = [NSArray array];
    voiceArray = dict[@"voice"];
    for (NSDictionary *dict in voiceArray) {
        NSString *playVoiceStr = dict[@"voice"];
        NSString *voicestr = [userDefaults objectForKey:@"app_voice_url"];
        if (Locationdicts != nil) {
            if (sender.tag == 2000) {
                LocationVoiceUrl = dict[@"voice"];
            }else{
                VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",playVoiceStr];
            }
        }else{
            VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",playVoiceStr];
        }
        voiceTimeStr = dict[@"voice_time"];
    }
    buttonTage = sender.tag - 2000;
    window = [UIApplication sharedApplication].keyWindow;
    backGroundButton = [[UIButton alloc]initWithFrame:window.frame];
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [backGroundButton addTarget:self action:@selector(backGroundButtonDisMiss) forControlEvents:UIControlEventTouchUpInside];
    UIView *VoiceView = [[UIView alloc]initWithFrame:CGRectMake(0, window.frame.size.height - 200, WIDTH, 200)];
    VoiceView.backgroundColor = [UIColor whiteColor];
    leftVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 100, 20, 80, 30)];
    rightVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 + 20, 20, 80, 30)];
    VoiceTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 - 20, 20, 40, 30)];
    VoiceTimeLable.backgroundColor = [UIColor clearColor];
    VoiceTimeLable.textAlignment = NSTextAlignmentCenter;
    VoiceTimeLable.textColor = gycolor;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%@s",voiceTimeStr];
    PlayVoiceButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2 - 50, 60, 100, 100)];
    [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
    PlayVoiceButton.tag = sender.tag;
    [PlayVoiceButton addTarget:self action:@selector(voicesPlayDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [VoiceView addSubview:leftVoiceImageView];
    [VoiceView addSubview:rightVoiceImageView];
    [VoiceView addSubview:VoiceTimeLable];
    [VoiceView addSubview:PlayVoiceButton];
    [backGroundButton addSubview:VoiceView];
    [window addSubview:backGroundButton];
    [self voicesPlayDidClicked];
}
-(void)voicesPlayDidClicked
{
    if (ISTIMERSTR == YES) {
        ISTIMERSTR = NO;
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_n_103@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_n_103@2x"]];
        VoiceTimeLable.text = [NSString stringWithFormat:@"%@s",voiceTimeStr];
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x86"] forState:UIControlStateNormal];
        //结束定时器
        [VoiceImageTimer invalidate];
        [VoiceChangeImageTimer invalidate];
        //        [[PlayerManager sharedManager] stopPlaying];
        [self.audioPlayer stop];
    }else
    {
        ISTIMERSTR = YES;
        thetimes = [voiceTimeStr intValue];
        ImageChange = ([voiceTimeStr intValue]) * 2;
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
        //设置扩音播放
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *filePath = [NSString stringWithFormat:@"/%@.mp3",[formater stringFromDate:[NSDate date]]];
        if (Locationdicts != nil) {
            if (buttonTage == 0) {
                [self.audioPlayer playURL:LocationVoiceUrl];
                //启动定时器
                VoiceImageTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(unexechangeVoiceImage:) userInfo:nil repeats:YES];
                VoiceChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(unexechangeimageVoiceImage:) userInfo:nil repeats:YES];
            }else
            {
                [self downloadFileURL:VoiceUrl savePath:docDirPath fileName:filePath];
            }
        }else
        {
            [self downloadFileURL:VoiceUrl savePath:docDirPath fileName:filePath];
        }
        
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
            [GJSVProgressHUD showErrorWithStatus:@"网络故障,请检查您的网络!"];
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
    VoiceImageTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(unexechangeVoiceImage:) userInfo:nil repeats:YES];
    VoiceChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(unexechangeimageVoiceImage:) userInfo:nil repeats:YES];
}
-(void)backGroundButtonDisMiss
{
    ISTIMERSTR = NO;
    [VoiceImageTimer invalidate];
    [VoiceChangeImageTimer invalidate];
    [self.audioPlayer stop];
    [backGroundButton removeFromSuperview];
}
-(void)unexechangeVoiceImage:(NSTimer *)time
{
    ISTIMERSTR = YES;
    thetimes -= 0.5;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%ds ",thetimes];
    if (thetimes == 0) {
        [self backGroundButtonDisMiss];
    }
}
-(void)unexechangeimageVoiceImage:(NSTimer *)time
{
    ImageChange -= 0.5;
    if (ImageChange%2 == 0) {
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_a_102@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_a_102@2x"]];
    }else
    {
        [leftVoiceImageView setImage:[UIImage imageNamed:@"icon_a_103@2x"]];
        [rightVoiceImageView setImage:[UIImage imageNamed:@"icon_a_103@2x"]];
    }
    if (thetimes == 0) {
        //结束定时器
        [VoiceChangeImageTimer invalidate];
        VoiceChangeImageTimer = nil;
    }
}
//图片点击事件
-(void)imagebuttonDidClicked:(UIButton *)sender
{
    int indexP =[sender.titleLabel.text integerValue] -1000;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
    NSDictionary *dict = [ivvjsonArray objectAtIndex:indexP];
    NSArray *imagearray = [NSArray array];
    NSMutableArray *imagemutableArray = [NSMutableArray array];
    imagearray = dict[@"images"];
    if (Locationdicts != nil) {
        if (imageDataTag == 1000)
        {
            for (int i = 0; i < imagearray.count; i++) {
                [imagemutableArray addObject:[GJMHPhotoModel photoWithImage:imagearray[i]]];
            }
        }
        else
        {
            for (NSDictionary *dict in imagearray) {
                NSString *imageStr = dict[@"images"];
                NSString *imageURL = [NSString stringWithFormat:@"%@%@",@"",imageStr];
                [imagemutableArray addObject:[GJMHPhotoModel photoWithURL:[NSURL URLWithString:imageURL]]];
            }
        }
        
    }
    else
    {
        for (NSDictionary *dict in imagearray) {
            NSString *imageStr = dict[@"images"];
            NSString *imageURL = [NSString stringWithFormat:@"%@%@",@"",imageStr];
            [imagemutableArray addObject:[GJMHPhotoModel photoWithURL:[NSURL URLWithString:imageURL]]];
        }
    }
    if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(pushImagebrowserDidClicked: imageTag:)]) {
        [self.Unexedelegate pushImagebrowserDidClicked:imagemutableArray imageTag:sender.tag - 4000];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}

//上拉刷新
-(void)loadMoreData
{
    ISshang = YES;
    pagenum += 10;
    startNum = [NSString stringWithFormat:@"%d",pagenum];
    [self Notassigned];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [timer invalidate];
    time = 0;
}


-(void)OnebuttonDdiClicked:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    OWNERTAG = sender.tag;
    if ([[userdefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
        
        //        转移工单
        [self wageTypeDidClicked];
        
        //分配工单
    }else
    {
        UIAlertView *receiveWage = [[UIAlertView alloc] initWithTitle:nil message:@"确定现在处理工单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        receiveWage.tag = 12;
        [receiveWage show];
    }
}
-(void)wageTypeDidClicked
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
        [GJSVProgressHUD showErrorWithStatus:@"请选择安保人员！"];
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
        
        NSString *repairID = repairdidArray[OWNERTAG];
        
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"repair_transfer" andBodyOfRequestForKeyArr:@[@"repair_id",@"repair_user_id",@"remarks"] andValueArr:@[repairID,theworkID,opinionView.text] andBlock:^(id dictionary)
         
         {
             NSLog(@"%@-%@-%@-%@",property_ids,repairID,theworkID,opinionView.text);
             NSLog(@"%@",dictionary);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.Unexedelegate PushLoginVCDidClicked];
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
                 [self.tableview.mj_header beginRefreshing];
                 Srow=0;
                 
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
    Srow=0;
    
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
/*-(void)getoWNER
 {
 self.coverButton = [[UIButton alloc]init];
 self.coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
 [self.coverButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
 window = [UIApplication sharedApplication].keyWindow;
 self.coverButton.frame = window.bounds;
 apportionView = [[UIView alloc]initWithFrame:CGRectMake(W/2 - 140, 150, 280, 240)];
 apportionView.layer.masksToBounds = YES;
 //设置元角度
 apportionView.layer.cornerRadius = 6.0;
 //设置边线
 apportionView.backgroundColor = viewbackcolor;
 UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, apportionView.size.width, 25)];
 titleLable.text = @"分派工单";
 titleLable.font = [UIFont fontWithName:geshi size:18];
 titleLable.textAlignment = NSTextAlignmentCenter;
 
 UIButton *dismisButton = [[UIButton alloc]initWithFrame:CGRectMake(apportionView.size.width - 35, 10, 25, 25)];
 [dismisButton setBackgroundImage:[UIImage imageNamed:@"dialog_back"] forState:UIControlStateNormal];
 [dismisButton addTarget:self action:@selector(Closebutton) forControlEvents:UIControlEventTouchUpInside];
 [apportionView addSubview:dismisButton];
 GJFZPWorkMenuView *menuView = [[GJFZPWorkMenuView alloc]initWithFrame:CGRectMake(20, 50, apportionView.size.width - 40, 40)];
 menuView.worknameDelegates = self;
 menuView.backgroundColor = [UIColor whiteColor];
 menuView.tableArray = workNameArray;
 [apportionView addSubview:menuView];
 
 opinionView = [[UITextView alloc]initWithFrame:CGRectMake(20, 95,apportionView.size.width - 40, 70)];
 opinionView.backgroundColor = [UIColor whiteColor];
 opinionView.font = [UIFont fontWithName:geshi size:15];
 opinionView.delegate = self;
 [opinionView.layer setBorderColor:gycoloers.CGColor];
 [opinionView.layer setBorderWidth:1.0];
 [opinionView.layer setCornerRadius:4.0];
 [opinionView.layer setMasksToBounds:YES];
 [opinionView setClipsToBounds:YES];
 placeLables = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
 placeLables.enabled = NO;
 placeLables.delegate = self;
 placeLables.text = @"备注";
 placeLables.font =  [UIFont systemFontOfSize:15];
 placeLables.textColor = gycoloer;
 [opinionView addSubview:placeLables];
 
 _fenpeiyesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, apportionView.width - 40, 40)];
 [_fenpeiyesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
 [_fenpeiyesButton setTitle:@"确定" forState:UIControlStateNormal];
 _fenpeiyesButton.tag = OWNERTAG;
 [_fenpeiyesButton addTarget: self action:@selector(YESButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
 [apportionView addSubview:opinionView];
 [apportionView addSubview:titleLable];
 [apportionView addSubview:_fenpeiyesButton];
 [self.coverButton addSubview:apportionView];
 [window addSubview:self.coverButton];
 }*/
-(void)OnebuttonDdiClickeds:(UIButton *)sender
{
    window = [UIApplication sharedApplication].keyWindow;
    self.coverButton = [[UIButton alloc]initWithFrame:window.frame];;
    self.coverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    [window addSubview:self.coverButton];
    cancelView = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(window.frame)/2 - 200, WIDTH - 40,320 )];
    cancelView.backgroundColor = [UIColor whiteColor];
    cancelView.layer.cornerRadius = 8.0;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 5,WIDTH - 140, 49)];
    titleLable.backgroundColor = [UIColor whiteColor];
    titleLable.textColor = gycolor;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:geshi size:22];
    titleLable.text = @"标记无效";
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, WIDTH - 40, 1)];
    lineLable.backgroundColor =NAVCOlOUR;
    UIButton *CloseButton = [[UIButton alloc]initWithFrame:CGRectMake(10,20 , 20, 20)];
    CloseButton.backgroundColor = [UIColor clearColor];
    [CloseButton setBackgroundImage:[UIImage imageNamed:@"icon_n_20x@2x"] forState:UIControlStateNormal];
    [CloseButton addTarget:self action:@selector(closecancelViewDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:CloseButton];
    
    
    
    opinionView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, WIDTH - 40, 180)];
    opinionView.backgroundColor = buttonHighcolor;
    opinionView.font = [UIFont fontWithName:geshi size:17];
    opinionView.delegate = self;
    placeLables = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, WIDTH - 40, 40)];
    placeLables.backgroundColor = [UIColor clearColor];
    placeLables.text = @"请输入取消原因";
    placelable.textColor = gycoloers;
    placeLables.textAlignment = NSTextAlignmentLeft;
    placeLables.enabled = NO;
    [opinionView addSubview:placeLables];
    
    
    UIButton *CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 260, WIDTH - 80, 40)];
    CancelButton.layer.cornerRadius = 8.0;
    [CancelButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [CancelButton setTitle:@"确定" forState:UIControlStateNormal];
    [CancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancelButton addTarget:self action:@selector(YESCaleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:titleLable];
    [cancelView addSubview:lineLable];
    [cancelView addSubview:opinionView];
    [cancelView addSubview:CancelButton];
    [self.coverButton addSubview:cancelView];
    [window addSubview:self.coverButton];
    
}
#pragma mark- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [placeLables setHidden:NO];
    }else{
        [placeLables setHidden:YES];
    }
}
-(void)Closebutton
{
    [_coverButton removeFromSuperview];
}
//分派确定
/*
 -(void)YESButtonDidClicked:(UIButton *)sender
 {
 
 NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
 GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
 
 if ([model.property_id isEqualToString:@""]) {
 //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
 //return;
 }
 
 
 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 NSString *mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
 NSString *property_ids = model.property_id;
 NSString *community_ids = model.community_id;
 NSString *role = [userDefaults objectForKey:@"role"];
 NSString *repairID = repairdidArray[sender.tag];
 NSString *servingtime = servingTimeArray[sender.tag];
 GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
 if (theworkID == nil) {
 [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
 }
 else
 {
 [GJSVProgressHUD showWithStatus:@"分派中"];
 [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[appointed_time]",@"rep[remarks]"] andValueArr:@[property_ids,repairID,theworkID,servingtime,opinionView.text] andBlock:^(id dictionary)
 {
 state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
 if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
 [self.Unexedelegate PushLoginVCDidClicked];
 }
 else
 {
 NSLog(@"协议方案未实现");
 }
 });
 }
 else if([state isEqualToString:@"0"])
 {
 [GJSVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",dictionary[@"return_data"]]];
 }else if ([state isEqualToString:@"-1"])
 {
 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
 }else if ([state isEqualToString:@"1"])
 {
 NSString *SQLrepairdID = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",mobile_phone,property_ids,community_ids,role,repairID];
 BOOL update = [_db executeUpdate:@"update contact set phone = ? where name = ?",@"1",SQLrepairdID];
 if (update) {
 NSLog(@"更新数据成功");
 }else{
 NSLog(@"更新数据失败");
 }
 [GJSVProgressHUD dismiss];
 [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
 [self.tableview.mj_header beginRefreshing];
 }
 }];
 [_coverButton removeFromSuperview];
 }
 }
 */
//无效确定
-(void)YESCaleButtonDidClicked:(UIButton *)sender
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
    NSString *property_ids = model.property_id;
    NSString *community_ids = model.community_id;
    NSString *role = [userDefaults objectForKey:@"role"];
    [GJSVProgressHUD showWithStatus:@"标记中"];
    NSString *repairID = repairdidArray[sender.tag];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"edit_invalid" andBodyOfRequestForKeyArr:@[@"repair_id",@"work_remarks"] andValueArr:@[repairID,opinionView.text] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Unexedelegate PushLoginVCDidClicked];
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
             NSString *SQLrepairdID = [NSString stringWithFormat:@"%@-%@-%@-%@-%@",mobile_phone,property_ids,community_ids,role,repairID];
             BOOL update = [_db executeUpdate:@"update contact set phone = ? where name = ?",@"1",SQLrepairdID];
             if (update) {
                 NSLog(@"更新数据成功");
             }else{
                 NSLog(@"更新数据失败");
             }
             [GJSVProgressHUD dismiss];
             [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
             [self.tableview.mj_header beginRefreshing];
         }
     }];
    [_coverButton removeFromSuperview];
}
//维修师傅
-(void)getMaintenancemaster
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSString *property_ids;
    NSString *community_ids;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    property_ids = model.property_id;
    community_ids = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"repair_who" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"start_num",@"per_pager_nums"] andValueArr:@[property_ids,community_ids,startNum,@"10"] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Unexedelegate PushLoginVCDidClicked];
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
             [userDefaults setObject:workNameArray forKey:@"UNexeworkNameArray"];
             [userDefaults setObject:workIdarray forKey:@"UNexeworkIDArray"];
             [userDefaults synchronize];
             [GJSVProgressHUD dismiss];
             //             [self getoWNER];
         }
     }];
}
//接受工单
-(void)receiveWage
{
    NSString *repairID = repairdidArray[OWNERTAG];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [GJSVProgressHUD showWithStatus:@"接单中"];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"receive" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[repairID] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Unexedelegate && [self.Unexedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Unexedelegate PushLoginVCDidClicked];
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
             [self.tableview.mj_header beginRefreshing];
             
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
             
             NSString *key =repairID;
             NSDictionary *user = @{@"id": repairID, Start_Time: start_time};
             [store putObject:user withId:key intoTable:tableName];
             
             
         }
     }];
}
-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[worknameID]];
}
////当键盘出现或改变时调用
- (void)wageFirstkeyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    height = keyboardRect.size.height;
    CGRect Frame = CGRectMake (W/2 - 140, H - height - 240, 280, 240);
    [apportionView setFrame: Frame];
    CGRect Frames = CGRectMake (20,CGRectGetMaxY(window.frame)/2 -200 - (height - (CGRectGetMaxY(window.frame) - CGRectGetMaxY(window.frame)/2 - 120))  ,WIDTH - 40, 320);
    [cancelView setFrame:Frames];
    CGRect Fvrame =  CGRectMake (20, 90-height+45*3, WIDTH-40 , 438);
    [transferView setFrame: Fvrame];
    
}
//输入结束
- (void)wageFirstkeyboardWillHide:(NSNotification *)aNotification
{
    CGRect Frame = CGRectMake (W/2 - 140, 150, 280, 240);
    CGRect Frames = CGRectMake (20, CGRectGetMaxY(window.frame)/2 - 200, WIDTH - 40,320 );
    [apportionView setFrame: Frame];
    [cancelView setFrame: Frames];
    
    CGRect Fvrame = CGRectMake (20, 90, WIDTH-40 , 438);
    [transferView setFrame: Fvrame];
    
}

-(void)closecancelViewDidClicked
{
    [self.coverButton removeFromSuperview];
}

@end
