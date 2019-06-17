//
//  PSWOHeaderVoiceCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHeaderVoiceCell.h"
#import "NewOrderModelIvv_json.h"

@interface PSWOHeaderVoiceCell()
@property (weak, nonatomic) IBOutlet UIImageView *voiceBottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *voiceTopImage;
@property (weak, nonatomic) IBOutlet UIButton *voiceBTN;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *memberLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomeViewHeight;
@property (nonatomic,strong) NSTimer *speedTimer;
@property (nonatomic,copy) NSString *voice;
@property (nonatomic,copy) NSString *voice_time;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *rideoShowView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImg_W;

@end
@implementation PSWOHeaderVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
    _topImg_W.constant = 0;
    [_rideoShowView.layer insertSublayer:[PPViewTool setGradualChangingColor:_rideoShowView withFrame:CGRectMake(0, 0, KScreenWigth-60,50) withCornerRadius:8] atIndex:0];
    //    _memberLab.hidden =YES;
    //    _timeLabel.hidden = YES;
    //    _grabBtn.hidden = YES;
    //    _markBtn.hidden = YES;
}

-(void)assignmentWithModel:(WorkOrderListModel *)cellModel
{
    [super assignmentWithModel:cellModel];
    _orderNoLab.text = cellModel.repair_no;
    _stateLab.text =cellModel.repair_time;
    _memberLab.text =cellModel.repair_master_name;
    _timeLab.text = cellModel.post_time;
    if (cellModel.ivv_json.voice.count) {
        NSDictionary *dic = cellModel.ivv_json.voice[0];
        _voice_time = [dic objectForKey:@"voice_time"];
        _voice = [dic objectForKey:@"voice"];
        [self.voiceBTN setTitle:_voice_time forState:UIControlStateNormal];
        [self.voiceBTN layoutButtonWithImageTitleSpace:2];
    }
    if ([cellModel.repair_status isEqualToString:@"未处理"]) {
        //3视频，2语音，1图片，0文字
        self.memberLab.hidden = YES;
        self.timeLab.hidden = YES;
        if ([UserManager iscaptain].integerValue == 1) {
            //队长
            [self.grabBtn setTitle:@"分配工单" forState:(UIControlStateNormal)];
        }else{
            self.markBtn.hidden = YES;
            [self.grabBtn setTitle:@"抢单" forState:(UIControlStateNormal)];
        }
    }else if ([cellModel.repair_status isEqualToString:@"待处理"]){
        self.memberLab.hidden = YES;
        self.timeLab.hidden = YES;
        if ([UserManager iscaptain].integerValue == 1) {
            //队长
            [self.grabBtn setTitle:@"转移工单" forState:(UIControlStateNormal)];
        }else{
            //队员
            [self.grabBtn setTitle:@"处理工单" forState:(UIControlStateNormal)];
        }
    }else if ([cellModel.repair_status isEqualToString:@"处理中"]){
        //处理中
        self.markBtn.hidden = YES;
        self.grabBtn.hidden = YES;
        self.stateLab.hidden = YES;
        self.timeLab.hidden = NO;
        self.memberLab.hidden = NO;
    }else{
        //已处理/已完成
        self.bottomView.hidden = YES;
        self.bottomeViewHeight.constant  = 0;
    }
    
}
- (IBAction)distributeWorkOrderAction:(id)sender {
    WorkOrderListModel *model = (WorkOrderListModel *)super.cellModel;
    if (super.block) {
        if ([model.repair_status isEqualToString:@"未处理"]) {
            if ([UserManager iscaptain].integerValue == 1) {
                super.block(super.cellModel,WorkOrderAlertDistribute);
            }else{
                super.block(super.cellModel,WorkOrderAlertGrab);
                self.markBtn.hidden = YES;
            }
        }else if ([model.repair_status isEqualToString:@"待处理"]) {
            if ([UserManager iscaptain].integerValue == 1) {
                super.block(super.cellModel,WorkOrderAlertTranform);
            }else{
                //处理工单
                super.block(super.cellModel,WorkOrderAlertHandle);
            }
        }
    }
}
- (IBAction)markAction:(id)sender {
    if (super.block) {
        super.block(super.cellModel,WorkOrderAlertMarkInvalid);
    }
}

- (IBAction)playVoiceAction:(id)sender {
    _topImg_W.constant = 0;
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    [self.audioPlayer playURL:[NSURL URLWithString:_voice]];
    [self startTimer];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)startTimer{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_voice_time.integerValue>0) {
        _topImg_W.constant += (SCREEN_WIDTH - 60.0)/_voice_time.integerValue;
    }else{
        _topImg_W.constant += (SCREEN_WIDTH - 60.0)/_voice_time.integerValue;
    }
    if (_topImg_W.constant >= (SCREEN_WIDTH - 60.0)) {
        _topImg_W.constant = SCREEN_WIDTH - 60.0;
        [_speedTimer invalidate];
    }
}
@end
