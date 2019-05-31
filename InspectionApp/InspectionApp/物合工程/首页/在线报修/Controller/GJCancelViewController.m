//
//  GJCancelViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/13.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJCancelViewController.h"
//#import "GJpatrolViewController.h"
#import "GJOverTableViewOneCell.h"
#import "GJOverTableViewTwoCell.h"
#import "GJOverTableViewThreeCell.h"
#import "GJOverTableViewFouthCells.h"
#import "GJSDAdScrollView.h"
#import "GJCommunityModel.h"
@interface GJCancelViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
{
    NSString *state;
    NSString *property_id;
    NSString *community_id;
    NSString *startNum;
    int pagenum;
    UIImageView *placeimageView;
    UILabel *placeLable;
    NSArray *canceldataArray;
    NSMutableArray *cancelAllDataArray;
    NSMutableArray *repairNumArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *parentclassArray;
    NSMutableArray *postTimeArray;
    NSMutableArray *ivvjsonArray;
    //视频接口
    NSString *videoImageUrl;
    //音频时间
    NSString *voiceTimeStr;
    //音频接口
    NSString *VoiceUrl;
    UILabel *voiceTimeLable;
    UIButton *PlayVoiceButton;
    
    //图片接口
    NSString *imagesUrl;
    //视频接口
    NSString *VideoUrl;
    NSTimer *timer;
    float time;
    BOOL ISshang;
    int thetime;
    //音频时间
    NSString *voicetimelables;
    NSString *voicetimes;
    NSTimer *VoiceImageTimer;
    UILabel *personLable;
    UILabel *appointtimeLable;
    UITextView *opinionView;
    UITextField *placeLables;
    UIButton *discoverButton;
    UIView *transferView;
    int thetimes;
    UIImageView *VoiceImageView;
    BOOL ISTIMERSTR;
    int buttonTage;
    NSInteger VoiceButtonLenth;
    
    
    
    NSTimer *VoiceChangeImageTimer;
    int ImageChange;
    UIImageView *leftVoiceImageView;
    UIImageView *rightVoiceImageView;
    UILabel *VoiceTimeLable;
    UIButton *VoicePlayButton;
    UIButton *backGroundButton;
    NSInteger imageDataTag;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)NSInteger count;
//@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIScrollView *scrollview;
//@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;

@end

@implementation GJCancelViewController
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
    cancelAllDataArray = [NSMutableArray array];
    descriptionArray = [NSMutableArray array];
    repairNumArray = [NSMutableArray array];
    parentclassArray = [NSMutableArray array];
    ivvjsonArray = [NSMutableArray array];
    postTimeArray = [NSMutableArray array];
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 153) style:UITableViewStylePlain];
    if (IS_iPhoneX) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, KScreenHeight- 88-50-34-40) style:UITableViewStylePlain];
        
    }else{
        
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64-49-40) style:UITableViewStylePlain];
        
    }
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableview.backgroundColor = viewbackcolor;
    ISTIMERSTR = NO;
    placeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableview.width/2 - 80, 80, 160, 160)];
    placeimageView.layer.cornerRadius = 80;
    placeimageView.layer.masksToBounds = YES;
    //placeimageView.layer.cornerRadius = placeimageView.size.width/2;
    placeimageView.backgroundColor = [UIColor clearColor];
    placeimageView.image = [UIImage imageNamed:@"100x100"];
    placeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, WIDTH, 30)];
    placeLable.textColor = gycolor;
    placeLable.text = @"暂无报修工单";
    if (_isAnBao) {
        placeLable.text = @"暂无安保工单";
    }
    placeLable.textAlignment = NSTextAlignmentCenter;
    //下拉刷新 设置回调(一旦进入刷新状态,就回调target的action,也就是回调self的reloadNewData方法)
    self.tableview.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        startNum = @"0";
        pagenum = 0;
        ISshang = NO;
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
    NSLog(@"%lu",(unsigned long)ivvjsonArray.count);

    return ivvjsonArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GJOverTableViewFouthCells height];
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
        GJOverTableViewFouthCells *fouthTableVCell = [GJOverTableViewFouthCells createCellWithTableView:tableView withIdentifier:@"Fouthflags"];
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
        fouthTableVCell.wagetimeLable.text = postTimeArray[indexPath.row];
        UIImageView *urgentimageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 80, 18, 45, 25)];
//        urgentimageView.image = [UIImage imageNamed:@"mlgj-2x49"];
        return fouthTableVCell;
    }
        else if(VoiceArray.count != 0)
        {
            for (NSDictionary *dict in VoiceArray) {
                NSString *times = dict[@"voice_time"];
                VoiceButtonLenth = [times integerValue];
                NSString *voiceurl = [userDefaults objectForKey:@"app_voice_url"];
                NSString *voiceStr = dict[@"voice"];
                VoiceUrl = [NSString stringWithFormat:@"%@%@",@"",voiceStr];
            }
            
            GJOverTableViewThreeCell *secondacell = [GJOverTableViewThreeCell createCellWithTableView:tableView withIdentifier:@"cancelflags"];
            self.timeLable = [[UILabel alloc]init];
            self.timeLable.textColor =NAVCOlOUR;
            self.timeLable.font = [UIFont fontWithName:geshi size:15];
            int voiceLength;
            if (VoiceButtonLenth <= 10) {
                voiceLength = 80;
                self.timeLable.frame = CGRectMake(100, 45, 30, 22);
            }else if (VoiceButtonLenth > 10 && VoiceButtonLenth <= 20 )
            {
                voiceLength = 100;
                self.timeLable.frame = CGRectMake(120, 45, 30, 22);
            }else if (VoiceButtonLenth > 20 && VoiceButtonLenth <= 40)
            {
                voiceLength = 120;
                self.timeLable.frame = CGRectMake(140, 45, 30, 22);
            }else if (VoiceButtonLenth > 40 && VoiceButtonLenth <= 60)
            {
                voiceLength = 140;
                self.timeLable.frame = CGRectMake(160, 45, 30, 22);
                
            }

            UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 42, voiceLength, 28)];
            voiceButton.tag = indexPath.row+2000;
            [voiceButton setBackgroundImage:[UIImage imageNamed:@"icon_n_14@2x"] forState:UIControlStateNormal];
            [voiceButton addTarget:self action:@selector(UNExePlayVoiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            VoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2, 24, 24)];
            
            secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.timeLable.text = [NSString stringWithFormat:@"%ld''",(long)VoiceButtonLenth];
            [VoiceImageView setImage:[UIImage imageNamed:@"iiconvoice_n_13@2x"]];
            secondacell.selectionStyle = UITableViewCellSelectionStyleNone;
            secondacell.wagetimeLable.text = postTimeArray[indexPath.row];
            secondacell.numberLable.text = repairNumArray[indexPath.row];
            [secondacell.contentView addSubview:self.timeLable];
            [voiceButton addSubview:VoiceImageView];
            [secondacell.contentView addSubview:voiceButton];
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
        GJOverTableViewTwoCell *thirdTableVCell = [GJOverTableViewTwoCell createCellWithTableView:tableView withIdentifier:@"imagelags"];
        if (imageMutableArray.count < 5) {
            for (int i = 0; i < imageMutableArray.count; i ++) {
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 45*i, 35, 40, 40)];
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
                UIButton *imagebutton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 45*i, 35, 40, 40)];
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
        thirdTableVCell.wagetimeLable.text = postTimeArray[indexPath.row];
        UIImageView *urgentimageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 80, 18, 45, 25)];
//        urgentimageView.image = [UIImage imageNamed:@"mlgj-2x49"];
        return thirdTableVCell;
    }else{
        GJOverTableViewOneCell *firstcell = [GJOverTableViewOneCell createCellWithTableView:tableView withIdentifier:@"FirstFlags"];
        firstcell.selectionStyle = UITableViewCellSelectionStyleNone;
        firstcell.numberLable.text = repairNumArray[indexPath.row];
        firstcell.bodytextLable.text = [NSString stringWithFormat:@"%@%@%@",parentclassArray[indexPath.row],@" :",descriptionArray[indexPath.row]];
        if (_isAnBao) {
            
            firstcell.bodytextLable.text = [NSString stringWithFormat:@"公众服务 :%@",descriptionArray[indexPath.row]];
        }

        firstcell.wagetimeLable.text = postTimeArray[indexPath.row];
        //取消图片
        UIImageView *urgentimageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 80, 18, 45, 25)];
//        urgentimageView.image = [UIImage imageNamed:@"mlgj-2x49"];
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
    if (self.cancelDelegates && [self.cancelDelegates respondsToSelector:@selector(cancelWageDidClicked:)]) {
        [self.cancelDelegates cancelWageDidClicked:cancelAllDataArray[indexPath.row]];
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
        if ([userDefaults objectForKey:@"AdminWagecanceldataArray"] != nil) {
            [self removeData];
            [placeLable removeFromSuperview];
            [placeimageView removeFromSuperview];
            if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
                canceldataArray = [userDefaults objectForKey:@"AdminWagecanceldataArray"];
            }else
            {
                canceldataArray = [userDefaults objectForKey:@"NormalWagecanceldataArray"];
            }
            for (NSDictionary *dict in canceldataArray) {
                [descriptionArray addObject:dict[@"description"]];
                [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                [parentclassArray addObject:dict[@"parent_class"]];
                [ivvjsonArray addObject:dict[@"ivv_json"]];
                [postTimeArray addObject:dict[@"post_time"]];
            }
            for (int i = 0; i < canceldataArray.count; i++) {
                [cancelAllDataArray addObject:canceldataArray[i]];
            }
            [self.tableview reloadData];
        }else
        {
            NSLog(@"hahah");
        }
        
    }
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
       // [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    

    property_id = model.property_id;
    community_id = model.community_id;

        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"repair" andA:@"repair_work_list" andBodyOfRequestForKeyArr:@[@"repair[property_id]",@"repair[community_id]",@"repair[repair_status]",@"start_num",@"per_pager_nums"] andValueArr:@[property_id,community_id,@"已完成",startNum,@"10"] andBlock:^(id dictionary)
         {
             NSLog(@"%@",dictionary);
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     if (self.cancelDelegates && [self.cancelDelegates respondsToSelector:@selector(PushLoginVCDidClicked)]) {
                         [self.cancelDelegates PushLoginVCDidClicked];
                     }
                     else
                     {
                         NSLog(@"协议方案未实现");
                     }
                 });
             }else if ([state isEqualToString:@"0"] && [startNum isEqualToString:@"0"])
             {

              
                 [self removeData];

                 [self.tableview addSubview:placeLable];
                 [self.tableview addSubview:placeimageView];
             }else if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }
             else if ([state isEqualToString:@"-1"])
             {
             }
             else if([state isEqualToString:@"1"])
             {
                 if (ISshang == YES) {
                     ;
                 }else
                 {
                     [self removeData];
                 }
                 [placeLable removeFromSuperview];
                 [placeimageView removeFromSuperview];
                 canceldataArray = [NSArray array];
                 canceldataArray = dictionary[@"return_data"];
                 for (NSDictionary *dict in canceldataArray) {
                     [descriptionArray addObject:dict[@"description"]];
                     [repairNumArray addObject:[NSString stringWithFormat:@"%@",dict[@"repair_no"]]];
                     [parentclassArray addObject:dict[@"parent_class"]];
                     [ivvjsonArray addObject:dict[@"ivv_json"]];
                     [postTimeArray addObject:dict[@"post_time"]];
                 }
                 for (int i = 0; i < canceldataArray.count; i++) {
                     [cancelAllDataArray addObject:canceldataArray[i]];
                 }
                 NSLog(@"canceldataArray____%@",canceldataArray);
                 if ([startNum isEqualToString:@"0"])
                 {
//                     if ([[userDefaults objectForKey:@"role"]isEqualToString:@"admin"]) {
//                         [userDefaults setObject:cancelAllDataArray forKey:@"AdminWagecanceldataArray"];
//                     }else
//                     {
//                         NSLog(@"%@",cancelAllDataArray);
//                         [userDefaults setObject:cancelAllDataArray forKey:@"NormalWagecanceldataArray"];
//
//                     }
                 }
//                 [userDefaults synchronize];
                 // 上划加载
                 self.tableview.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                     [self loadMoreData];
                 }];

             }
             [self.tableview reloadData];
             [self.tableview.mj_footer endRefreshing];
             [self.tableview.mj_header endRefreshing];
         }];
}
-(void)removeData
{
    [ivvjsonArray removeAllObjects];
    [cancelAllDataArray removeAllObjects];
    [descriptionArray removeAllObjects];
    [repairNumArray removeAllObjects];
    [parentclassArray removeAllObjects];
    [postTimeArray removeAllObjects];
}
-(void)loadMoreData
{
    ISshang = YES;

    pagenum += 10;
    startNum = [NSString stringWithFormat:@"%d",pagenum];
    [self Notassigned];
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
    if (self.cancelDelegates && [self.cancelDelegates respondsToSelector:@selector(PushVideoVCDidClicked:)]) {
        [self.cancelDelegates PushVideoVCDidClicked:VideoUrl];
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
    backGroundButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backGroundButton.frame =window.frame;
    backGroundButton.userInteractionEnabled =YES;
    backGroundButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [backGroundButton addTarget:self action:@selector(backGroundButtonDisMiss) forControlEvents:UIControlEventTouchUpInside];
    UIView *VoiceView = [[UIView alloc]initWithFrame:CGRectMake(0, window.frame.size.height - 200, WIDTH, 200)];
    VoiceView.backgroundColor = [UIColor whiteColor];
    leftVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 100, 20, 80, 30)];
    rightVoiceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 + 20, 20, 80, 30)];
    leftVoiceImageView.userInteractionEnabled =YES;
    rightVoiceImageView.userInteractionEnabled =YES;
    VoiceTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 - 20, 20, 40, 30)];
    VoiceTimeLable.backgroundColor = [UIColor clearColor];
    VoiceTimeLable.textAlignment = NSTextAlignmentCenter;
    VoiceTimeLable.textColor = gycolor;
    VoiceTimeLable.text = [NSString stringWithFormat:@"%@s",voiceTimeStr];
    
    
    PlayVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    PlayVoiceButton.frame = CGRectMake(WIDTH/2 - 50, 60, 100, 100);
    [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];
    PlayVoiceButton.userInteractionEnabled = YES;
    VoiceView.userInteractionEnabled = YES;
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
                   //将数据保存到本地指定位置
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSString *filePath = [NSString stringWithFormat:@"/%@.mp3",[formater stringFromDate:[NSDate date]]];
        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];

        [self downloadFileURL:VoiceUrl savePath:docDirPath fileName:filePath];
        
        thetimes = [voiceTimeStr intValue];
        ImageChange = ([voiceTimeStr intValue]) * 2;
    
        [PlayVoiceButton setBackgroundImage:[UIImage imageNamed:@"mlgj-2x89"] forState:UIControlStateNormal];

        
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
//        GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
//        if(!connect.connectedToNetwork)
//        {
//            [GJSVProgressHUD showErrorWithStatus:@"网络故障,请检查您的网络!"];
//        }else
//        {
        NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:VoiceUrl]];
        [audioData writeToFile:fileName atomically:YES];
        [userDefaults setObject:fileName forKey:aUrl];
        [userDefaults synchronize];
        [self.audioPlayer playURL:[NSURL fileURLWithPath:fileName]];
//        }
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
    if (self.cancelDelegates && [self.cancelDelegates respondsToSelector:@selector(pushImagebrowserDidClicked:imageTag:)]) {
        [self.cancelDelegates pushImagebrowserDidClicked:imagemutableArray imageTag:sender.tag - 4000];
    }

    else
    {
        NSLog(@"协议方案未实现");
    }
}
-(void)voiceDisMiss:(UIButton *)sender
{
    [sender removeFromSuperview];
    time = 0;
}


@end
