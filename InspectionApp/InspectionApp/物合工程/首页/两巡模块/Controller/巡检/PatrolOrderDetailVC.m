//
//  PatrolOrderDetailVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolOrderDetailVC.h"
#import "PPViewTool.h"
#import "PatrolFormCell.h"
#import "PatrolTaskMapVC.h"
#import "PatrolChangeRepairVC.h"
#import "PPInspectDeviceModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "PPGuaranteeModel.h"
#import "ShowImageVC.h"
#import "PPLocationMapVC.h"


@interface PatrolOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backView_top;
@property (weak, nonatomic) IBOutlet UILabel *markLb;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceNoLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceAdressLb;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *deviceToMapBtn;
@property (weak, nonatomic) IBOutlet UIView *orderTopView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *menberDetailView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UIButton *changeRepairBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *state_btn_w;
@property (weak, nonatomic) IBOutlet UILabel *inspectnameLb;
@property (weak, nonatomic) IBOutlet UILabel *inspectphoneLb;
@property (weak, nonatomic) IBOutlet UILabel *inspecttimeLb;
@property (weak, nonatomic) IBOutlet UIImageView *img_1;
@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UIImageView *img_3;
@property (weak, nonatomic) IBOutlet UIImageView *img_4;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *videoimgV;
@property (weak, nonatomic) IBOutlet UIImageView *videoTopImgV;
@property (weak, nonatomic) IBOutlet UIImageView *vodeoBottomImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *video_top_w;
@property (weak, nonatomic) IBOutlet UILabel *novoiceLb;
@property (weak, nonatomic) IBOutlet UILabel *noVideoLb;
@property (weak, nonatomic) IBOutlet UILabel *noimgLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_h;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) PPInspectDeviceModel *controlerModel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) NSTimer *speedTimer;
@property (nonatomic, strong) ShowImageVC  *showImageVC;
@property (weak, nonatomic) IBOutlet UILabel *xjcycleLb;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *change_repair_h;
@property (weak, nonatomic) IBOutlet UIView *changeRepairView;

@end

@implementation PatrolOrderDetailVC

-(void)assignmentWithModel:(PPInspectDeviceModel *)model{
    
    _deviceNameLb.text = model.device_name;
    _deviceNoLb.text = model.device_no;
    _deviceAdressLb.text = [NSString stringWithFormat:@"%@",model.device_position];
    _inspectnameLb.text = model.inspect_user_name;
    _inspectphoneLb.text = model.inspect_user_phone;
    _inspecttimeLb.text = model.inspect_time;
    _xjcycleLb.text = [NSString stringWithFormat:@"%@/%@次巡查",model.inspected_count,model.inspect_count];
    if (model.work_sheet_status.integerValue==2) {
        [_stateBtn setTitle:@"正常" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:OPTIONING_COLOR];
        _state_btn_w.constant = 32;
//        _stateBtn.hidden = YES;
         [_changeRepairBtn setHidden:YES];
        _change_repair_h.constant = 0;
    }else  if (model.work_sheet_status.integerValue==3 ) {
        [_changeRepairBtn setHidden:NO];
        [_stateBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:UN_START_COLOR];
         _state_btn_w.constant = 32;
        
        [_changeRepairBtn setEnabled:YES];
        [_changeRepairBtn setBackgroundColor:[UIColor clearColor]];
        [_changeRepairBtn setTitle:@"转报修" forState:(UIControlStateNormal)];

    }else if (model.work_sheet_status.integerValue== 4) {
        [_changeRepairBtn setHidden:NO];
        [_stateBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:UN_START_COLOR];
        _state_btn_w.constant = 32;
        [_changeRepairBtn setBackgroundColor:[UIColor colorWithRed:202.0/255 green:202.0/255 blue:202.0/255 alpha:1]];
        [_changeRepairBtn setTitle:@"已报修" forState:(UIControlStateNormal)];
        _state_btn_w.constant = 40;
        [_changeRepairBtn setEnabled:NO];
        
    }else  if (model.work_sheet_status.integerValue==1) {
        [_stateBtn setTitle:@"未巡查" forState:UIControlStateNormal];
        _state_btn_w.constant = 40;
        [_stateBtn setBackgroundColor:UN_OPTION_COLOR];
//        _stateBtn.hidden = YES;
        _inspecttimeLb.hidden = YES;
        [_changeRepairBtn setHidden:YES];
        _change_repair_h.constant = 0;

    }
   
    for (int i =0; i<4; i++) {
        
        if (model.picture_list.count>0) {
            if (i<model.picture_list.count) {
                PPInspectDeviceModelPicture_list * picModel = [model.picture_list objectAtIndex:i];
                UIImageView * imgV =   [_imgArr objectAtIndex:i];
                [imgV sd_setImageWithURL:[NSURL URLWithString:picModel.pic_url]];
            }
        }else{
            [_noimgLb setHidden:NO];
            for (int i =0; i<_imgArr.count; i++) {
                UIImageView * imgV = [_imgArr objectAtIndex:i];
                [imgV setUserInteractionEnabled:NO];
            }
        }
    }
    if (model.video_list.count>0) {
        PPInspectDeviceModelVideo_list * videoModel = [model.video_list firstObject];
        [_videoimgV sd_setImageWithURL:[NSURL URLWithString:videoModel.img_url]];
    }else{
        [_videoimgV setHidden:YES];
        [_videoBtn setHidden:YES];
        [_noVideoLb setHidden:NO];

    }
    _markLb.text = _controlerModel.remark?:@"";
    
    if (_controlerModel.audio_second==nil||_controlerModel.audio_second.length==0) {
        [_voiceView setHidden:YES];
        [_novoiceLb setHidden:NO];
        
    }else{
        [_novoiceLb setHidden:YES];
        [_playBtn setTitle:_controlerModel.audio_second forState:UIControlStateNormal];
        [_playBtn layoutButtonWithImageTitleSpace:2];
        [_voiceView setHidden:NO];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    _backView_top.constant = NavBar_H;
    _imgArr = [NSMutableArray array];
    [_imgArr addObject:_img_1];
    [_imgArr addObject:_img_2];
    [_imgArr addObject:_img_3];
    [_imgArr addObject:_img_4];
    
    _img_1.tag = 100;
    _img_2.tag = 101;
    _img_3.tag = 102;
    _img_4.tag = 103;
    
    for (UIImageView *temImgV in _imgArr) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchUpS:)];
        [temImgV addGestureRecognizer:tap];
        temImgV.userInteractionEnabled = YES;
    }
    
    [_voiceView.layer insertSublayer:[PPViewTool setGradualChangingColor:_voiceView withFrame:CGRectMake(0, 0, KScreenWigth-62, 40) withCornerRadius:8] above:0];
    [_changeRepairView.layer insertSublayer:[PPViewTool setGradualChangingColor:_changeRepairView withFrame:CGRectMake(0, 0, KScreenWigth, 48) withCornerRadius:0] above:0];

    self.videoTopImgV.clipsToBounds = YES;
    self.videoTopImgV.contentMode = UIViewContentModeLeft;
    self.vodeoBottomImgV.clipsToBounds = YES;
    [_videoTopImgV setHidden:NO];
    self.vodeoBottomImgV.contentMode = UIViewContentModeRight;
  
  
    _shadowView.layer.cornerRadius = 5;
    _menberDetailView.layer.cornerRadius = 5;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
    
//    _tableView.layer.shadowColor = SHADOW_COLOR.CGColor;
//    _tableView.layer.shadowOffset = CGSizeMake(0,0);
//    _tableView.layer.shadowOpacity = 0.2;
//    _tableView.layer.shadowRadius = 2;
//
//    _photoView.layer.shadowColor = SHADOW_COLOR.CGColor;
//    _photoView.layer.shadowOffset = CGSizeMake(0,0);
//    _photoView.layer.shadowOpacity = 0.2;
//    _photoView.layer.shadowRadius = 2;
//
//    _markView.layer.shadowColor = SHADOW_COLOR.CGColor;
//    _markView.layer.shadowOffset = CGSizeMake(0,0);
//    _markView.layer.shadowOpacity = 0.2;
//    _markView.layer.shadowRadius = 2;
    
    _orderTopView.layer.cornerRadius = 8;
    
    _deviceToMapBtn.layer.cornerRadius = 10;
    _stateBtn.layer.cornerRadius = 8;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"PatrolFormCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolFormCell"];
    _tableView.estimatedRowHeight=44;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight=UITableViewAutomaticDimension;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(void)imgTouchUpS:(UIGestureRecognizer *)sender
{
      UIView *imgV = sender.view;
    if (_controlerModel.picture_list.count == 0) {
        imgV.userInteractionEnabled = NO;
    }else{
        self.showImageVC = [[ShowImageVC alloc]init];
        self.showImageVC.block = ^(NSInteger index) {
            
        };
        NSMutableArray *urlArr = [NSMutableArray array];
        for (PPInspectDeviceModelPicture_list *picture in _controlerModel.picture_list) {
            [urlArr addObject:picture.pic_url];
        }
        [self.showImageVC setImageWithImageArray:urlArr withIndex:imgV.tag - 100];
        [self presentViewController:self.showImageVC animated:NO completion:nil];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"巡查设备详情"];
    
    [self requestData];
    
}
-(void)requestData{
    MJWeakSelf
    [PatrolHttpRequest inspectdevicedetail:@{@"device_id":weakSelf.device_id,@"work_id":weakSelf.work_id,@"work_sheet_id":weakSelf.work_sheet_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * obj = data;
            NSArray *work_sheet_list = [obj objectForKey:@"work_sheet_list"];
            if (work_sheet_list.count>0) {
                weakSelf.controlerModel = [PPInspectDeviceModel yy_modelWithJSON:work_sheet_list.firstObject];
                [weakSelf assignmentWithModel:weakSelf.controlerModel];
                [weakSelf.tableView reloadData];
                weakSelf.tableview_h.constant = weakSelf.tableView.contentSize.height;
            }
          
        }else{
            [weakSelf.backView setHidden:YES];
        }
        
    }];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
    
}
#pragma mark - actions

- (IBAction)playVideoAction:(id)sender {
    
    if (_controlerModel.video_list.count>0) {
        PPInspectDeviceModelVideo_list * videoModel = [_controlerModel.video_list firstObject];
        GJZXVideo *video = [[GJZXVideo alloc] init];
        video.playUrl = videoModel.video_url;
        GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
        vc.video = video;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

}
- (IBAction)playVoiceAction:(id)sender {
    _video_top_w.constant=0;
    [self startTimer];
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    [self.audioPlayer playURL:[NSURL URLWithString:_controlerModel.audio_rul]];

}
#pragma mark - 语音定时器开始
- (void)startTimer
{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_controlerModel.audio_second.integerValue>0) {
        _video_top_w.constant += (SCREEN_WIDTH - 100.0)/_controlerModel.audio_second.integerValue;
    }
    if (_video_top_w.constant >= (SCREEN_WIDTH - 100.0)) {
        _video_top_w.constant = SCREEN_WIDTH - 100.0;
        [_speedTimer invalidate];
    }
}
- (IBAction)changeRepairAction:(id)sender {
    
    
    MJWeakSelf
    //转报修
    [PatrolHttpRequest selectguarantee:@{@"work_sheet_id":_controlerModel.work_sheet_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            
//            [GJMBProgressHUD showSuccess:@"转报修成功！"];
           
                NSDictionary *obj = data;
                GuaranteeListModel * listModel = [GuaranteeListModel yy_modelWithJSON:obj];
                
                PatrolChangeRepairVC * pcrVC = [[PatrolChangeRepairVC alloc]init];
                pcrVC.controlerModel = weakSelf.controlerModel;
                pcrVC.guaranteeModel = listModel;
                [self.navigationController pushViewController:pcrVC animated:YES];
           
        }else{
            [GJMBProgressHUD showError:@"转报修失败！"];
        }
    }];
  
}

- (IBAction)DeviceToMapAction:(id)sender {
    
    //设备位置

    PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(_controlerModel.latitude.doubleValue,_controlerModel.longitude.doubleValue);
//    pointAnnotation.annotation_status = _controlerModel.work_sheet_status;
    pointAnnotation.annotation_status = @"1";
    if (_controlerModel.work_sheet_status.integerValue==1) {
        pointAnnotation.annotation_status = @"2";
    }else if (_controlerModel.work_sheet_status.integerValue==2) {
        pointAnnotation.annotation_status = @"3";
    }else if (_controlerModel.work_sheet_status.integerValue==3) {
        pointAnnotation.annotation_status = @"1";
    }
    pointAnnotation.annotation_name = _controlerModel.device_name;
    PPLocationMapVC * mapVC = [[PPLocationMapVC alloc]init];
    mapVC.annotionModel = pointAnnotation;
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _controlerModel.project_list.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        PatrolFormCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolFormCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView setBackgroundColor:HexRGB(0xE8E8E8)];

        return cell;
    }else{
        
        PPInspectDeviceModelProject_list * model = [_controlerModel.project_list objectAtIndex:indexPath.row-1];
        PatrolFormCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolFormCell"];
        if (indexPath.row%2==0) {
            [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell.contentView setBackgroundColor:HexRGB(0xECECEC)];
        }
        [cell assignmentWithModel:model isSubmit:NO];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
