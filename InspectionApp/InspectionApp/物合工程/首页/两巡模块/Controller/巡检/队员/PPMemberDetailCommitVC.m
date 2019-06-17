//
//  PPMemberDetailCommitVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPMemberDetailCommitVC.h"
#import "PPViewTool.h"
#import "PatrolFormCell.h"

#import "PPInspectDeviceModel.h"
#import "GJWechatShortVideoController.h"
#import "lame.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "PPInspectDeviceModel.h"
#import "PPSubmitOrdersModel.h"
#import "PPLocationMapVC.h"
#import "ShowImageVC.h"
#import "PPSubmitOrdersVedio_list.h"
#import "ConfirmationVC.h"

@interface PPMemberDetailCommitVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,WechatShortVideoDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>{
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
@property (nonatomic,assign)BOOL isnull;
;

@property (nonatomic,strong) NSMutableArray *imgDataArr;
@property (weak, nonatomic) IBOutlet UILabel *noVoiceLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *circleLb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview_h;
@property (weak, nonatomic) IBOutlet UIButton *leftSubmitBtn;
@property (nonatomic, strong) NSURL *recordMp3FileUrl;//转mp3后
@property(nonatomic,strong)NSURL *recordFileUrl;
@property(nonatomic, retain)GJSTKAudioPlayer *audioPlayer;
@property(nonatomic,strong)AVAudioRecorder * recorder;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property(nonatomic,strong)PPInspectDeviceModel * detailModel;
@property (weak, nonatomic) IBOutlet UILabel *imgdescribLb;
@property (weak, nonatomic) IBOutlet UILabel *videodescribLb;
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *videoBtnImgV;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_4;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) NSMutableArray * imgArr;
@property (nonatomic,assign) NSInteger imgIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backView_top;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceNoLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceAdressLb;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIView *orderTopView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UIButton *changeRepairBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rideoTopImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rideoTopImgV_w;
@property (weak, nonatomic) IBOutlet UIImageView *rideoBottomImgV;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UILabel *nohaveimgLb;
@property (weak, nonatomic) IBOutlet UITextView *markTextV;
@property (nonatomic, strong)PPSubmitOrdersModel  *submitOrdersModel;

@property (nonatomic, strong)ShowImageVC  *showImageVC;
@property (nonatomic, strong)NSMutableArray  *images;
@property (nonatomic, strong)PPSubmitOrdersVedio_list  *video_list;
@property (nonatomic,strong) NSTimer *speedTimer;
@property (nonatomic, strong)NSMutableArray  *project_list;

@end

@implementation PPMemberDetailCommitVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _isnull = NO;
    _submitOrdersModel = [[PPSubmitOrdersModel alloc]init];
    _video_list = [[PPSubmitOrdersVedio_list alloc]init];
    _project_list = [NSMutableArray array];
    _imgDataArr = [NSMutableArray array];
    _images = [NSMutableArray array];
    _markTextV.delegate = self;
    [self creatUI];
    [self reloadData];
    [_noVoiceLb setHidden:YES];
  
}

-(void)creatUI{
    
    video_path = @"";
    thumb_path = @"";
    
    _mapBtn.layer.cornerRadius = 10;
    [_mapBtn setHidden:YES];
    _backView_top.constant = NavBar_H;
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
    self.rideoTopImgV.clipsToBounds = YES;
    self.rideoTopImgV.contentMode = UIViewContentModeLeft;
    self.rideoBottomImgV.clipsToBounds = YES;
    self.rideoBottomImgV.contentMode = UIViewContentModeRight;
    for (UIImageView *temImgV in _imgArr) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchUp:)];
        [temImgV addGestureRecognizer:tap];
        temImgV.userInteractionEnabled = YES;
    }
    [_voiceView.layer insertSublayer:[PPViewTool setGradualChangingColor:_voiceView withFrame:CGRectMake(0, 0, KScreenWigth-62, 40) withCornerRadius:8] above:0];
    [_voiceView setHidden:YES];
    [_deleteBtn setHidden:YES];
    [_recordBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_recordBtn withFrame:CGRectMake(0, 0, KScreenWigth-60,40) withCornerRadius:8] atIndex:0];
    [_recordBtn setHidden:NO];
    UILongPressGestureRecognizer *guesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handSpeakBtnPressed:)];
    guesture.delegate = self;
    guesture.minimumPressDuration = 0.01f;
    [_recordBtn addGestureRecognizer:guesture];
    
  
    [_changeRepairBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_changeRepairBtn withFrame:CGRectMake(0, 0, KScreenWigth/13*8, 48) withCornerRadius:0] above:0];
    [_leftSubmitBtn.layer insertSublayer:[PPViewTool setGradualChangingToRed:_leftSubmitBtn withFrame:CGRectMake(0, 0, KScreenWigth/13*5, 48)] above:0];
  
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
    _stateBtn.layer.cornerRadius = 8;
    [_tableView registerNib:[UINib nibWithNibName:@"PatrolFormCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolFormCell"];
    _tableView.estimatedRowHeight=44;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight=UITableViewAutomaticDimension;
    
    
    
}
-(void)reloadData{
    MJWeakSelf
    [PatrolHttpRequest memberinspectdevicedetail:@{@"work_sheet_id":self.work_sheet_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSLog(@"%@",data);
            NSDictionary * dic = data;
            
                weakSelf.detailModel = [PPInspectDeviceModel yy_modelWithJSON:dic];
                [weakSelf assignment:weakSelf.detailModel];
         
                [weakSelf.tableView reloadData];
                weakSelf.tableview_h.constant = weakSelf.tableView.contentSize.height;
                //当工单状态为已完成时 只查看不提交
                weakSelf.work_sheet_status = weakSelf.detailModel.work_sheet_status;
                if (weakSelf.detailModel.work_sheet_status.intValue != 1) {
                 
                    weakSelf.changeRepairBtn.hidden = YES;
                    weakSelf.leftSubmitBtn.hidden = YES;
                    [weakSelf assignmentOverModel:weakSelf.detailModel];
                }
         
        }else{
            
            [weakSelf.backView setHidden:YES];
        }
      
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"设备详情"];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
    
}
#pragma mark - 语音定时器开始
- (void)startTimer
{
    self.speedTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(speechAnimationAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_speedTimer forMode:NSRunLoopCommonModes];
}
-(void)speechAnimationAction{
    
    if (_submitOrdersModel.audio_second.integerValue>0) {
        _rideoTopImgV_w.constant += (SCREEN_WIDTH - 100.0)/_submitOrdersModel.audio_second.integerValue;
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
    if (_detailModel.work_sheet_status.integerValue == 1) {
        if (imgV.tag == _imgIndex + 100) {
            [self chooseImage];
        }else if (imgV.tag < _imgIndex + 100){
            _showImageVC = [[ShowImageVC alloc]init];
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
            [_showImageVC setImageWithImageArray:_images withIndex:imgV.tag-100];
            [self presentViewController:_showImageVC animated:NO completion:nil];
        }
    }else{
        if (_detailModel.picture_list.count == 0) {
            imgV.userInteractionEnabled = NO;
        }else{
            _showImageVC = [[ShowImageVC alloc]init];
            NSMutableArray *picture_list = [NSMutableArray array];

            for (PPInspectDeviceModelPicture_list *picture in _detailModel.picture_list ) {
                
                [picture_list addObject:picture.pic_url];
            }
            [_showImageVC setImageWithImageArray:picture_list withIndex:imgV.tag-100];
            [self presentViewController:_showImageVC animated:NO completion:nil];
        }
    }
   
}
- (void)assginSubmitModel
{
    _submitOrdersModel.work_sheet_id = _detailModel.work_sheet_id;
    if (_detailModel.project_list.count == 0) {
        _submitOrdersModel.project_list = [NSArray array];
    }else{
        NSMutableArray * tempProjectModel = [NSMutableArray array];
        _isnull = NO;
        for (PPInspectDeviceModelProject_list* model  in _detailModel.project_list) {
            PPSubmitOrdersProject_list *listModel = [[PPSubmitOrdersProject_list alloc]init];
            listModel.project_result = model.project_result;
            if (model.project_result.length==0) {
                _isnull = YES;
            }
            listModel.project_id = model.project_id;
            [tempProjectModel addObject:listModel];
        }
      
        _submitOrdersModel.project_list = tempProjectModel;
    }
    _submitOrdersModel.picture_list = _imgDataArr;
    NSMutableArray *videoArr = [NSMutableArray array];
    if (video_path.length&&thumb_path.length) {
        _video_list.video_path = video_path;
        _video_list.thumb_path = thumb_path;
        [videoArr addObject:_video_list];
    }
    _submitOrdersModel.video_list = videoArr;

    
}
#pragma mark - actions

- (IBAction)leftSubmitAction:(id)sender {
   //异常按钮
    MJWeakSelf
    self.submitOrdersModel.is_normal =@"3";
    [self assginSubmitModel];
    if (_isnull==YES) {
        [GJMBProgressHUD showError:@"巡查项目结果不能为空"];
        return;
    }
    NSDictionary * dic = [self.submitOrdersModel yy_modelToJSONObject];
    
    NSLog(@"dic======%@",dic);

    ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
    [firmationVC showInVC:self withTitle:@"是否确定提交工单结果？"];
    firmationVC.block = ^(NSInteger index) {
        if (index) {
            //确定
            
            [PatrolHttpRequest   memberinspectdevicecommit:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                
                if (resultCode == SucceedCode) {
                    [GJMBProgressHUD showSuccess:@"提交成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [GJMBProgressHUD showError:@"提交失败"];
                }
            }];
        }else{
            
            
            
            
        }
    };
   
}
- (IBAction)changeRepairAction:(id)sender {
    //正常按钮
    self.submitOrdersModel.is_normal =@"2";
    [self assginSubmitModel];
    if (_isnull==YES) {
        [GJMBProgressHUD showError:@"巡查项目结果不能为空"];
        return;
    }
    NSDictionary * dic = [self.submitOrdersModel yy_modelToJSONObject];
    NSLog(@"dic======%@",dic);
    
    MJWeakSelf
    ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
    [firmationVC showInVC:self withTitle:@"是否确定提交工单结果？"];
    firmationVC.block = ^(NSInteger index) {
        if (index) {
            //确定
            
            [PatrolHttpRequest   memberinspectdevicecommit:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                
                if (resultCode == SucceedCode) {
                    [GJMBProgressHUD showSuccess:@"提交成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [GJMBProgressHUD showError:@"提交失败"];
                }
            }];
        }else{
            
            
            
            
        }
    };
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
   
    _submitOrdersModel.remark = textView.text;
    
}
- (IBAction)playVoiceAction:(id)sender {
    _rideoTopImgV_w.constant = 0;
    [self startTimer];
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    self.audioPlayer = [GJFZPVoicePlay ShareAudioPlayer];
    if (self.recordMp3FileUrl!=nil) {
        [self.audioPlayer playURL:self.recordMp3FileUrl];
    }else{
        [self.audioPlayer playURL:[NSURL URLWithString:_detailModel.audio_rul]];

    }
}

- (IBAction)recordVoiceAction:(id)sender {
}

- (IBAction)DeviceToMapAction:(id)sender {

}
- (IBAction)recordVideoAction:(id)sender {
    
    if (self.detailModel.work_sheet_status.integerValue == 1 || self.detailModel == nil) {
        if(video_path.length>0){
            
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
       

    }else{
       
        PPInspectDeviceModelVideo_list *videoModel =  _detailModel.video_list.firstObject;
        if (videoModel && videoModel.img_url.length && videoModel.video_url.length) {
            GJZXVideo *video = [[GJZXVideo alloc] init];
            video.playUrl = videoModel.video_url;
            GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
            vc.video = video;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
      
    }
    
}
- (IBAction)deleteVoiceAction:(id)sender {
    [_recordBtn setHidden:NO];
    [_deleteBtn setHidden:YES];
    [_voiceView setHidden:YES];
    self.recordMp3FileUrl = nil;
    self.submitOrdersModel.audio_path = @"";
    self.submitOrdersModel.audio_second = @"";
    [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailModel.project_list.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PatrolFormCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolFormCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView setBackgroundColor:HexRGB(0xE8E8E8)];

        return cell;
    }else{
        PatrolFormCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolFormCell"];
        PPInspectDeviceModelProject_list * model = [_detailModel.project_list objectAtIndex:indexPath.row -1];
        
        if (indexPath.row%2 == 0) {
            [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell.contentView setBackgroundColor:HexRGB(0xECECEC)];
        }
        if (_detailModel.work_sheet_status.integerValue == 1) {
            [cell assignmentWithModel:model isSubmit:YES];
        }else{
            [cell assignmentWithModel:model isSubmit:NO];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
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
            _imgIndex ++;
            [self uploadImgFile:imageData];
            if (_imgIndex<_imgArr.count) {
                UIImageView * nextImgV = [_imgArr objectAtIndex:_imgIndex];
                [nextImgV setImage:[UIImage imageNamed:@"tupian_add"]];
            }
          break;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_voiceView setHidden:NO];
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
        [_recordBtn setHidden:NO];
        [_deleteBtn setHidden:YES];
        [_voiceView setHidden:YES];
        [_recordBtn setTitle:@"按住说话" forState:UIControlStateNormal];
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

#pragma mark - 非编辑状态赋值偶作
-(void)assignmentOverModel:(PPInspectDeviceModel *)viewModel{
    
    [_imgdescribLb setHidden:YES];
    [_videodescribLb setHidden:YES];
    [_leftSubmitBtn setHidden:YES];
    [_changeRepairBtn setHidden:YES];
    _markTextV.text = viewModel.remark;
    _markTextV.editable = NO;
  
    if (viewModel.picture_list.count==0 && _imgArr.count != 0) {
        [_imgView_1 setImage:[UIImage imageNamed:@""]];
        _nohaveimgLb.text = @"无";
        for (int i =0; i<_imgArr.count; i++) {
            UIImageView * imgV = [_imgArr objectAtIndex:i];
            [imgV setUserInteractionEnabled:NO];
        }
    }
    
    
    for (int i = 0; i<viewModel.picture_list.count; i++) {
        PPInspectDeviceModelPicture_list * picModel = [viewModel.picture_list objectAtIndex:i];
        if (i<_imgArr.count) {
            UIImageView *temImgV = [_imgArr objectAtIndex:i];
            [temImgV sd_setImageWithURL:[NSURL URLWithString:picModel.pic_url]];
        }
    }
    PPInspectDeviceModelVideo_list *videoModel =  viewModel.video_list.firstObject;
    if (videoModel && videoModel.img_url.length && videoModel.video_url.length) {
        [_videoBtnImgV sd_setImageWithURL:[NSURL URLWithString:videoModel.img_url]];
        [_videoBtn setImage:[UIImage imageNamed:@"rideo_play"] forState:UIControlStateNormal];
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }else{
        [_videoBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_videoBtn setTitle:@"无" forState:UIControlStateNormal];
    }
    _markTextV.text = viewModel.remark?:@"";
    if([_markTextV.text isEqualToString:@"null"]){
        _markTextV.text = @"";
    }
    
    if (viewModel.audio_second.integerValue != 0) {
        
        [_playBtn setTitle:viewModel.audio_second forState:UIControlStateNormal];
        [_playBtn layoutButtonWithImageTitleSpace:2];
        [_recordBtn setHidden:YES];
        [_voiceView setHidden:NO];
        [_deleteBtn setHidden:YES];
        [_noVoiceLb setHidden:YES];

    }else{
        [_recordBtn setHidden:YES];
        [_noVoiceLb setHidden:NO];
    }
    
}
-(void)assignment:(PPInspectDeviceModel *)viewModel{
    
    _deviceNameLb.text = [NSString stringWithFormat:@"%@ %@",viewModel.device_name,viewModel.device_no];
    _deviceNoLb.text = [NSString stringWithFormat:@"%@ %@",viewModel.community_name,viewModel.device_position] ;
    NSString *dateStr;
    NSString *time;
    if (viewModel.inspect_time.length != 0) {
    time = [viewModel.inspect_time substringWithRange:NSMakeRange(10, 6)];
    dateStr = [PPDateTool stringFormat:viewModel.inspect_time];
    }

//    _timeLb.text =[PPDateTool stringFormat:viewModel.inspect_time];
//    _timeLb.text = [viewModel.inspect_time substringWithRange:NSMakeRange(5, 11)];
    if (_work_sheet_status.integerValue == 1) {
        _deviceAdressLb.text = @"";
    }else{
     _deviceAdressLb.text = [NSString stringWithFormat:@"%@ %@",viewModel.inspect_user_name,viewModel.inspect_user_phone];
    }
    _circleLb.text = [NSString stringWithFormat:@"%@/%@巡查",viewModel.inspected_count,viewModel.inspect_count];
    
    if (_work_sheet_status.integerValue == 1) {
        [_stateBtn setBackgroundColor:UN_OPTION_COLOR];
        [_stateBtn setTitle:@"未巡查" forState:UIControlStateNormal];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat:@"M月dd日 HH:mm"];
      
        _timeLb.text = [formatter stringFromDate:[NSDate date]]; 
        
    }else if (_work_sheet_status.integerValue == 2) {
        [_stateBtn setBackgroundColor:OPTIONING_COLOR];
        [_stateBtn setTitle:@"正常" forState:UIControlStateNormal];
         _timeLb.text =[NSString stringWithFormat:@"%@ %@",dateStr,time];

    }else if (_work_sheet_status.integerValue == 3||_work_sheet_status.integerValue == 4) {
        [_stateBtn setBackgroundColor:UN_START_COLOR];
        [_stateBtn setTitle:@"异常" forState:UIControlStateNormal];
         _timeLb.text = [NSString stringWithFormat:@"%@ %@",dateStr,time];

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
            weakSelf.submitOrdersModel.audio_path = file_path;
            weakSelf.submitOrdersModel.audio_second = [NSString stringWithFormat:@"%ld",(long)(60-time)];
            
            [weakSelf.playBtn setTitle:weakSelf.submitOrdersModel.audio_second forState:UIControlStateNormal];
            [weakSelf.playBtn layoutButtonWithImageTitleSpace:2];
            [weakSelf.recordBtn setHidden:YES];
            [weakSelf.voiceView setHidden:NO];
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

