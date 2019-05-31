//
//  PatrolMatterSubmitVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolMatterSubmitVC.h"
#import "PPViewTool.h"
#import "PPSelectCarVC.h"
#import "PatrolUrgentOptionDetailVC.h"
#import "UrgenttaskDetailModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "GJWechatShortVideoController.h"
#import "lame.h"
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "PatrolAnnotationModel.h"
#import "MaatterSubmitModel.h"
#import "PatrolCustomAnnotationView.h"
#import "PatrolAnnotationModel.h"
#import "UserManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "ShowImageVC.h"

@interface PatrolMatterSubmitVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,WechatShortVideoDelegate,UIGestureRecognizerDelegate,MAMapViewDelegate,AMapSearchDelegate>{
    NSString * playmoviedStr;
    NSURL *playmoviedurl;
    UIImage * newImage;
    NSData * playVideoImageData;
    //转MP3后的名字
    NSString *_soundMp3FilePath;
    NSString *_soundFilePath;
    NSTimer *timer;
    //设置播放器格式
    NSDictionary *recorderSettingsDict;
    //按下录音
    int time;
    int imagetime;
    NSTimer * imagetimer;
    NSString * timerStr;
    BOOL isLocated;
    NSTimer *playTimer;

}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scroller_top;
@property (nonatomic, strong) NSMutableArray *imgDataArr;
@property (nonatomic,strong) MaatterSubmitModel *submitModel;
@property (nonatomic, strong) NSURL *recordMp3FileUrl;//转mp3后
@property(nonatomic,strong)NSURL *recordFileUrl;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,strong)AVAudioRecorder * recorder;
@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) PatrolAnnotationModel *annotation;

@property (nonatomic,strong) AMapSearchAPI *mapSearch;

@property(nonatomic,strong)UrgenttaskDetailModel * detailModel;
@property (weak, nonatomic) IBOutlet UIImageView *videoBtnImgV;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UILabel *communityLb;

@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UITextView *contentextView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_4;
@property (nonatomic,strong) NSMutableArray * imgArr;
@property (nonatomic,assign) NSInteger imgIndex;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIView *rideoShowView;
@property (weak, nonatomic) IBOutlet UIImageView *rideoTopImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rideoTopImgV_w;
@property (weak, nonatomic) IBOutlet UIImageView *rideoBottomImgV;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UITextView *markTextV;
@property (weak, nonatomic) IBOutlet UIButton *changeRepairBtn;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) NSTimer *speedTimer;
@property (nonatomic, strong)NSMutableArray  *imageUrlArr;
@property (nonatomic, strong)ShowImageVC  *showImageVC;
@property (nonatomic, strong)NSMutableArray  *images;
@property (nonatomic,strong) PPSelectCarVC * comunitySelectVC;

@end

@implementation PatrolMatterSubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _scroller_top.constant = NavBar_H;
    _imgDataArr = [NSMutableArray array];
    _imageUrlArr = [NSMutableArray array];
    _images = [NSMutableArray array];
    [_changeRepairBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_changeRepairBtn withFrame:CGRectMake(0, 0, KScreenWigth, 48) withCornerRadius:0] above:0];
    _shadowView.layer.cornerRadius = 5;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
    isLocated = NO;
    [self creatUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"在线报事"];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}

- (IBAction)selectComunityAction:(UIButton*)sender {
    
    MJWeakSelf
    _comunitySelectVC.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        PPCarModel * carModel = data;
        weakSelf.communityLb.text = carModel.community_name;
        weakSelf.submitModel.community_id = carModel.community_id;
        
    };
    _comunitySelectVC.titleStr = @"请选择社区";
    [_comunitySelectVC showInVC:self Type:3];
    
}

-(void)creatUI{
    _orderNo.text = @"";
    _comunitySelectVC =  [[PPSelectCarVC alloc]init];
    _nameLb.text = [UserManager ture_name];
    _phoneLb.text = [UserManager mobile_phone];
    _submitModel = [[MaatterSubmitModel alloc]init];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
//    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
//    r.showsAccuracyRing = YES;///精度圈是否显示，默认YES
//    r.showsHeadingIndicator = NO;
//    [self.mapView updateUserLocationRepresentation:r];
    
    [_deleteBtn setHidden:YES];
    [_recordBtn setHidden:NO];
    [_rideoShowView setHidden:YES];
    [_rideoShowView.layer insertSublayer:[PPViewTool setGradualChangingColor:_rideoShowView withFrame:CGRectMake(0, 0, KScreenWigth-60,40) withCornerRadius:8] atIndex:0];
    
    [_recordBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_recordBtn withFrame:CGRectMake(0, 0, KScreenWigth-60,40) withCornerRadius:8] atIndex:0];
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
    [_imgView_1 setImage:[UIImage imageNamed:@"tupian_add"]];
    [_imgArr addObject:_imgView_1];
    [_imgArr addObject:_imgView_2];
    [_imgArr addObject:_imgView_3];
    [_imgArr addObject:_imgView_4];
    for (UIImageView *temImgV in _imgArr) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchUp:)];
        [temImgV addGestureRecognizer:tap];
        temImgV.userInteractionEnabled = YES;
    }
    
    UILongPressGestureRecognizer *guesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handSpeakBtnPressed:)];
    guesture.delegate = self;
    guesture.minimumPressDuration = 0.01f;
    [_recordBtn addGestureRecognizer:guesture];
    
    _shadowView.layer.cornerRadius = 5;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
    _mapView.zoomLevel = 16;
    

}
-(AMapSearchAPI *)mapSearch{
    if (!_mapSearch) {
        _mapSearch= [[AMapSearchAPI alloc] init];
        self.mapSearch.delegate = self;
    }
    return _mapSearch;
}
-(PatrolAnnotationModel*)annotation{
    if (!_annotation) {
        _annotation = [[PatrolAnnotationModel alloc] init];
        _annotation.annotation_name = @"当前位置";
        _annotation.annotation_status = @"1";
    }
    return _annotation;
}
#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
      

        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    
    self.comunitySelectVC.latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.comunitySelectVC.longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    if (isLocated==NO)
    {
        
        
        isLocated = YES;
        self.annotation.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location                    = [AMapGeoPoint locationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
        regeo.requireExtension            = YES;
        [self.mapSearch AMapReGoecodeSearch:regeo];
        MJWeakSelf
        [PatrolHttpRequest getcommunitybylatlng:@{@"latitude":[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
                NSLog(@"%@",obj);
                NSArray * car_list = [obj objectForKey:@"community_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[PPCarModel class] json:car_list];
                [self.comunitySelectVC.carListArr removeAllObjects];
                [self.comunitySelectVC.carListArr addObjectsFromArray:modelArr];
                PPCarModel *carmodel = [self.comunitySelectVC.carListArr firstObject];
                weakSelf.communityLb.text = carmodel.community_name;
                weakSelf.submitModel.community_id = carmodel.community_id;

            }else{
            }
        }];
    }
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[PatrolAnnotationModel class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        PatrolCustomAnnotationView *annotationView = (PatrolCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[PatrolCustomAnnotationView alloc] initWithAnnotation:annotation
                                                                    reuseIdentifier:reuseIndetifier];
        }
        return annotationView;
    }
    return nil;
    
    
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
         _annotation.annotation_name = response.regeocode.formattedAddress;
        [_mapView addAnnotation:_annotation];
        _addressLb.text = _annotation.annotation_name;
        
    }
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

- (IBAction)recordVoiceAction:(id)sender {
    //按住说话
}
- (IBAction)recordVideoAction:(id)sender {
    //    [_rideoShowView setHidden:NO];
    //    [_recordBtn setHidden:YES];
    if (_submitModel.video_path.length>0) {
        
        GJZXVideo *video = [[GJZXVideo alloc] init];
        video.playUrl = _submitModel.video_path;
        GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
        vc.video = video;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        GJWechatShortVideoController *wechatShortVideoController = [[GJWechatShortVideoController alloc] init];
        wechatShortVideoController.delegate = self;
        [self presentViewController:wechatShortVideoController animated:YES completion:^{}];
    }
    
    
}
- (IBAction)deleteBtnAction:(id)sender {
    [_recordBtn setHidden:NO];
    [_deleteBtn setHidden:YES];
    [_rideoShowView setHidden:YES];
    self.submitModel.audio_path = @"";
    self.submitModel.audio_second = @"";
    self.recordMp3FileUrl = nil;
    [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
}
- (IBAction)playBtnAction:(id)sender {
    _rideoTopImgV_w.constant = 0;
    [self startTimer];
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    [self.audioPlayer playURL:self.recordMp3FileUrl];
}
#pragma mark - 语音定时器开始
- (void)startTimer
{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_submitModel.audio_second.integerValue>0) {
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_submitModel.audio_second.integerValue;
    }else{
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_detailModel.audio_second.integerValue;
    }
    if (_rideoTopImgV_w.constant >= (SCREEN_WIDTH - 100.0)) {
        _rideoTopImgV_w.constant = SCREEN_WIDTH - 100.0;
        [_speedTimer invalidate];
    }
}
-(void)imgTouchUp:(UIGestureRecognizer*)gestRecongizer{
    UIView * imgV = gestRecongizer.view;
    if (imgV.tag == _imgIndex +100) {
        [self chooseImage];

    }else if(imgV.tag <_imgIndex +100){
        
        _showImageVC = [[ShowImageVC alloc]init];
        [_showImageVC setImageWithImageArray:_images withIndex:imgV.tag-100];
        MJWeakSelf
        _showImageVC.block = ^(NSInteger index) {
            [weakSelf.images removeObjectAtIndex:index];
            [weakSelf.imgDataArr removeObjectAtIndex:index];
            weakSelf.imgIndex --;
            for (int i =0; i<weakSelf.imgArr.count; i++) {
                UIImageView * imgV = [weakSelf.imgArr objectAtIndex:i];
                if (i<weakSelf.images.count) {
                    [imgV setImage:[weakSelf.images objectAtIndex:i]];
                }else{
                    [imgV setImage:[UIImage imageNamed:@""]];
                }
                if (weakSelf.imgIndex<weakSelf.imgArr.count) {
                    UIImageView * nextImgV = [weakSelf.imgArr objectAtIndex:weakSelf.imgIndex];
                    [nextImgV setImage:[UIImage imageNamed:@"tupian_add"]];
                }
            }
        };
        [self presentViewController:self.showImageVC animated:NO completion:nil];
    }
    
    
    
}
#pragma mark -  //添加手势操作，长按按钮

//添加手势操作，长按按钮
- (void)handSpeakBtnPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        
        //是否允许访问麦克风
        if ([self canRecord]) {
            //判断之前有没有录音
            if (self.recordMp3FileUrl != nil) {
                
            }else
            {
                
                // 真机环境下需要的代码
                AVAudioSession *session = [AVAudioSession sharedInstance];
                NSError *sessionError;
                [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
                if(session == nil)
                    NSLog(@"Error creating session: %@", [sessionError description]);
                else
                    [session setActive:YES error:nil];
                
                //获取沙盒路径
                NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *filePath = [path stringByAppendingPathComponent:@"lvRecord.caf"];
                _soundFilePath = filePath;
                _recordFileUrl = [NSURL fileURLWithPath:filePath];
                recorderSettingsDict = [NSMutableDictionary dictionary];
                [recorderSettingsDict setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];//
                [recorderSettingsDict setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];//采样率
                [recorderSettingsDict setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];//声音通道，这里必须为双通道
                [recorderSettingsDict setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];//音频质量
                //按下录音
                [_recordBtn setTitle:@"正在录音" forState:UIControlStateNormal];
                time = 60;
                imagetime = 60;
                //启动定时器
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
                //录音
                NSError *error = nil;
                _recorder = [[AVAudioRecorder alloc] initWithURL:_recordFileUrl settings:recorderSettingsDict error:&error];
                if (_recorder) {
                    _recorder.meteringEnabled = YES;
                    [_recorder prepareToRecord];
                    [_recorder record];
                } else
                {
                    int errorCode = CFSwapInt32HostToBig ([error code]);
                    NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
                }
            }
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [self VoiceOverRecording];
    }
}
//判断是否允许使用麦克风7.0
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                }
                else {
                    bCanRecord = NO;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[[UIAlertView alloc] initWithTitle:nil
                                                    message:@"app需要访问您的相机。\n请启用相机-设置/隐私/相机"
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil] show];
                    });
                }
            }];
        }
    }
    return bCanRecord;
}
//判断秒数
-(void)levelTimer:(NSTimer*)timer_
{
    time -= 1;
    timerStr = [NSString stringWithFormat:@"%d",time];
    if ([timerStr isEqualToString:@"0"]) {
        [self VoiceOverRecording];
    }else
    {
        ///读秒
    }
}
//录音结束
-(void)VoiceOverRecording
{
 
    int voicetimes = [timerStr integerValue];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //录音停止
    [self.audioPlayer stop];
    //结束定时器
    [timer invalidate];
    [imagetimer invalidate];
    timer = nil;
    imagetimer = nil;
    [_recorder stop];
    _recorder = nil;
    if (time > 59) {
        [GJSVProgressHUD showErrorWithStatus:@"时间过短"];
        [userDefaults removeObjectForKey:@"playVoiceNameUrl"];
        time = 0;
        self.recordMp3FileUrl = nil;
        
    }else{
        
        [self changeMp3];
        
    }
}
//转MP3
-(void)changeMp3
{
    NSString *cafFilePath = _soundFilePath;    //caf文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _soundMp3FilePath = [path stringByAppendingPathComponent:@"lvRecord.mp3"];
    NSString *mp3FilePath = _soundMp3FilePath;//存储mp3文件的路径
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil])
    {
        NSLog(@"删除");
    }
    @try {
        int read, write;
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        if(pcm == NULL)
        {
            NSLog(@"file not found");
        }
        else
        {
            fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
            FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
            const int PCM_SIZE = 8192;
            const int MP3_SIZE = 8192;
            short int pcm_buffer[PCM_SIZE*2];
            unsigned char mp3_buffer[MP3_SIZE];
            lame_t lame = lame_init();
            lame_set_num_channels(lame,1);//设置1为单通道，默认为2双通道
            lame_set_in_samplerate(lame, 8000.0);//11025.0
            lame_set_brate(lame,8);
            lame_set_mode(lame,3);
            lame_set_quality(lame,2); /* 2=high 5 = medium 7=low 音质*/
            lame_init_params(lame);
            do {
                read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
                if (read == 0)
                    write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
                else
                    write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
                fwrite(mp3_buffer, write, 1, mp3);
            } while (read != 0);
            lame_close(lame);
            fclose(mp3);
            fclose(pcm);
            self.recordMp3FileUrl = [NSURL fileURLWithPath:_soundMp3FilePath];
            [self uploadVoiceFile];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"失败%@",[exception description]);
    }
    @finally {
        NSLog(@"执行完成");
    }
}
#pragma mark - 拍照
-(void)chooseImage
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    
    UIImagePickerControllerSourceType sourceType;
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"app需要访问您的相机。\n请启用相机-设置/隐私/相机"
                                   delegate:nil
                          cancelButtonTitle:@"关闭"
                          otherButtonTitles:nil] show];
        return;
    }else
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            
            sourceType = UIImagePickerControllerSourceTypeCamera;
            
        }
        else {
            
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage * newImage = [PPViewTool getWaterMarkImage:currentImage andTitle:@"打个水印玩玩" andMarkFont:[UIFont systemFontOfSize:90] andMarkColor:nil];
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.5);
    
    for (int i =0; i<_imgArr.count; i++) {
        UIImageView * imgV = [_imgArr objectAtIndex:i];
        if (i==_imgIndex) {
            [imgV setImage:[UIImage imageWithData:imageData]];
            [_images addObject:[UIImage imageWithData:imageData]];
            [self uploadImgFile:imageData];
            [_imgDataArr addObject:imageData];
            _imgIndex ++;
            if (_imgIndex<_imgArr.count) {
                UIImageView * nextImgV = [_imgArr objectAtIndex:_imgIndex];
                [nextImgV setImage:[UIImage imageNamed:@"tupian_add"]];
            }
            break;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WechatShortVideoDelegate
- (void)finishWechatShortVideoCapture:(NSURL *)filePath {
    //压缩视频
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:filePath options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        //用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        playmoviedStr = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        exportSession.outputURL = [NSURL fileURLWithPath:playmoviedStr];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             if (exportSession.status == AVAssetExportSessionStatusCompleted)
             {
                 NSLog(@"压缩完成");
                 playmoviedurl = exportSession.outputURL;
                 [self uploadVideoFile];

             }
             else if (exportSession.status == AVAssetExportSessionStatusCancelled)
             {
                 NSLog(@"取消压缩");
             }
             else
             {
                 NSLog(@"压缩失败");
                 NSLog(@"%d", (int)exportSession.status);
             }
         }];
    }
    //截取视频1帧的图片
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:filePath options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 5;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    //拿到图片
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    //压缩图片
    newImage = [ImageProcessing imageCompressForWidth:thumbnailImage targetWidth:thumbnailImage.size.width/2];
    //转换为nsdata格式
    playVideoImageData = UIImagePNGRepresentation(newImage);
    
    [_videoBtnImgV setImage:newImage];
    [_videoBtn setImage:[UIImage imageNamed:@"rideo_play"] forState:UIControlStateNormal];
    [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [self uploadVideoFile:playVideoImageData];
    //    _detailModel.task_status = @"3";
}

- (IBAction)submitMatterAction:(id)sender {
    
    _submitModel.picture_list = _imageUrlArr;
    _submitModel.report_user_id = [UserManager user_id];
    _submitModel.report_user_name = [UserManager ture_name];
    _submitModel.report_user_phone = [UserManager mobile_phone];
    _submitModel.remark = _markTextV.text;
    _submitModel.report_content = _contentextView.text;
    _submitModel.accident_position = _addressLb.text;
    _submitModel.longitude = [NSString stringWithFormat:@"%f",self.annotation.coordinate.longitude];
    _submitModel.latitude = [NSString stringWithFormat:@"%f",self.annotation.coordinate.latitude];
    _submitModel.video_list = @[];
    
    if (_submitModel.video_path.length>0&&_submitModel.thumb_path.length>0) {
        _submitModel.video_list = @[@{@"video_path":_submitModel.video_path,@"thumb_path":_submitModel.thumb_path}];
    }
   
    if (_imgDataArr.count>0) {
        _submitModel.picture_list = self.imageUrlArr;
    }
    NSDictionary * dic = [_submitModel yy_modelToJSONObject];
    NSLog(@"%@",dic);
    MJWeakSelf
    if (_addressLb.text.length == 0) {
        [GJMBProgressHUD showError:@"定位失败，未获取到事发位置，提交失败！"];
    }else{
        ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
        [firmationVC showInVC:self withTitle:@"是否确认提交报事工单？"];
        firmationVC.block = ^(NSInteger index) {
            if (index) {
                
                [PatrolHttpRequest reporteventcommit:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                    
                    if (resultCode == SucceedCode) {
                        
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                        [GJMBProgressHUD showSuccess:@"提交成功"];
                    }else{
                        
                    }
                }];
                
            }else{
                
                
                
                
            }
        };
    }
  
    
    
}
-(void)uploadImgFile:(NSData*)imgData{
    MJWeakSelf
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:[NSURL new] fileName:@"" imgData:imgData fileType:0 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            NSDictionary * pic_path = @{@"pic_path":file_path};
            [weakSelf.imageUrlArr addObject:pic_path];
        }else{
            
        }
    }];
}
-(void)uploadVoiceFile{
    
    MJWeakSelf
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:_recordMp3FileUrl fileName:@"" imgData:[NSData data] fileType:1 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            weakSelf.submitModel.audio_path = file_path;
            weakSelf.submitModel.audio_second = [NSString stringWithFormat:@"%ld",(long)(60-time)];
            
            [weakSelf.playBtn setTitle:weakSelf.submitModel.audio_second forState:UIControlStateNormal];
            [weakSelf.playBtn layoutButtonWithImageTitleSpace:2];
            [weakSelf.recordBtn setHidden:YES];
            [weakSelf.rideoShowView setHidden:NO];
            [weakSelf.deleteBtn setHidden:NO];

        }else{
            
        }
    }];
}
-(void)uploadVideoFile:(NSData*)imgData{
    MJWeakSelf
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:playmoviedurl fileName:@"999" imgData:imgData fileType:0 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            weakSelf.submitModel.thumb_path = file_path;
        }else{
            
        }
     }];
}
-(void)uploadVideoFile{
    MJWeakSelf
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:playmoviedurl fileName:@".mp4" imgData:[NSData data] fileType:2 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            weakSelf.submitModel.video_path = file_path;
        }else{
            
        }
    }];
}
@end
