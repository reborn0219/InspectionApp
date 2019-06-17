//
//  PPOrderDetailView.m
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPOrderDetailView.h"
#import "GJSTKAudioPlayer.h"
#import "PPViewTool.h"

@interface PPOrderDetailView()
@property (weak, nonatomic) IBOutlet UIImageView *videoBtnImgV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UIButton *stateView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *namephoneLb;
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UILabel *markLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_4;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (nonatomic,strong) NSMutableArray * imgArr;
@property (nonatomic,assign) NSInteger imgIndex;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIView *rideoShowView;
@property (weak, nonatomic) IBOutlet UIImageView *rideoTopImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rideoTopImgV_w;
@property (weak, nonatomic) IBOutlet UIImageView *rideoBottomImgV;
@property (weak, nonatomic) IBOutlet UILabel *nohaveimgLb;
@property (weak, nonatomic) IBOutlet UILabel *nohaveVideoLb;
@property (weak, nonatomic) IBOutlet UILabel *nohaveVoiceLb;
@property (nonatomic,strong) NSTimer *speedTimer;

@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (nonatomic, strong)PPOrdersDetailsModel  *models;

@end

@implementation PPOrderDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    _shadowView.layer.cornerRadius = 5;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _models = [[PPOrdersDetailsModel alloc]init];
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    
    
    _shadowView.layer.shadowRadius = 2;
    
    
    [_rideoShowView.layer insertSublayer:[PPViewTool setGradualChangingColor:_rideoShowView withFrame:CGRectMake(0, 0, KScreenWigth-60,40) withCornerRadius:8] atIndex:0];
    self.rideoTopImgV.clipsToBounds = YES;
    self.rideoTopImgV.contentMode = UIViewContentModeLeft;
    
    self.rideoBottomImgV.clipsToBounds = YES;
    self.rideoBottomImgV.contentMode = UIViewContentModeRight;
    _imgIndex = 0;
    _imgArr = [NSMutableArray arrayWithCapacity:0];
    _imgView_1.tag = 100;
    _imgView_2.tag = 101;
    _imgView_3.tag = 102;
    _imgView_4.tag = 103;
    [_imgArr addObject:_imgView_1];
    [_imgArr addObject:_imgView_2];
    [_imgArr addObject:_imgView_3];
    [_imgArr addObject:_imgView_4];
    
    for (UIImageView *temImgV in _imgArr) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchUp:)];
        [temImgV addGestureRecognizer:tap];
        temImgV.userInteractionEnabled = YES;
    }
}
- (void)imgTouchUp:(UIGestureRecognizer *)sender
{
    UIView *imgV = sender.view;
    if (_block) {
         _block(_models,nil,imgV.tag - 100);
    }

}
- (IBAction)playVoiceAction:(id)sender {
    _rideoTopImgV_w.constant = 0;
    [self startTimer];
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    [self.audioPlayer playURL:[NSURL URLWithString:_models.audio_url]];
}
#pragma mark - 语音定时器开始
- (void)startTimer
{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_models.audio_length.integerValue>0) {
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_models.audio_length.integerValue;
    }else{
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_models.audio_length.integerValue;
    }
    if (_rideoTopImgV_w.constant >= (SCREEN_WIDTH - 100.0)) {
        _rideoTopImgV_w.constant = SCREEN_WIDTH - 100.0;
        [_speedTimer invalidate];
    }
}
- (IBAction)playVideoAction:(id)sender {
    if (_block) {
        _block(_models,nil,1000);
    }
}

-(void)assignmentWithModel:(PPOrdersDetailsModel *)model
{
    _models = model;
    [_nohaveVoiceLb setHidden:YES];
    [_nohaveimgLb setHidden:YES];
    [_nohaveVideoLb setHidden:YES];
//    _imgIndex = model.patrolled_count.integerValue?:0;
    _titleLb.text = model.community_name;
    _orderNo.text = model.community_position;
    _contentLb.text = model.patrol_result?:@"-";
    _markLb.text = model.remark?:@"-";
    if (model.patrol_user_name!=nil&&model.patrol_user_phone!=nil) {
        _namephoneLb.text = [NSString stringWithFormat:@"%@   %@",model.patrol_user_name,model.patrol_user_phone];

    }else{
        _namephoneLb.text = @"-   -";

    }
    _cycleLb.text = [NSString stringWithFormat:@"%@/%@次巡逻",model.patrolled_count?:@"0",model.patrol_count];
    if (model.patrol_date) {
        if (model.patrol_date.length>16) {
            _timeLb.text = [model.patrol_date substringToIndex:16]?:@"-";
        }else{
            _timeLb.text = @"-";
        }
    }
    
//    _timeLb.text = [PPDateTool stringFormat:model.patrol_date];
    if (model.work_sheet_status.integerValue == 6) {
        [_stateBtn setBackgroundColor:UN_OPTION_COLOR];
        [_stateBtn setTitle:@"未巡逻" forState:(UIControlStateNormal)];
    }else{
       [_stateBtn setTitle:@"已巡逻" forState:(UIControlStateNormal)];
       [_stateBtn setBackgroundColor:OVER_COLOR];
    }
    if (model.picture_list.count>0) {
        for (int i = 0; i < model.picture_list.count; i++) {
            UIImageView *imageV = _imgArr[i];
            PPSubmitOrdersPicture_list *picture = model.picture_list[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:picture.pic_url]];
        }
    }else{
        [_nohaveimgLb setHidden:NO];
        for (int i =0; i<_imgArr.count; i++) {
            UIImageView * imgV = [_imgArr objectAtIndex:i];
            [imgV setUserInteractionEnabled:NO];
        }
    }
    if (model.video_list.count>0) {
        
        PPSubmitOrdersVedio_list *vedioModel = model.video_list.firstObject;
        [_videoBtnImgV sd_setImageWithURL:[NSURL URLWithString:vedioModel.thumb_url]];
        [_videoBtn setImage:[UIImage imageNamed:@"rideo_play"] forState:UIControlStateNormal];
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [_nohaveVideoLb setHidden:NO];
    }
    
    if (model.audio_url==nil||model.audio_url.length==0) {
        [_rideoShowView setHidden:YES];
        [_nohaveVoiceLb setHidden:NO];
        
    }else{
        [_playBtn setTitle:model.audio_length forState:UIControlStateNormal];
        [_playBtn layoutButtonWithImageTitleSpace:2];
        [_rideoShowView setHidden:NO];
    }
    
 
   
}
@end
