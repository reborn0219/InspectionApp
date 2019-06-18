//
//  PSWODetailsVoiceCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsVoiceCell.h"
@interface PSWODetailsVoiceCell()
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIImageView *voiceBottomImageV;
@property (weak, nonatomic) IBOutlet UIImageView *voiceTopImageV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *rideoShowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rideoTopImgW;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property (nonatomic,copy) NSString *voice;
@property (nonatomic,copy) NSString *voice_time;
@property (nonatomic,strong) NSTimer *speedTimer;

@end
@implementation PSWODetailsVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _rideoTopImgW.constant = 0;
    [_rideoShowView.layer insertSublayer:[PPViewTool setGradualChangingColor:_rideoShowView withFrame:CGRectMake(0, 0, KScreenWigth-60,50) withCornerRadius:8] atIndex:0];

}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel
{
    if (cellModel) {
        NSDictionary *dic = cellModel.ivv_json.voice[0];
        _voice_time = [dic objectForKey:@"voice_time"];
        _voice = [dic objectForKey:@"voice"];
        [self.playBtn setTitle:_voice_time forState:UIControlStateNormal];
        [self.playBtn layoutButtonWithImageTitleSpace:2];
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)playBtnAction:(id)sender {
    _rideoTopImgW.constant = 0;
    [self startTimer];
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    [self.audioPlayer playURL:[NSURL URLWithString:_voice]];
}
-(void)startTimer{
        self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_voice_time.integerValue>0) {
        _rideoTopImgW.constant += (SCREEN_WIDTH - 60.0)/_voice_time.integerValue;
    }else{
        _rideoTopImgW.constant += (SCREEN_WIDTH - 60.0)/_voice_time.integerValue;
    }
    if (_rideoTopImgW.constant >= (SCREEN_WIDTH - 60.0)) {
        _rideoTopImgW.constant = SCREEN_WIDTH - 60.0;
        [_speedTimer invalidate];
    }
}
@end
