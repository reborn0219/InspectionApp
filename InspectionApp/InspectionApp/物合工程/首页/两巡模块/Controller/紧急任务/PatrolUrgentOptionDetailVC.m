//
//  PatrolUrgentOptionDetailVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolUrgentOptionDetailVC.h"
#import "UrgenttaskDetailModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "GJWechatShortVideoController.h"
#import "lame.h"
#import "ZXJSubmitUrgentModel.h"
#import "ShowImageVC.h"
#import "ShowImageVC.h"


@interface PatrolUrgentOptionDetailVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,WechatShortVideoDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>{
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
    NSString * thumb_path;
    NSString * video_path;
}
@property (nonatomic, strong) NSURL *recordMp3FileUrl;//转mp3后
@property(nonatomic,strong)NSURL *recordFileUrl;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,strong)AVAudioRecorder * recorder;
@property (nonatomic,strong) NSMutableArray *imgDataArr;
@property (nonatomic,strong) NSMutableArray *images;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,strong)UrgenttaskDetailModel * detailModel;
@property (weak, nonatomic) IBOutlet UIImageView *videoBtnImgV;

@property (weak, nonatomic) IBOutlet UIButton *teamBtn;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *taskTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *urgentNameLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *markLb;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_4;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong) NSMutableArray * imgArr;
@property (nonatomic,assign) NSInteger imgIndex;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIView *rideoShowView;
@property (weak, nonatomic) IBOutlet UIImageView *rideoTopImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rideoTopImgV_w;
@property (weak, nonatomic) IBOutlet UIImageView *rideoBottomImgV;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UILabel *nohaveimgLb;
@property (weak, nonatomic) IBOutlet UITextView *markTextV;
@property (weak, nonatomic) IBOutlet UILabel *picdescribLb;
@property (weak, nonatomic) IBOutlet UILabel *videodescribLb;
@property (nonatomic, strong)ZXJSubmitUrgentModel  *model;
@property (nonatomic, strong)ShowImageVC  *showImageVC;
@property (nonatomic,strong) NSTimer *speedTimer;

@end

@implementation PatrolUrgentOptionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultTextView.delegate = self;
    _markTextV.delegate = self;
    _model = [[ZXJSubmitUrgentModel alloc]init];
    _showImageVC = [[ShowImageVC alloc]init];
    [self creatUI];
    [self reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"紧急任务工单"];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
    
}
-(void)popController
{
    [self popController:1];
}
-(void)creatUI{
    _timeLb.hidden = YES;
    video_path = @"";
    thumb_path = @"";
    _imgDataArr = [NSMutableArray array];
    _images = [NSMutableArray array];
    [_rideoShowView.layer insertSublayer:[PPViewTool setGradualChangingColor:_rideoShowView withFrame:CGRectMake(0, 0, KScreenWigth-62,40) withCornerRadius:8] atIndex:0];
    [_submitBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_submitBtn withFrame:CGRectMake(0, 0, KScreenWigth, 48) withCornerRadius:0] above:0];
     [_recordBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_recordBtn withFrame:CGRectMake(0, 0, KScreenWigth-60,40) withCornerRadius:8] atIndex:0];
    [_recordBtn setHidden:YES];
    
    self.rideoTopImgV.clipsToBounds = YES;
    self.rideoTopImgV.contentMode = UIViewContentModeLeft;
    self.rideoBottomImgV.clipsToBounds = YES;
    self.rideoBottomImgV.contentMode = UIViewContentModeRight;

    [_deleteBtn setHidden:YES];
    [_recordBtn setHidden:NO];
    [_rideoShowView setHidden:YES];
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
    
    _teamBtn.layer.cornerRadius = 5;
    _stateView.layer.cornerRadius = 10;
    _shadowView.layer.cornerRadius = 5;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
   
}
#pragma mark - 语音定时器开始
- (void)startTimer
{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_model.audio_second.integerValue>0) {
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_model.audio_second.integerValue;
    }else{
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_detailModel.audio_second.integerValue;
    }
    if (_rideoTopImgV_w.constant >= (SCREEN_WIDTH - 100.0)) {
        _rideoTopImgV_w.constant = SCREEN_WIDTH - 100.0;
        [_speedTimer invalidate];
    }
}
- (IBAction)recordVoiceAction:(id)sender {
    //按住说话
}
- (IBAction)recordVideoAction:(id)sender {
//    [_rideoShowView setHidden:NO];
//    [_recordBtn setHidden:YES];
    if (self.detailModel.task_status.integerValue != 2) {
       
        UrgenttaskDetailModelVideo_list *videoModel =  _detailModel.video_list.firstObject;
        GJZXVideo *video = [[GJZXVideo alloc] init];
        video.playUrl = videoModel.video_url;
        GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
        vc.video = video;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (video_path.length>0) {
            GJZXVideo *video = [[GJZXVideo alloc] init];
            video.playUrl = video_path;
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
   

}
- (IBAction)deleteBtnAction:(id)sender {

    [_recordBtn setHidden:NO];
    [_deleteBtn setHidden:YES];
    [_rideoShowView setHidden:YES];
    self.model.audio_path = @"";
    self.model.audio_second = @"";
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
    if(self.recordMp3FileUrl!=nil){
        [self.audioPlayer playURL:self.recordMp3FileUrl];
    }else{
        [self.audioPlayer playURL:[NSURL URLWithString:_detailModel.audio_url]];
    }

}
-(void)imgTouchUp:(UIGestureRecognizer*)gestRecongizer{
    UIView * imgV = gestRecongizer.view;

    if (_detailModel.task_status.integerValue == 2) {
        if (imgV.tag == _imgIndex + 100) {
            [self chooseImage];
        }else if (imgV.tag < _imgIndex + 100){
            
            [_showImageVC setImageWithImageArray:_images withIndex:imgV.tag - 100];
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
            [self presentViewController:self.showImageVC animated:YES completion:nil];
        }
    }else{
        if (_detailModel.picture_list.count == 0) {
            imgV.userInteractionEnabled = NO;
        }else{
            NSMutableArray *imageArr = [NSMutableArray array];
            for (UrgenttaskDetailModelPicture_list *picture in _detailModel.picture_list) {
                [imageArr addObject:picture.pic_url];
            }
            [_showImageVC setImageWithImageArray:imageArr withIndex:imgV.tag - 100];
            [self presentViewController:self.showImageVC animated:YES completion:nil];
        }
       
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
    [_recordBtn setHidden:YES];
    [_rideoShowView setHidden:NO];
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
            [self uploadImgFile:imageData];
            [_images addObject:[UIImage imageWithData:imageData]];
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

//浏览图片
-(void)pushImageDidClicked:(NSMutableArray *)mutableArray imageTag:(int)imagetag
{
    GJMHPhotoBrowserController *vc = [GJMHPhotoBrowserController new];
    vc.currentImgIndex = imagetag;
    vc.displayTopPage = YES;
    vc.displayDeleteBtn = NO;
    vc.imgArray = mutableArray;
    [self presentViewController:vc animated:NO completion:nil];
}
//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self uploadVideoFile:playVideoImageData];
    [_videoBtnImgV setImage:newImage];
    [_videoBtn setImage:[UIImage imageNamed:@"rideo_play"] forState:UIControlStateNormal];
    [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    _detailModel.task_status = @"3";
}
-(void)reloadData{
    MJWeakSelf
    [PatrolHttpRequest urgenttaskdetail:@{@"task_no":_controllerModel.task_no} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSLog(@"%@",data);
            NSDictionary * dic = data;
            weakSelf.detailModel = [UrgenttaskDetailModel yy_modelWithJSON:dic];
            [weakSelf assignment:weakSelf.detailModel];
            if (weakSelf.detailModel.task_status.integerValue == 3) {
                [weakSelf assignmentOverModel:weakSelf.detailModel];
            }
        }
        
    }];
}
-(void)assignmentOverModel:(UrgenttaskDetailModel *)viewModel{
    
    [_picdescribLb setHidden:YES];
    [_videodescribLb setHidden:YES];
    _resultTextView.text = viewModel.result;
    _resultTextView.editable = NO;
    if (viewModel.picture_list.count==0) {
        [_imgView_1 setImage:[UIImage imageNamed:@""]];
        _nohaveimgLb.text = @"无";
        for (int i =0; i<_imgArr.count; i++) {
            UIImageView * imgV = [_imgArr objectAtIndex:i];
            [imgV setUserInteractionEnabled:NO];
        }
    }
    for (int i = 0; i<viewModel.picture_list.count; i++) {
        UrgenttaskDetailModelPicture_list * picModel = [viewModel.picture_list objectAtIndex:i];
        if (i<_imgArr.count) {
            UIImageView *temImgV = [_imgArr objectAtIndex:i];
            [temImgV sd_setImageWithURL:[NSURL URLWithString:picModel.pic_url]];
        }
    }
    UrgenttaskDetailModelVideo_list *videoModel =  viewModel.video_list.firstObject;
    if (videoModel) {
        [_videoBtnImgV sd_setImageWithURL:[NSURL URLWithString:videoModel.img_url]];
        [_videoBtn setImage:[UIImage imageNamed:@"rideo_play"] forState:UIControlStateNormal];
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    }else{
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_videoBtn setTitle:@"无" forState:UIControlStateNormal];
    }
    _markTextV.text = viewModel.remark;
    _markTextV.editable = NO;

    if (viewModel.audio_second.integerValue != 0) {
        
        [_playBtn setTitle:viewModel.audio_second forState:UIControlStateNormal];
        [_playBtn layoutButtonWithImageTitleSpace:2];
        [_recordBtn setHidden:YES];
        [_rideoShowView setHidden:NO];
        [_deleteBtn setHidden:NO];
    }else{
        [_recordBtn setHidden:YES];

    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1001) {
        _model.exec_result = textView.text;
    }else{
        _model.remark = textView.text;
    }
}
- (void)assginmentData
{
    _model.task_no = _detailModel.task_no;
    _model.remark = _markTextV.text;
    _model.exec_result = _resultTextView.text;
    _model.video_list = @[];
    if (video_path.length>0&&thumb_path.length>0) {
        _model.video_list = @[@{@"video_path":video_path,@"thumb_path":thumb_path}];
    }
    _model.picture_list = self.imgDataArr;
    
}

- (IBAction)submitBtnAction:(id)sender {
    [self assginmentData];
    
    NSDictionary *dic = [_model yy_modelToJSONObject];
    [PatrolHttpRequest urgentworkcommit:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            [GJMBProgressHUD showSuccess:@"任务提交成功"];
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }else{
            [GJMBProgressHUD showSuccess:@"任务提交失败"];
        }
    }];
}
-(void)assignment:(UrgenttaskDetailModel *)viewModel{
    
    if (viewModel.task_status.integerValue == 2) {
        _submitBtn.hidden = NO;
    }else{
        _submitBtn.hidden = YES;
    }
    
    _titleLb.text = viewModel.task_name;
    _timeLb.text =[PPDateTool stringFormat:viewModel.task_date];
    _orderNo.text = viewModel.task_no;
    if (viewModel.task_object.integerValue==1) {
        [_teamBtn setTitle:@"组" forState:UIControlStateNormal];
    }else{
        [_teamBtn setTitle:@"人" forState:UIControlStateNormal];
    }
    _taskTimeLb.text = viewModel.task_date;
    _urgentNameLb.text = viewModel.dispatch_user_name;
    _addressLb.text = viewModel.dispatch_position;
    _markLb.text = viewModel.dispatch_remark;
    
    if (viewModel.task_status.integerValue == 1) {
        [_stateView setBackgroundColor:UN_OPTION_COLOR];
        _stateLb.text = @"未执行";
    }else if (viewModel.task_status.integerValue == 2) {
        [_stateView setBackgroundColor:OPTIONING_COLOR];
        _stateLb.text = @"执行中";
    }else if (viewModel.task_status.integerValue == 3) {
        [_stateView setBackgroundColor:OVER_COLOR];
        _stateLb.text = @"已结束";
    }
    
}

#pragma mark - 上传媒体文件
-(void)uploadImgFile:(NSData*)imgData{
    MJWeakSelf
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:[NSURL new] fileName:@"" imgData:imgData fileType:0 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            NSDictionary * pic_path = @{@"pic_path":file_path};
            [weakSelf.imgDataArr addObject:pic_path];
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
            weakSelf.model.audio_path = file_path;
            weakSelf.model.audio_second = [NSString stringWithFormat:@"%ld",(long)(60-time)];
            
            [weakSelf.playBtn setTitle:weakSelf.model.audio_second forState:UIControlStateNormal];
            [weakSelf.playBtn layoutButtonWithImageTitleSpace:2];
            [weakSelf.recordBtn setHidden:YES];
            [weakSelf.rideoShowView setHidden:NO];
            [weakSelf.deleteBtn setHidden:NO];
            
        }else{
            
        }
    }];
}
-(void)uploadVideoFile:(NSData*)imgData{
    
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:playmoviedurl fileName:@"999" imgData:imgData fileType:0 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            thumb_path = file_path;
        }else{
            
        }
    }];
}
-(void)uploadVideoFile{
    
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:playmoviedurl fileName:@".mp4" imgData:[NSData data] fileType:2 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            video_path = file_path;
        }else{
            
        }
    }];
}

@end
