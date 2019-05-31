//
//  MLSecurityCLZVC.m
//  物联宝管家
//
//  Created by yang on 2019/1/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "MLSecurityCLZVC.h"
//
//  GJExecutedViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedViewController.h"
#import "GJExecutedTableViewCell.h"
#import "GJExecutedTableViewTwoCell.h"
#import "GJExecutedTableViewThreeCell.h"
#import "GJExecutedTableViewFouthCell.h"
#import "GJSDAdScrollView.h"
#import "GJExecutedChildViewController.h"

#import "GJCommunityModel.h"

@interface MLSecurityCLZVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,AVAudioPlayerDelegate>
{
    NSString *state;
    NSString *property_id;
    NSString *community_id;
    NSString *startNum;
    int pagenum;
    UIImageView *placeimageView;
    UILabel *placeLable;
    
    
    NSArray *exedataArray;
    NSMutableArray *exeAllDataArray;
    NSMutableArray *repairNumArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *parentclassArray;
    NSMutableArray *ivvjsonArray;
    NSMutableArray *executedtimeArray;
    NSMutableArray *repairmasternameArray;
    //视频接口
    NSString *videoImageUrl;
    //音频时间
    NSString *voiceTimeStr;
    NSString *voicetimelables;
    NSString *voicetimes;
    //音频接口
    NSString *VoiceUrl;
    //    UILabel *voiceTimeLable;
    UIButton *PlayVoiceButton;
    
    //图片接口
    NSString *imagesUrl;
    //视频接口
    NSString *VideoUrl;
    //    NSTimer *timer;
    NSTimer *VoiceImageTimer;
    float time;
    UILabel *personLable;
    UILabel *appointtimeLable;
    UITextView *opinionView;
    UITextField *placeLables;
    UIButton *discoverButton;
    UIView *transferView;
    int thetimes;
    int thetime;
    BOOL ISshang;
    UIImageView *VoiceImageView;
    BOOL ISTIMERSTR;
    int buttonTage;
    NSInteger voiceButtonLenth;
    NSTimer *VoiceChangeImageTimer;
    
    int ImageChange;
    UIImageView *leftVoiceImageView;
    UIImageView *rightVoiceImageView;
    UILabel *VoiceTimeLable;
    UIButton *VoicePlayButton;
    UIButton *backGroundButton;
    NSInteger ImageDataTag;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger count;
//@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIScrollView *scrollview;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;

@end

@implementation MLSecurityCLZVC
{
    BOOL _wasKeyboardManagerEnabled;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableview.mj_header beginRefreshing];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //结束定时器
    [VoiceImageTimer invalidate];
    [self.audioPlayer stop];
    ISTIMERSTR = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ExecutedfishWage) name:@"ExecutedfishWage" object:nil];
    exeAllDataArray = [NSMutableArray array];
    descriptionArray = [NSMutableArray array];
    repairNumArray = [NSMutableArray array];
    parentclassArray = [NSMutableArray array];
    ivvjsonArray = [NSMutableArray array];
    executedtimeArray = [NSMutableArray array];
    repairmasternameArray = [NSMutableArray array];
    //    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 153) style:UITableViewStylePlain];
    if (IS_iPhoneX) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, KScreenHeight- 88-34-40) style:UITableViewStylePlain];
        
    }else{
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64-40) style:UITableViewStylePlain];
        
    }
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.backgroundColor = viewbackcolor;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    placeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableview.width/2 - 80, 80, 160, 160)];
    //placeimageView.layer.cornerRadius = placeimageView.size.width/2;
    placeimageView.backgroundColor = [UIColor clearColor];
    placeimageView.image = [UIImage imageNamed:@"100x100"];
    placeimageView.layer.cornerRadius = 80;
    placeimageView.layer.masksToBounds = YES;
    placeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, WIDTH, 30)];
    placeLable.textColor = gycolor;
    placeLable.text = @"暂无报修工单";
    if (_isAnBao) {
        placeLable.text = @"暂无安保工单";
    }
    placeLable.textAlignment = NSTextAlignmentCenter;
    ISTIMERSTR = NO;
    //下拉刷新 设置回调(一旦进入刷新状态,就回调target的action,也就是回调self的reloadNewData方法)
    self.tableview.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        startNum = @"0";
        ISshang = NO;
        pagenum = 0;
        [self Notassigned];
    }];
    [self.tableview.mj_header beginRefreshing];
    
}
// 自定义cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ivvjsonArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GJExecutedTableViewFouthCell height];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        for (NSDictionary *dict in videoArray) {
            NSString *videoimgStr = dict[@"video_img_ico"];
            NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
            videoImageUrl = [NSString stringWithFormat:@"%@%@",@"",videoimgStr];
        }
        GJExecutedTableViewFouthCell *fouthTableVCell = [GJExecutedTableViewFouthCell createCellWithTableView:tableView withIdentifier:@"Fouthflags"];
        fouthTableVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *videoButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 35, 40, 40)];
        UIImageView *videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        videoButton.tag =indexPath.row+1000;
        [videoButton addTarget:self action:@selector(videoButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [videoImageView sd_setImageWithURL:[NSURL URLWithString:videoImageUrl] placeholderImage:[UIImage imageNamed:@"100x100"]];
        UIImageView *bofangimageView = [[UIImageView alloc]initWithFrame:CGRectMake(videoButton.width/2 - 7, videoButton.width/2 - 7, 14, 14)];
        bofangimageView.backgroundColor = [UIColor clearColor];
        bofangimageView.image = [UIImage imageNamed:@"mlgj-2x88"];
        [videoImageView addSubview:bofangimageView];
        [videoButton addSubview:videoImageView];
        [fouthTableVCell addSubview:videoButton];
        fouthTableVCell.numberLable.text = repairNumArray[indexPath.row];
        fouthTableVCell.rightImageView.image = [UIImage imageNamed:@"sssss"];
        fouthTableVCell.personnameLable.text = [NSString stringWithFormat:@"%@%@",@"服务人 : ",repairmasternameArray[indexPath.row]];
        fouthTableVCell.timeLable.text = executedtimeArray[indexPath.row];
        return fouthTableVCell;
    }
    else if(VoiceArray.count != 0)
    {
        for (NSDictionary *dict in VoiceArray) {
            NSString *times = dict[@"voice_time"];
            voiceButtonLenth = [times integerValue];
            NSString *voiceurl = [userDefaults objectForKey:@"app_voice_url"];
            NSString *voiceStr = dict[@"voice"];
            VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceStr];
        }
        GJExecutedTableViewThreeCell *secondacell = [GJExecutedTableViewThreeCell createCellWithTableView:tableView withIdentifier:@"Secondflags"];
        secondacell.operateButton.tag = indexPath.row;
        self.voiceTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2 + 10 , 45, 30, 22)];
        self.voiceTimeLable.textAlignment = NSTextAlignmentLeft;
        self.voiceTimeLable.textColor =NAVCOlOUR;
        self.voiceTimeLable.font = [UIFont fontWithName:geshi size:15];
        [secondacell.contentView addSubview:self.voiceTimeLable];
        
        
        
        int voiceLength;
        if (voiceButtonLenth <= 10) {
            voiceLength = 80;
            self.voiceTimeLable.frame = CGRectMake(100, 45, 30, 22);
        }else if (voiceButtonLenth > 10 && voiceButtonLenth <= 20 )
        {
            voiceLength = 100;
            self.voiceTimeLable.frame = CGRectMake(120, 45, 30, 22);
            
        }else if (voiceButtonLenth > 20 && voiceButtonLenth <= 40)
        {
            voiceLength = 120;
            self.voiceTimeLable.frame = CGRectMake(140, 45, 30, 22);
            
        }else if (voiceButtonLenth > 40 && voiceButtonLenth <= 60)
        {
            voiceLength = 140;
            self.voiceTimeLable.frame = CGRectMake(160, 45, 30, 22);
        }
        UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 42, voiceLength, 28)];
        voiceButton.tag = indexPath.row + 2000;
        [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(PlayVoiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
        
        [voiceButton addSubview:VoiceImageView];
        [secondacell.contentView addSubview:voiceButton];
        secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
        [VoiceImageView setImage:[UIImage imageNamed:@"iconvoice_n_13@2x"]];
        self.voiceTimeLable.text = [NSString stringWithFormat:@"%ld''",(long)voiceButtonLenth];
        secondacell.numberLable.text = repairNumArray[indexPath.row];
        secondacell.rightImageView.image = [UIImage imageNamed:@"sssss"];
        secondacell.personnameLable.text = [NSString stringWithFormat:@"%@%@",@"服务人 : ",repairmasternameArray[indexPath.row]];
        
        secondacell.timeLable.text = executedtimeArray[indexPath.row];
        return secondacell;
    }
    else if(imageArray.count != 0)
    {
        for (NSDictionary *dict in imageArray) {
            NSString *str;
            //            if (!dict[@"images_ico"]) {
            //                str = dict[@"images"];
            //            }else
            //            {
            str = dict[@"images_ico"];
            //            }
            [imageMutableArray addObject:str];
        }
        GJExecutedTableViewTwoCell *thirdTableVCell = [GJExecutedTableViewTwoCell createCellWithTableView:tableView withIdentifier:@"imagelags"];
        if (imageMutableArray.count < 5) {
            for (int i = 0; i < imageMutableArray.count; i ++) {
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 50*i, 35, 40, 40)];
                imagebutton.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row +1000];
                imagebutton.titleLabel.textColor = [UIColor clearColor];
                imagebutton.tag = i + 4000;
                [imagebutton addTarget:self action:@selector(imagebuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                imagesUrl = [NSString stringWithFormat:@"%@%@",@"",imageMutableArray[i]];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                [imagebutton addSubview:imageView];
                [thirdTableVCell.contentView addSubview:imagebutton];
            }
        }else
        {
            for (int i = 0; i < 5; i ++) {
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 50*i, 35, 40, 40)];
                imagebutton.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row +1000];
                imagebutton.titleLabel.textColor = [UIColor clearColor];
                imagebutton.tag = i + 4000;
                [imagebutton addTarget:self action:@selector(imagebuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
                NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
                imagesUrl = [NSString stringWithFormat:@"%@%@",@"",imageMutableArray[i]];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imagesUrl]placeholderImage:[UIImage imageNamed:@"100x100"]];
                [imagebutton addSubview:imageView];
                UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(270, 40, 30, 20)];
                alable.text = @"...";
                alable.textColor = gycoloer;
                alable.font = [UIFont fontWithName:geshi size:20];
                [thirdTableVCell.contentView addSubview:imagebutton];
                [thirdTableVCell.contentView addSubview:alable];
            }
        }
        thirdTableVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        thirdTableVCell.numberLable.text = repairNumArray[indexPath.row];
        thirdTableVCell.rightImageView.image = [UIImage imageNamed:@"sssss"];
        thirdTableVCell.personnameLable.text = [NSString stringWithFormat:@"%@%@",@"维修人 : ",repairmasternameArray[indexPath.row]];
        thirdTableVCell.timeLable.text = executedtimeArray[indexPath.row];
        return thirdTableVCell;
    }else{
        GJExecutedTableViewCell *firstcell = [GJExecutedTableViewCell createCellWithTableView:tableView withIdentifier:@"FirstFlags"];
        firstcell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstcell.numberLable.text = repairNumArray[indexPath.row];
        firstcell.bodytextLable.text = [NSString stringWithFormat:@"%@%@%@",parentclassArray[indexPath.row],@" :",descriptionArray[indexPath.row]];
        if (_isAnBao) {
            firstcell.bodytextLable.text = [NSString stringWithFormat:@"公众服务 :%@",descriptionArray[indexPath.row]];
        }
        
        firstcell.rightImageView.image = [UIImage imageNamed:@"sssss"];
        firstcell.personnameLable.text = [NSString stringWithFormat:@"%@%@",@"维修人 : ",repairmasternameArray[indexPath.row]];
        
        if (_isAnBao) {
            firstcell.personnameLable.text = [NSString stringWithFormat:@"%@%@",@"服务人 : ",repairmasternameArray[indexPath.row]];
        }
        
        firstcell.timeLable.text = executedtimeArray[indexPath.row];
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
    
    if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(ExeCutedDidClicked:)]) {
        [self.exeDelegates ExeCutedDidClicked:exeAllDataArray[indexPath.row]];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
-(void)Notassigned
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (ISshang == YES) {
        NSLog(@"shang");
    }else
    {
        if ([userDefaults objectForKey:@"AdminWageexedataArray"] != nil) {
            [self removedata];
            [placeimageView removeFromSuperview];
            [placeLable removeFromSuperview];
            if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                exedataArray = [userDefaults objectForKey:@"AdminWageexedataArray"];
            }else
            {
                exedataArray = [userDefaults objectForKey:@"NormalWageexedataArray"];
            }
            for (NSDictionary *dict in exedataArray) {
                [descriptionArray addObject:dict[@"description"]];
                [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                [parentclassArray addObject:dict[@"parent_class"]];
                [ivvjsonArray addObject:dict[@"ivv_json"]];
                [executedtimeArray addObject:dict[@"post_time"]];
                [repairmasternameArray addObject:dict[@"repaird"][@"repair_master_name"]];
            }
            for (int i = 0; i < exedataArray.count; i++) {
                [exeAllDataArray addObject:exedataArray[i]];
            }
            [self.tableview reloadData];
        }else
        {
        }
    }
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    
    property_id = model.property_id;
    community_id = model.community_id;
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
     [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"security" andA:@"security_list" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id",@"repair_status",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"处理中",startNum,@"10"] andBlock:^(id dictionary)
     {
         NSLog(@"%@",dictionary);
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
         }else if ([state isEqualToString:@"0"] && [startNum isEqualToString:@"0"])
         {
             [self removedata];
             [self.tableview addSubview:placeLable];
             [self.tableview addSubview:placeimageView];
         }else if([state isEqualToString:@"0"])
         {
             NSString *sta = dictionary[@"return_data"];
             [GJSVProgressHUD showErrorWithStatus:sta];
             
         }else if ([state isEqualToString:@"-1"])
         {
         }
         else if([state isEqualToString:@"1"])
         {
             if (ISshang == YES) {
                 ;
             }else
             {
                 [self removedata];
             }
             [placeimageView removeFromSuperview];
             [placeLable removeFromSuperview];
             exedataArray = [NSArray array];
             exedataArray = dictionary[@"return_data"][@"repair_data"];

             for (NSDictionary *dict in exedataArray) {
                 [descriptionArray addObject:dict[@"description"]];
                 [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                 [parentclassArray addObject:dict[@"parent_class"]];
                 [ivvjsonArray addObject:dict[@"ivv_json"]];
                 [executedtimeArray addObject:dict[@"post_time"]];
                 [repairmasternameArray addObject:dict[@"repaird"][@"repair_master_name"]];
             }
             for (int i = 0; i < exedataArray.count; i++) {
                 [exeAllDataArray addObject:exedataArray[i]];
             }
             // 上划加载
             self.tableview.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                 [self loadMoreData];
             }];
             if ([startNum isEqualToString:@"0"]) {
                 if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                     
                     [userDefaults setObject:exeAllDataArray forKey:@"AdminWageexedataArray"];
                 }else
                 {
                     [userDefaults setObject:exeAllDataArray forKey:@"NormalWageexedataArray"];
                 }
             }
             [userDefaults synchronize];
             
         }
         [self.tableview reloadData];
         [self.tableview.mj_header endRefreshing];
         [self.tableview.mj_footer endRefreshing];
     }];
    //    }
    
}
-(void)removedata
{
    [ivvjsonArray removeAllObjects];
    [parentclassArray removeAllObjects];
    [descriptionArray removeAllObjects];
    [repairNumArray removeAllObjects];
    [executedtimeArray removeAllObjects];
    [repairmasternameArray removeAllObjects];
    [exeAllDataArray removeAllObjects];
}
-(void)loadMoreData
{
    ISshang = YES;
    pagenum += 10;
    startNum = [NSString stringWithFormat:@"%d",pagenum];
    [self Notassigned];
}
-(void)transDiscoverbuttonDidClicked
{
    [discoverButton removeFromSuperview];
}
#pragma mark- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [placeLables setHidden:NO];
    }else{
        [placeLables setHidden:YES];
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
        VideoUrl = [NSString stringWithFormat:@"%@%@",@"",playVideoStr];
        
    }
    if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.exeDelegates PushVideoVCDidClicked:VideoUrl];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}


//播放音频
-(void)PlayVoiceButtonDidClicked:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ivvjsonArray objectAtIndex:(sender.tag - 2000)];
    buttonTage = sender.tag - 2000;
    [userDefaults setObject:@"buttonTage" forKey:@"buttonTage"];
    NSArray *voiceArray = [NSArray array];
    voiceArray = dict[@"voice"];
    for (NSDictionary *dict in voiceArray) {
        NSString *playVoiceStr = dict[@"voice"];
        NSString *voicestr = [userDefaults objectForKey:@"app_voice_url"];
        VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",playVoiceStr];
        voiceTimeStr = dict[@"voice_time"];
    }
    buttonTage = sender.tag - 2000;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
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
        [self.audioPlayer stop];
    }else
    {
        ISTIMERSTR = YES;
        //播放本地音乐
        //设置扩音播放
        UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
        thetimes = [voiceTimeStr intValue];
        ImageChange = ([voiceTimeStr intValue]) * 2;
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
        //将数据保存到本地指定位置
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *filePath = [NSString stringWithFormat:@"/%@.mp3",[formater stringFromDate:[NSDate date]]];
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
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
    VoiceImageTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(exechangeVoiceImage:) userInfo:nil repeats:YES];
    VoiceChangeImageTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(exechangeimageVoiceImage:) userInfo:nil repeats:YES];
}

-(void)exechangeVoiceImage:(NSTimer *)time
{
    ISTIMERSTR = YES;
    thetimes -= 0.5;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%ds ",thetimes];
    if (thetimes == 0) {
        [self backGroundButtonDisMiss];
    }
}
-(void)backGroundButtonDisMiss
{
    ISTIMERSTR = NO;
    [VoiceImageTimer invalidate];
    [VoiceChangeImageTimer invalidate];
    [self.audioPlayer stop];
    [backGroundButton removeFromSuperview];
}
-(void)exechangeimageVoiceImage:(NSTimer *)time
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
    int indexP =[sender.titleLabel.text integerValue] - 1000;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *topurl = [userDefaults objectForKey:@"app_image_url"];
    NSDictionary *dict = [ivvjsonArray objectAtIndex:indexP];
    NSArray *imagearray = [NSArray array];
    NSMutableArray *imagemutableArray = [NSMutableArray array];
    imagearray = dict[@"images"];
    for (NSDictionary *dict in imagearray) {
        NSString *imageStr = dict[@"images"];
        NSString *imageStrs = [NSString stringWithFormat:@"%@%@",@"",imageStr];
        [imagemutableArray addObject:[GJMHPhotoModel photoWithURL:[NSURL URLWithString:imageStrs]]];
    }
    
    if (self.exeDelegates && [self.exeDelegates respondsToSelector:@selector(pushImagebrowserDidClicked:imageTag:)]) {
        [self.exeDelegates pushImagebrowserDidClicked:imagemutableArray imageTag:sender.tag - 4000];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
    
}
//标记完工后立即刷新
-(void)ExecutedfishWage
{
    [self.tableview.mj_header beginRefreshing];
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
