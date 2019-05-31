//
//  PatrolChangeRepairVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolChangeRepairVC.h"
#import "PPViewTool.h"
#import "PatrolRepairLabelCell.h"
#import "PatrolTaskMapVC.h"
#import "PPInspectDeviceModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "GuaranteeListModel.h"
#import "SubmitSucceedVC.h"
#import "GJCommunityModel.h"

@interface PatrolChangeRepairVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * leftArr;
    NSArray *modelArr;
}
@property (weak, nonatomic) IBOutlet UITextView *marTextView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UIImageView *img_1;
@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UIImageView *img_3;
@property (weak, nonatomic) IBOutlet UIImageView *img_4;
@property (weak, nonatomic) IBOutlet UIImageView *videoimgV;
@property (weak, nonatomic) IBOutlet UIImageView *videoTopImgV;
@property (weak, nonatomic) IBOutlet UIImageView *vodeoBottomImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *video_top_w;
@property (weak, nonatomic) IBOutlet UILabel *novoiceLb;
@property (weak, nonatomic) IBOutlet UILabel *noVideoLb;
@property (weak, nonatomic) IBOutlet UILabel *noimgLb;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *orderTopView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *changeRepairBtn;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backView_top;
@property (nonatomic,strong) NSTimer *speedTimer;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@end

@implementation PatrolChangeRepairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
-(void)assignmentWithModel:(PPInspectDeviceModel *)model{
   
    for (int i =0; i<4; i++) {
        
        if (model.picture_list.count>0) {
            if (i<model.picture_list.count) {
                PPInspectDeviceModelPicture_list * picModel = [model.picture_list objectAtIndex:i];
                UIImageView * imgV =   [_imgArr objectAtIndex:i];
                [imgV sd_setImageWithURL:[NSURL URLWithString:picModel.pic_url]];
            }
        }else{
            [_noimgLb setHidden:NO];
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
    if (model.audio_second.integerValue != 0) {
        [_videoBtn setTitle:model.audio_second forState:UIControlStateNormal];
        [_videoBtn layoutButtonWithImageTitleSpace:2];
        [_voiceView setHidden:NO];
        [_novoiceLb setHidden:YES];
    }else{
        [_novoiceLb setHidden:NO];
    }
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
    _video_top_w.constant = 0;
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
    }else{
        _video_top_w.constant += (SCREEN_WIDTH - 100.0)/_controlerModel.audio_second.integerValue;
    }
    if (_video_top_w.constant >= (SCREEN_WIDTH - 100.0)) {
        _video_top_w.constant = SCREEN_WIDTH - 100.0;
        [_speedTimer invalidate];
    }
}
- (IBAction)ChangeRepairBtnAction:(id)sender {
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
        //return;
    }
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *property_ids = model.property_id;//物业公司ID
    NSString *NowcommunitIDs = model.community_id;//小区ID
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"community_id"] = @(NowcommunitIDs.integerValue);
    params[@"property_id"] = @(property_ids.integerValue);
    NSMutableArray *images = [NSMutableArray array];
    for ( PPInspectDeviceModelPicture_list * picModel in _controlerModel.picture_list) {
        NSString * imgUrl = picModel.pic_url;
        NSDictionary * dic = @{@"images":imgUrl};
        [images addObject:dic];
    }
    params[@"images"] = images;
    
    NSMutableArray *video = [NSMutableArray array];
    for ( PPInspectDeviceModelVideo_list * picModel in _controlerModel.video_list) {
        NSDictionary * dic = @{@"video":picModel.video_url,@"video_img":picModel.img_url,@"video_img_icon":@""};
        [video addObject:dic];
    }
    params[@"video"] = video;
    params[@"voice"] = @[_controlerModel.audio_rul?:@""];
    params[@"is_self"] = @"Y";
    params[@"is_help"] = @"N";
    params[@"position"] = _guaranteeModel.repair_location?:@"";
    params[@"sort_class"] = @(0);
    params[@"repair_time"] = _guaranteeModel.time_of_appointment?:@"";
    params[@"room_id"] = @(0);
    if (_marTextView.text==nil||_marTextView.text.length==0) {
        [GJMBProgressHUD showError:@"请填写备注信息"];
        return;
    }
    params[@"description"] = _marTextView.text;
    params[@"name"] =@(0);
    params[@"contact"] = _controlerModel.remark?:@"";
    params[@"serving_time"] = @"尽快";
    params[@"fac_id"] = @(0);
    params[@"voice_time"] = @(_controlerModel.audio_second.intValue);
    params[@"work_sheet_id"] = _controlerModel.work_sheet_id;
    
    MJWeakSelf
    ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
    [firmationVC showInVC:self withTitle:@"是否确认提交报修？"];
    firmationVC.block = ^(NSInteger index) {
        if (index) {
            //确定
            
            [PatrolHttpRequest memberrepair:params:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                if (resultCode == SucceedCode) {
                    SubmitSucceedVC *succeedVC = [[SubmitSucceedVC alloc]init];
                    [succeedVC showInVC:weakSelf];
                    succeedVC.block = ^(NSInteger index) {
                        
                        [weakSelf popControllerReverse:2];
                        
                    };
                    
                }else{
                    NSLog(@"%@",data);
                }
            }];
        }else{
            
            
            
            
        }
    };
    
  
    
  
    
}

-(void)creatUI{
    _backView_top.constant = NavBar_H;
    _imgArr = [NSMutableArray array];
    [_imgArr addObject:_img_1];
    [_imgArr addObject:_img_2];
    [_imgArr addObject:_img_3];
    [_imgArr addObject:_img_4];
    self.videoTopImgV.clipsToBounds = YES;
    self.videoTopImgV.contentMode = UIViewContentModeLeft;
    self.vodeoBottomImgV.clipsToBounds = YES;
    [_videoTopImgV setHidden:NO];
    leftArr = @[@"工单类型",@"代理商",@"服务位置",@"报修项目",@"预约人",@"电话号码",@"报修时间",@"预约时间"];
    modelArr =  @[_guaranteeModel.work_sheet_type?:@"",_guaranteeModel.agent?:@"",_guaranteeModel.repair_location?:@"",_guaranteeModel.item_name?:@"",_guaranteeModel.ture_name?:@"",_guaranteeModel.mobile_phone?:@"",_guaranteeModel.repair_datetime?:@"",_guaranteeModel.time_of_appointment?:@""];
    [_voiceView.layer insertSublayer:[PPViewTool setGradualChangingColor:_voiceView withFrame:CGRectMake(0, 0, KScreenWigth-62, 40) withCornerRadius:8] above:0];
    
    [_changeRepairBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_changeRepairBtn withFrame:CGRectMake(0, 0, KScreenWigth, 48) withCornerRadius:0] above:0];
    _shadowView.layer.cornerRadius = 5;
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
    [_tableView registerNib:[UINib nibWithNibName:@"PatrolRepairLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolRepairLabelCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"报修"];
    [self assignmentWithModel:_controlerModel];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}
#pragma mark - actions
#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        return 40;
    }
    return 30;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return leftArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PatrolRepairLabelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolRepairLabelCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLb.text = leftArr[indexPath.row];
    cell.rightLb.text = modelArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
