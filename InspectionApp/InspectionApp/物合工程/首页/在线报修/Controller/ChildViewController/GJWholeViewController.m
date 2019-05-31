//最左边的


//
//  GJUnexecutedViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJWholeViewController.h"
//#import "GJpatrolViewController.h"
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

@interface GJWholeViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,UIAlertViewDelegate,UITextViewDelegate,UITextFieldDelegate,workNameIDDelegates>
{
    NSString *state;
    NSMutableArray *repairNumArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *parentclassArray;
    NSMutableArray *ivvjsonArray;
    NSMutableArray *repairtimeArray;
    NSMutableArray *repairdidArray;
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
    //    NSDictionary *LocationDict;
    //    NSString *ISLocation;
    NSDictionary *Locationdicts;
    NSInteger imageDataTag;
    UIWindow *window;
    NSMutableArray *wageTypeArray;
    BOOL WAGEISSUCCESS;
    NSString *MattersaveToken;
    NSInteger Srow;
}

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIScrollView *scrollview;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,strong) GJFMDatabase *db;


@property(nonatomic,strong)UITableView *GRtableview;

@end

@implementation GJWholeViewController
-(void)viewWillAppear:(BOOL)animated
{
    WAGEISSUCCESS = YES;
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LocationFish) name:@"LocationFish" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Locationfail) name:@"Locationfail" object:nil];
//    if (IS_iPhoneX) {
//        
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, KScreenHeight- 88-50-34-40) style:UITableViewStylePlain];
//        
//    }else{
//        
//        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64-49-40) style:UITableViewStylePlain];
//        
//    }
    
    if (IS_iPhoneX) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, KScreenHeight- 88-34-40) style:UITableViewStylePlain];
        
    }else{
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64-40) style:UITableViewStylePlain];
        
    }
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview: self.tableview];
    
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
    wageTypeArray = [NSMutableArray array];
    startNum = @"0";
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.backgroundColor = viewbackcolor;
    startNum = @"0";
    pagenum = 0;
    [self LocationData];
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
// 自定义cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
        fouthTableVCell.RedLoadbutton.hidden = YES;
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"分派工单" forState:UIControlStateNormal];
            
            //   标记无效按钮
            self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
            [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
            self.invalidButton.layer.cornerRadius = 5;
            self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
            [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
            [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
            self.invalidButton.tag = indexPath.row;
            [fouthTableVCell addSubview:self.invalidButton];
            
        }else
        {
            
            self.dispatchButton.frame =CGRectMake(W/2-100, 90, 200, 30);
            
            
            [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            
        }
        [fouthTableVCell addSubview:self.dispatchButton];
        
        
        
        
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
        
        self.dispatchButton.backgroundColor = NAVCOlOUR;
        [self.invalidButton setBackgroundColor:gycoloer];
        self.dispatchButton.userInteractionEnabled = YES;
        self.invalidButton.userInteractionEnabled = YES;
        
        
        UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(videoButton.width/2 - 7, videoButton.width/2 - 7, 14, 14)];
        bofangimageView.backgroundColor = [UIColor clearColor];
        bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
        [videoImageView addSubview:bofangimageView];
        [videoButton addSubview:videoImageView];
        [fouthTableVCell addSubview:videoButton];
        fouthTableVCell.numberLable.text = repairNumArray[indexPath.row];
        [fouthTableVCell.WageagainButton addTarget:self action:@selector(WageAgainSubmit:) forControlEvents:UIControlEventTouchUpInside];
        if ([fouthTableVCell.numberLable.text isEqualToString:@"正在上传..."]) {
            if (WAGEISSUCCESS == NO) {
                fouthTableVCell.WageagainButton.hidden = NO;
            }
        }else
        {
            fouthTableVCell.WageagainButton.hidden = YES;
        }
        return fouthTableVCell;
    }
    else if(VoiceArray.count != 0)
    {
        for (NSDictionary *dict in VoiceArray) {
            NSString *times = dict[@"voice_time"];
            VoiceButtonLength = [times integerValue];
            NSString *voiceurl = [userDefaults objectForKey:@"app_voice_url"];
            NSString *voiceStr = dict[@"voice"];
            VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceStr];
        }
        GJWageSecondTableViewCell *secondacell = [GJWageSecondTableViewCell createCellWithTableView:tableView withIdentifier:@"Secondflags"];
        //    分派工单按钮
        secondacell.RedWagebutton.hidden = YES;
        
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.backgroundColor = NAVCOlOUR;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"分派工单" forState:UIControlStateNormal];
            //   标记无效按钮
            self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
            [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
            self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
            self.invalidButton.layer.cornerRadius = 5.0f;
            [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
            self.invalidButton.tag = indexPath.row;
            [self.invalidButton setBackgroundColor:gycoloer];
            [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
            
            
            self.dispatchButton.backgroundColor = NAVCOlOUR;
            [self.invalidButton setBackgroundColor:gycoloer];
            self.dispatchButton.userInteractionEnabled = YES;
            self.invalidButton.userInteractionEnabled = YES;
            
            
            
            [secondacell.contentView addSubview:self.invalidButton];
            
        }else
        {
            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            self.dispatchButton.frame =CGRectMake(W/2-100, 90, 200, 30);
            
            [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            
            
        }
        [secondacell.contentView addSubview:self.dispatchButton];
        
        
        self.timeLable = [[UILabel alloc]init];
        self.timeLable.textColor = NAVCOlOUR;
        self.timeLable.font = [UIFont fontWithName:geshi size:15];
        [secondacell.contentView addSubview:self.timeLable];
        VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
        [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
        self.timeLable.text = [NSString stringWithFormat:@"%ld''",(long)VoiceButtonLength];
        int voiceLength;
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
        [secondacell.contentView addSubview:voiceButton];
        secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondacell.numberLable.text = repairNumArray[indexPath.row];
        secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
        [secondacell.WageagainButton addTarget:self action:@selector(WageAgainSubmit:) forControlEvents:UIControlEventTouchUpInside];
        if ([secondacell.numberLable.text isEqualToString:@"正在上传..."]) {
            if (WAGEISSUCCESS == NO) {
                secondacell.WageagainButton.hidden = NO;
            }
        }else
        {
            secondacell.WageagainButton.hidden = YES;
        }
        return secondacell;
    }
    else if(imageArray.count != 0)
    {
        GJWageThirdTableViewCell *thirdTableVCell = [GJWageThirdTableViewCell createCellWithTableView:tableView withIdentifier:@"Thirdflags"];
        //    分派工单按钮
        thirdTableVCell.RedWagebutton.hidden = YES;
        
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.backgroundColor =NAVCOlOUR;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"分派工单" forState:UIControlStateNormal];
            //   标记无效按钮
            self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
            [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
            self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
            self.invalidButton.layer.cornerRadius = 5.0f;
            
            [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
            self.invalidButton.tag = indexPath.row;
            [self.invalidButton setBackgroundColor:gycoloer];
            [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
            [thirdTableVCell addSubview:self.invalidButton];
            
        }else
        {
            
            self.dispatchButton.frame =CGRectMake(W/2-100, 90, 200, 30);
            
            [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            
            
        }
        
        
        self.dispatchButton.backgroundColor =NAVCOlOUR;
        [self.invalidButton setBackgroundColor:gycoloer];
        self.dispatchButton.userInteractionEnabled = YES;
        self.invalidButton.userInteractionEnabled = YES;
        
        
        [thirdTableVCell addSubview:self.dispatchButton];
        
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
        
        thirdTableVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        thirdTableVCell.numberLable.text = repairNumArray[indexPath.row];
        [thirdTableVCell.WageagainButton addTarget:self action:@selector(WageAgainSubmit:) forControlEvents:UIControlEventTouchUpInside];
        if ([thirdTableVCell.numberLable.text isEqualToString:@"正在上传..."]) {
            if (WAGEISSUCCESS == NO) {
                thirdTableVCell.WageagainButton.hidden = NO;
            }
        }else
        {
            thirdTableVCell.WageagainButton.hidden = YES;
        }
        return thirdTableVCell;
    }else{
        GJWageFirstTableViewCell *firstcell = [GJWageFirstTableViewCell createCellWithTableView:tableView withIdentifier:@"FirstFlags"];
        firstcell.redLoadbutton.hidden = YES;
        //    分派工单按钮
        self.dispatchButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2-110, 90, 80, 30)];
        self.dispatchButton.tag = indexPath.row;
        self.dispatchButton.layer.cornerRadius = 5;
        self.dispatchButton.backgroundColor =NAVCOlOUR;
        self.dispatchButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
        [self.dispatchButton addTarget:self action:@selector(OnebuttonDdiClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([[userDefaults objectForKey:@"role"] isEqualToString:@"admin"]) {
            [self.dispatchButton setTitle:@"分派工单" forState:UIControlStateNormal];
            //   标记无效按钮
            self.invalidButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+30, 90, 80, 30)];
            [self.invalidButton setTitle:@"标记无效" forState:UIControlStateNormal];
            self.invalidButton.titleLabel.font = [UIFont fontWithName:geshi size:15];
            self.invalidButton.layer.cornerRadius = 5.0f;
            [self.invalidButton addTarget:self action:@selector(OnebuttonDdiClickeds:) forControlEvents:UIControlEventTouchUpInside];
            [self.invalidButton setBackgroundColor:gycoloer];
            [self.invalidButton setBackgroundImage:[UIImage imagewithColor:gycoloers] forState:UIControlStateHighlighted];
            self.invalidButton.tag = indexPath.row;
            
            
            
            
            
            [firstcell addSubview:self.invalidButton];
        }else
        {
            NSDictionary *danOne= unexeAllDataArray[indexPath.row];
            self.dispatchButton.frame =CGRectMake(W/2-100, 90, 200, 30);
            
            [self.dispatchButton setTitle:@"抢单" forState:UIControlStateNormal];
            
            
            
            
        }
        
        self.dispatchButton.backgroundColor = NAVCOlOUR;
        [self.invalidButton setBackgroundColor:gycoloer];
        self.dispatchButton.userInteractionEnabled = YES;
        self.invalidButton.userInteractionEnabled = YES;
        [firstcell addSubview:self.dispatchButton];
        
        firstcell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstcell.WageTyperLable.text =  [NSString stringWithFormat:@"%@%@",parentclassArray[indexPath.row],@" :"];
        
        
        if (_isAnBao) {
            firstcell.WageTyperLable.text = @"公众服务 :";
        }

        firstcell.numberLable.text = repairNumArray[indexPath.row];
        firstcell.dataLable.text = repairtimeArray[indexPath.row];
        [firstcell.WageagainButton addTarget:self action:@selector(WageAgainSubmit:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([firstcell.numberLable.text isEqualToString:@"正在上传..."]) {
            if (WAGEISSUCCESS == NO) {
                firstcell.WageagainButton.hidden = NO;
            }
        }else
        {
            firstcell.WageagainButton.hidden = YES;
        }
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
#pragma mark - cell 的点击事件
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
    if (wageTypeArray.count == 0) {
        if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(WholeCellDidClicked: Islocation:)]) {
            [self.Wholedelegate WholeCellDidClicked:unexeAllDataArray[indexPath.row] Islocation:location];
        }
        else
        {
            NSLog(@"协议方案未实现");
        }
    }else{
        if ([wageTypeArray[indexPath.row]isEqualToString:@"待处理"]) {
            if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(WholeCellDidClicked: Islocation:)]) {
                [self.Wholedelegate WholeCellDidClicked:unexeAllDataArray[indexPath.row] Islocation:location];
                
            }else{
                
                NSLog(@"协议方案未实现");
            }
        }else{
            if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(WholeCellDidClicked: Islocation:)]) {
                [self.Wholedelegate WholeCellDidClicked:unexeAllDataArray[indexPath.row] wageType:wageTypeArray[indexPath.row]];
            }
            else
            {
                NSLog(@"协议方案未实现");
            }
        }
        
    }
    }
}

-(void)LocationData{
    
    GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [placeimageView removeFromSuperview];
    [placelable removeFromSuperview];
    [self removeData];
    unexedataArray = [NSMutableArray array];
    if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
        unexedataArray = [userDefaults objectForKey:@"AdminWageALLdataArray"];
    }else
    {
        unexedataArray = [userDefaults objectForKey:@"NormalALLdataArray"];
    }
    if ([GJSingleTon defaultSingleTon].dict1) {
        NSMutableArray *saveArray = [NSMutableArray array];
        [saveArray addObjectsFromArray:unexedataArray];
        Locationdicts = [NSDictionary dictionary];
        Locationdicts = [GJSingleTon defaultSingleTon].dict1;
        [saveArray insertObject:Locationdicts atIndex:0];
        unexedataArray = saveArray;
        self.tableview.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        for (NSDictionary *dict in unexedataArray) {
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
    }else if(!connect.connectedToNetwork)
    {
        for (NSDictionary *dict in unexedataArray) {
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
            [wageTypeArray addObject:dict[@"repair_status"]];
        }
        for (int i = 0; i < unexedataArray.count; i++) {
            [unexeAllDataArray addObject:unexedataArray[i]];
        }
        [self.tableview reloadData];
    }
    else
    {
        [self Notassigned];
    }
}


-(void)Notassigned{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    property_id = model.property_id;
    community_id =model.community_id;
    if (community_id == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请返回首页选择小区"];
        [self.tableview.mj_header endRefreshing];
    }else{
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_work_list" andBodyOfRequestForKeyArr:@[@"repair[property_id]",@"repair[community_id]",@"repair[repair_status]",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"未处理",startNum,@"10"] andBlock:^(id dictionary)
         {
             NSLog(@"%@",dictionary);
             NSArray * arr = [dictionary objectForKey:@"return_data"];
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.Wholedelegate PushLoginVCDidClicked];
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
             }else      if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
             }
             else if ([state isEqualToString:@"0"] && [startNum isEqualToString:@"0"])
             {
                 [self removeData];
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
                 unexedataArray = dictionary[@"return_data"];
                 for (NSDictionary *dict in unexedataArray) {
                     [descriptionArray addObject:dict[@"description"]];
                     [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                     [parentclassArray addObject:dict[@"parent_class"]];
                     [ivvjsonArray addObject:dict[@"ivv_json"]];
                     [repairtimeArray addObject:dict[@"repair_time"]];
                     [repairdidArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_id"]]];
                     [servingTimeArray addObject:dict[@"serving_time"]];
                     [wageTypeArray addObject:dict[@"repair_status"]];
                 }
                 [userDefaults setObject:ivvjsonArray forKey:@"TheivvjsonArray"];
                 [userDefaults setObject:unexedataArray[0] forKey:@"unexedataArray0Data"];
                 [discoVerButton removeFromSuperview];
                 for (int i = 0; i < unexedataArray.count; i++) {
                     [unexeAllDataArray addObject:unexedataArray[i]];
                 }
                 // 上划加载
                 self.tableview.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                     [self loadMoreData];
                 }];
                 NSLog(@"unexeAllDataArray————————————%@",unexeAllDataArray);
                 if ([startNum isEqualToString:@"0"]) {
                     if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                         [userDefaults setObject:unexeAllDataArray forKey:@"AdminWageALLdataArray"];
                     }else
                     {
                         
                         [userDefaults setObject:unexeAllDataArray forKey:@"NormalALLdataArray"];
                         
                     }
                 }
                 [userDefaults synchronize];
             }
             [self.tableview.mj_header endRefreshing];
             [self.tableview.mj_footer endRefreshing];
             [self.tableview reloadData];
         }];
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
    [wageTypeArray removeAllObjects];
}

//弹窗
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(alertView.tag==9999)
    {
        GJLoginViewController *log=[[GJLoginViewController alloc] init];
        [self presentViewController:log animated:YES completion:nil];
        
    }
    if (alertView.tag==9996) {
        if (buttonIndex==0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO]) {
                
                NSDictionary *dic=[[NSUserDefaults standardUserDefaults] objectForKey:MY_UPGRADE_INFO];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
            }
            
        }
    }

    if(alertView.tag == 12)
    {
        if (buttonIndex == 0) {
            [alertView removeFromSuperview];
        }else
        {
            [self receiveWage];
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
    
    if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.Wholedelegate PushVideoVCDidClicked:VideoUrl];
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
    if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(pushImagebrowserDidClicked: imageTag:)]) {
        [self.Wholedelegate pushImagebrowserDidClicked:imagemutableArray imageTag:sender.tag - 4000];
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
        [GJSVProgressHUD showWithStatus:@"请稍后"];
        [self getMaintenancemaster];
    }else
    {
        //抢单
        //        OrdersLable.text=@"抢单";
        NSString *repairID = repairdidArray[OWNERTAG];
        
        NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
        GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
        
        if ([model.property_id isEqualToString:@""]) {
            //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
            //return;
        }
        
        // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *property_ids = model.property_id;
        
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"grab" andBodyOfRequestForKeyArr:@[@"repair_id",@"property_id"] andValueArr:@[repairID,property_ids] andBlock:^(id dictionary)
         {
             
             NSLog(@"%@",property_ids);
             NSLog(@"%@",repairID);
             NSLog(@"%@",dictionary);
             
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                     [self presentViewController:loginVC animated:YES completion:nil];
                 });
             }else      if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
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
                 
               
             }
         }];
        
        
        
        //        UIAlertView *receiveWage = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定接受该工单？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        //        receiveWage.tag = 12;
        //        [receiveWage show];
        
    }
}
-(void)yanzheng:(NSString *)str
{
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"confirm_grab" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[str] andBlock:^(id dictionary)
     {
         NSLog(@"%@",str);
         NSLog(@"%@",dictionary);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [GJSVProgressHUD dismiss];
                 GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                 [self presentViewController:loginVC animated:YES completion:nil];
             });
         }else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
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
             
             
#pragma mark - 抢单成功
             
             //                 再走个接口实现这三个
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
             
             NSString *key =str;
             NSDictionary *user = @{@"id": str, Start_Time: start_time};
             [store putObject:user withId:key intoTable:tableName];
             
             
             
             
             
         }
     }];
    
}



-(void)getoWNER
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
    
    _fenpeiyesButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 95+45*3+100+30, apportionView.width - 40, 40)];
    [_fenpeiyesButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [_fenpeiyesButton setTitle:@"确定" forState:UIControlStateNormal];
    _fenpeiyesButton.tag = OWNERTAG;
    [_fenpeiyesButton addTarget: self action:@selector(YESButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [apportionView addSubview:opinionView];
    [apportionView addSubview:titleLable];
    [apportionView addSubview:_fenpeiyesButton];
    [self.coverButton addSubview:apportionView];
    [window addSubview:self.coverButton];
}
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
    lineLable.backgroundColor = NAVCOlOUR;
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
    Srow=0;
}
//分派确定
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
    NSLog(@"repairID________________________%@",repairID);
    NSString *servingtime = servingTimeArray[sender.tag];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[Srow]];

    if (theworkID == nil) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择维修人员！"];
    }
    else
    {
        [GJSVProgressHUD showWithStatus:@"分派中"];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"accept" andBodyOfRequestForKeyArr:@[@"rep[property_id]",@"rep[repair_id]",@"rep[repair_who]",@"rep[remarks]"] andValueArr:@[property_ids,repairID,theworkID,opinionView.text] andBlock:^(id dictionary)
         {
             NSLog(@"分派——————dictionary___%@",dictionary);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.Wholedelegate PushLoginVCDidClicked];
                     }
                     else
                     {
                         NSLog(@"协议方案未实现");
                     }
                 });
             }
             else      if ([state isEqualToString:@"5"]) {
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
             } else if ([state isEqualToString:@"3"])
             {
                 
                 [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
                 
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
                 Srow=0;
             }
         }];
        [_coverButton removeFromSuperview];
    }
}
//无效确定
-(void)YESCaleButtonDidClicked:(UIButton *)sender
{  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSString *mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
    NSString *property_ids = model.property_id;
    NSString *community_ids = model.community_id;
    NSString *role = [userDefaults objectForKey:@"role"];
    
    [GJSVProgressHUD showWithStatus:@"标记中"];
    NSString *repairID = repairdidArray[sender.tag];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    NSString * fstr = @"repair";
    NSArray * keyArr = @[@"rep[repair_id]",@"rep[work_remarks]"];
    if (_isAnBao) {
        fstr = @"security";
        keyArr = @[@"repair_id",@"work_remarks"];
    }
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:fstr andA:@"edit_invalid" andBodyOfRequestForKeyArr:keyArr andValueArr:@[repairID,opinionView.text] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Wholedelegate PushLoginVCDidClicked];
                 }
                 else
                 {
                     NSLog(@"协议方案未实现");
                 }
             });
         }else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
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
    NSString *property_ids;
    NSString *community_ids;
    
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    property_ids = model.property_id;
    community_ids = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_who" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"start_num",@"per_pager_nums"] andValueArr:@[property_ids,community_ids,startNum,@"10"] andBlock:^(id dictionary)
     {
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Wholedelegate PushLoginVCDidClicked];
                 }
                 else
                 {
                     NSLog(@"协议方案未实现");
                 }
             });
         }
         else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
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
             [self getoWNER];
         }
         
     }];
}
//接受工单
-(void)receiveWage
{
    NSString *repairID = repairdidArray[OWNERTAG];
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [GJSVProgressHUD showWithStatus:@"接单中"];
    [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"receive" andBodyOfRequestForKeyArr:@[@"repair_id"] andValueArr:@[repairID] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary);
         state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ( [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 if (self.Wholedelegate && [self.Wholedelegate respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                     [self.Wholedelegate PushLoginVCDidClicked];
                 }
                 else
                 {
                     NSLog(@"协议方案未实现");
                 }
             });
         }
         else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:dictionary[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:dictionary[@"upgrade_info"][@"info"] withDelegate:self];
             
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
         }
     }];
}

-(void)worknameid:(NSInteger)worknameID
{
    theworkID = [NSString stringWithFormat:@"%@",workIdarray[worknameID]];
}

//当键盘出现或改变时调用
- (void)wageFirstkeyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    height = keyboardRect.size.height;
    CGRect Frame =  CGRectMake (20, 90-height+45*3, WIDTH-40 , 438);
    [apportionView setFrame: Frame];
    
    CGRect Frames = CGRectMake (20,CGRectGetMaxY(window.frame)/2 -200 - (height - (CGRectGetMaxY(window.frame) - CGRectGetMaxY(window.frame)/2 - 120))  ,WIDTH - 40, 320);
    [cancelView setFrame:Frames];
}

//输入结束
- (void)wageFirstkeyboardWillHide:(NSNotification *)aNotification
{
    
    CGRect Frame = CGRectMake (20, 90, WIDTH-40 , 438);
    CGRect Frames = CGRectMake (20, CGRectGetMaxY(window.frame)/2 - 200, WIDTH - 40,320 );
    [apportionView setFrame: Frame];
    [cancelView setFrame: Frames];
}

-(void)unExecutedfishWage
{
    [self.tableview.mj_header beginRefreshing];
}

//工单提交成功
-(void)LocationFish
{
    [GJSingleTon defaultSingleTon].dict1 = nil;
    Locationdicts = nil;
    ISTIMERSTR = NO;
    ISshang = NO;
    pagenum = 0;
    [self Notassigned];
}
-(void)closecancelViewDidClicked
{
    [self.coverButton removeFromSuperview];
}
//工单提交失败
-(void)Locationfail
{
    WAGEISSUCCESS = NO;
    [self LocationData];
}
//再次重复提交工单（获取saveToken）
-(void)WageAgainSubmit:(UIButton *)sender
{
    [sender setTitle:@"正在提交" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"app_config" Action:@"get_save_token"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"app_config";
    params[@"a"] = @"get_save_token";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"save_id"] = userid;
    //3,发送请求
    [mgr POST:URL_LOCAL parameters:params success:^(GJAFHTTPRequestOperation *operation, id responseObject)
     {
         MattersaveToken = responseObject[@"return_data"][@"save_token"];
         [self SubmitMatterData];
     } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
     }];
}

//上交再次提交数据
-(void)SubmitMatterData
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *property_ids = model.property_id;//物业公司ID
    NSString *NowcommunitIDs = model.community_id;//小区ID
    NSDictionary *WageDataDict = [userdefaults objectForKey:@"repartWageSubmit"];
    NSString *userid = [userdefaults objectForKey:@"user_id"];
    NSString *session = [userdefaults objectForKey:@"session_key"];
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"repair" Action:@"do_repair"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"repair";
    params[@"a"] = @"do_repair";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"user_id"] = userid;
    params[@"session_key"] = session;
    params[@"save_token"] = MattersaveToken;
    params[@"repair[community_id]"] = NowcommunitIDs;
    params[@"repair[property_id]"] = property_ids;
    params[@"repair[is_self]"] = WageDataDict[@"repair[is_self]"];
    params[@"repair[is_help]"] = WageDataDict[@"repair[is_help]"];
    params[@"repair[sort_class]"] = WageDataDict[@"repair[sort_class]"];
    params[@"repair[repair_time]"] = WageDataDict[@"repair[repair_time]"];
    params[@"repair[room_id]"] = WageDataDict[@"repair[room_id]"];
    params[@"repair[position]"] = WageDataDict[@"repair[position]"];
    params[@"repair[description]"] = WageDataDict[@"repair[description]"];
    params[@"repair[name]"] = WageDataDict[@"repair[name]"];
    params[@"repair[contact]"] = WageDataDict[@"repair[contact]"];
    params[@"repair[serving_time]"] = WageDataDict[@"repair[serving_time]"];
    params[@"repair[fac_id]"] = WageDataDict[@"repair[fac_id]"];
    params[@"voice_time[0]"] = WageDataDict[@"voice_time[0]"];
    NSArray *ImageDataArray = WageDataDict[@"RepartPlayVideoImageData"];
    NSURL *VideoURL = WageDataDict[@"Repartplaymoviedurl"];
    NSURL *Mp3URL = WageDataDict[@"RepartMp3File"];
    [mgr POST:URL_LOCAL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //图片
        if (ImageDataArray.count != 0) {
            for (int i = 0; i < ImageDataArray.count; i++)
            {
                //                UIImage *image = [[UIImage alloc]init];
                //                image = ImageDataArray[i];
                //                UIImage *newImages = [self imageCompressForWidth:image targetWidth:image.size.width/2];
                NSData *data = [ImageDataArray[i] dataUsingEncoding:NSUTF8StringEncoding]; ;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"images[%d]",i] fileName:fileName mimeType:@"image/png"];
            }
        }
        //视频
        if (VideoURL != nil)
        {
            NSData *data = [NSData dataWithContentsOfURL:VideoURL];
            [formData appendPartWithFileData:data name:@"video[0]" fileName:WageDataDict[@"ReplartplaymoviedStr"] mimeType:@"audio/mp4"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@Video.png", str];
            [formData appendPartWithFileData:WageDataDict[@"RepartPlayVideoImageData"] name:@"video_img[0]" fileName:fileName mimeType:@"image/png"];
        }
        //音频
        if(Mp3URL != nil) {
            NSData *data = [NSData dataWithContentsOfURL:Mp3URL];
            [formData appendPartWithFileData:data name:@"voice[0]" fileName:@"lvRecord.mp3" mimeType:@"audio/mp3"];
        }
    } success:^(GJAFHTTPRequestOperation *operation, id responseObject)
     {
         state = [NSString stringWithFormat:@"%@",responseObject[@"state"]];
         [GJSVProgressHUD dismiss];
         if ([state isEqualToString:@"1"])
         {
             WAGEISSUCCESS = YES;
             Locationdicts = nil;
             [self Notassigned];
         }else if ( [state isEqualToString:@"4"] ||[state isEqualToString:@"2"] ) {
             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                 [self presentViewController:LoginViewController animated:YES completion:nil];
             });
         }else      if ([state isEqualToString:@"5"]) {
             [self alertToLoginMsg:responseObject[@"return_data"] withDelegate:self];
         } else if ([state isEqualToString:@"3"])
         {
             
             [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"upgrade_info"] forKey:MY_UPGRADE_INFO];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             [self alertToUpMsg:responseObject[@"upgrade_info"][@"info"] withDelegate:self];
             
         }
         else if ([state isEqualToString:@"-1"])
         {
         }else
         {
             [GJSVProgressHUD showErrorWithStatus:responseObject[@"return_data"]];
         }
     } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         });
     }];
}
//压缩图片
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth//图片压缩
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat heights = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * heights;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImages = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImages;
    
}






-(void)alertToLoginMsg:(NSString *)str withDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9999;
}

- (void) alertToUpMsg:(NSString *) str withDelegate:(id) delegate{//点击升级
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9996;
    
}



@end
