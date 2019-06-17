//
//  PSWorkOrderViewController.m
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWorkOrderViewController.h"
#import "PSShowWorkOrderVC.h"
#import "PSWorkOrderListVC.h"
#import "PSWODetailsDistributeVC.h"
#import "PSTranformWorkOrderVC.h"
#import "SecurityRequest.h"
#import "NewOrderModel.h"
@interface PSWorkOrderViewController ()<AVSpeechSynthesizerDelegate>
{
    UIViewController *currentVC;
    PSWorkOrderListVC *workOrderListVC;
    
}
@property (nonatomic,strong) NSMutableArray *voiceList;
@property (nonatomic,strong) AVSpeechSynthesizer *avSythesizer;
@property (nonatomic,assign) NSInteger currentOrder;
@property (nonatomic,strong) PSShowWorkOrderVC *workOrderVC;
@property (nonatomic,strong) AVSpeechUtterance *speechUtrence;
@property (nonatomic, strong)PSWODetailsDistributeVC  *distributeVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelHeight;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *listenImageV;
@property (weak, nonatomic) IBOutlet UIButton *workBtn;
@property (nonatomic,strong) NSTimer *voiceTimer;


@end

@implementation PSWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.distributeVC = [[PSWODetailsDistributeVC alloc]init];
    
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserManager order_starts]) {
        [self startVoiceTimer];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_avSythesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self stopVoiceTimer];

}
-(AVSpeechSynthesizer*)avSythesizer{
    if (!_avSythesizer) {
        _avSythesizer = [[AVSpeechSynthesizer alloc]init];
        _avSythesizer.delegate = self;
    }
    return _avSythesizer;
}

-(NSTimer *)voiceTimer{
    if (!_voiceTimer) {
        _voiceTimer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(voiceListenAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_voiceTimer forMode:NSRunLoopCommonModes];
    }
    return _voiceTimer;
}
-(void)requestData{
    [self stopVoiceTimer];
    _currentOrder = 0;
    MJWeakSelf
    [SecurityRequest get_news_order2:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSLog(@"%@",data);
            [weakSelf.voiceList removeAllObjects];
            NSArray * modelArr = [NSArray yy_modelArrayWithClass:[NewOrderModel class] json:data];
            [weakSelf.voiceList addObjectsFromArray:modelArr];
            if (modelArr.count) {
                NewOrderModel * model = weakSelf.voiceList.firstObject;
                [weakSelf stringToVoice:model.voice_txt];
                
                weakSelf.workOrderVC.block = ^(id  _Nullable data, NSInteger index) {
                    if (index == WorkOrderAlertDistribute) {
                                    //队长-----派单
                            [self.distributeVC showInVC:weakSelf];
                        weakSelf.distributeVC.block = ^(id  _Nullable data, WorkAlertType type) {
                            NSDictionary *dict = data;
                            [weakSelf requestDistributeWorkOrder:model.value Remarks:[dict objectForKey:@"remarks"] Repair_user_id:[dict objectForKey:@"repair_user_id"]];
                        };
                    
                    }else if (index == WorkOrderAlertGrab) {
                     //队员------抢单
                        [weakSelf requestGrabWorkOrders:model.value];
                    }else if (index == WorkOrderAlertNext) {
                        //下一条
                        [weakSelf.avSythesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];

                        NewOrderModel * model;
                        weakSelf.currentOrder ++;
                        if (weakSelf.currentOrder<weakSelf.voiceList.count) {
                            model = [weakSelf.voiceList objectAtIndex:weakSelf.currentOrder];
                        }else{
                            weakSelf.currentOrder=0;
                            model = weakSelf.voiceList.firstObject;
                        }
                        [weakSelf stringToVoice:model.voice_txt];
                        weakSelf.workOrderVC.controllerModel = model;
                        [weakSelf.workOrderVC nextOrder];
                        
                    }else if (index == WorkOrderAlertQuiet) {
                        //静音
                        [weakSelf stopVoiceTimer];
                        
                    }
                };
                [weakSelf.workOrderVC showInVC:weakSelf withModel:model];
            }else{
                [weakSelf startVoiceTimer];
            }
           
            
        }
    }];
    
}

- (void)createUI
{
    self.workOrderVC = [[PSShowWorkOrderVC alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    self.firstLabelHeight.constant = 0;
    self.stateLabel.layer.cornerRadius = 32.0f;
    self.stateLabel.layer.masksToBounds = YES;
    self.workBtn.layer.cornerRadius = 20.0f;
    self.workBtn.layer.masksToBounds = YES;
    _voiceList = [NSMutableArray array];
    [self listenImageAnimation];
}
- (void)listenImageAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.duration = 1.0f;
    //旋转效果累计，先旋转180度，接着再旋转180度，从而实现360度
    animation.cumulative = YES;
    animation.repeatCount = FLT_MAX;
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRect = CGRectMake(0, 0, self.listenImageV.frame.size.width, self.listenImageV.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [self.listenImageV.image drawInRect:CGRectMake(1, 1, self.listenImageV.frame.size.width - 2, self.listenImageV.frame.size.height - 2)];
    self.listenImageV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //围绕Z轴旋转，垂直于屏幕
    self.listenImageV.transform = CGAffineTransformRotate(self.listenImageV.transform,M_2_PI);
    [self.listenImageV.layer addAnimation:animation forKey:nil];
}
- (IBAction)starWorkAction:(id)sender {
    UIButton *btn = sender;
    if (btn.isSelected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"shouGong_green"] forState:(UIControlStateNormal)];
        [self listenImageAnimation];
        btn.selected = NO;
        self.stateLabel.text = @"听单中";
        [self startVoiceTimer];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"shouGong_gray"] forState:(UIControlStateNormal)];
        btn.selected = YES;
        self.stateLabel.text = @"准备中";
        [self.listenImageV.layer removeAllAnimations];
        [self stopVoiceTimer];
        
    }
}
- (void)requestGrabWorkOrders:(NSString *)repair_id
{
    MJWeakSelf
    [SecurityRequest grab:repair_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.workOrderVC dismissViewControllerAnimated:YES completion:nil];
        }
        }];
    }
- (void)requestDistributeWorkOrder:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id
{
    MJWeakSelf
    [SecurityRequest fen_pei:repair_id Remarks:remarks Repair_user_id:repair_user_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.distributeVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}
-(void)stringToVoice:(NSString*)voiceTest{
    MJWeakSelf
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
     
            weakSelf.speechUtrence = [[AVSpeechUtterance alloc]initWithString:voiceTest];
            weakSelf.speechUtrence.postUtteranceDelay = 1;
            [weakSelf.avSythesizer speakUtterance:weakSelf.speechUtrence];
    });
    
}
#pragma mark - 当语音播放完毕后，如果是语音的就读语音
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance
{
    //    if ([ivvStr isEqualToString:@"语音工单"]) {
    //        self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    //        [self.audioPlayer playURL:[NSURL URLWithString:VoiceUrl]];
    //    }
//    [avSythesizer stopSpeakingAtBoundary:u];

   
}

-(void)startVoiceTimer{
    [self.voiceTimer setFireDate:[NSDate distantPast]];
}
-(void)stopVoiceTimer{
    [self.voiceTimer setFireDate:[NSDate distantFuture]];
}

-(void)voiceListenAction{
    [self requestData];
}
@end
