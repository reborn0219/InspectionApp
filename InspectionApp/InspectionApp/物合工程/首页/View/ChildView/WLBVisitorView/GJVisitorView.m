//
//  GJVisitorView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJVisitorView.h"
#import <AVFoundation/AVFoundation.h>
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
#define widthRate DeviceMaxWidth/320
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
#define widthRate DeviceMaxWidth/320
#define contentTitleColorStr @"666666" //正文颜色较深
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)

#define contentH  (visiterH * 4.6)
#define contentX  (contentH/10)
@interface GJVisitorView ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureDevice *device; //灯
    BOOL isLightOn;

    AVCaptureSession * session;
    NSTimer * countTime;
    BOOL sweepStart;
    UITextField *fillinTextField;
    
    
    
}
@property (nonatomic, strong) CAShapeLayer *overlay;
@end

@implementation GJVisitorView
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.mainWindow = [UIApplication sharedApplication].keyWindow;
        [self instanceDevice];
    }
    return self;
}
- (void)instanceDevice
{
    //扫描区域
    UIImage *hbImage=[UIImage imageNamed:@"fktx_2x01"];
    UIImageView * scanZomeBack=[[UIImageView alloc] init];
    scanZomeBack.backgroundColor = [UIColor clearColor];
    scanZomeBack.layer.borderColor = [UIColor clearColor].CGColor;
    //    scanZomeBack.layer.borderWidth = 0;
    scanZomeBack.image = hbImage;
    //添加一个背景图片
    CGRect mImagerect = CGRectMake(60*widthRate, (DeviceMaxHeight-200*widthRate)/2, 200*widthRate, 200*widthRate);
    [scanZomeBack setFrame:mImagerect];
    CGRect scanCrop=[self getScanCrop:mImagerect readerViewBounds:self.frame];
    [self addSubview:scanZomeBack];
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest = scanCrop;
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    [self setOverlayPickerView:self];
    //开始捕获
    [session startRunning];
}
-(void)loopDrawLine
{
    _is_AnmotionFinished = NO;
    CGRect rect = CGRectMake(60*widthRate, (DeviceMaxHeight-200*widthRate)/2, 200*widthRate, 2);
    if (_readLineView) {
        _readLineView.alpha = 1;
        _readLineView.frame = rect;
    }
    else{
        _readLineView = [[UIImageView alloc] initWithFrame:rect];
        [_readLineView setImage:[UIImage imageNamed:@"xiantiao-2x"]];
        [self addSubview:_readLineView];
    }
    
    [UIView animateWithDuration:1.5 animations:^{
        //修改fream的代码写在这里
        _readLineView.frame =CGRectMake(60*widthRate, (DeviceMaxHeight-200*widthRate)/2+200*widthRate-5, 200*widthRate, 2);
        
    } completion:^(BOOL finished) {
        if (!_is_Anmotion) {
            [self loopDrawLine];
        }
        _is_AnmotionFinished = YES;
    }];
}

- (void)setOverlayPickerView:(GJVisitorView *)reader
{
    CGFloat wid = 60*widthRate;
    CGFloat heih = (DeviceMaxHeight - 200*widthRate)/2;
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, heih)];
    [reader addSubview:upView];
    upView.alpha = 0.4;
    upView.backgroundColor = [UIColor blackColor];
    
    //左侧的view
    UIView * cLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, heih, wid, 200*widthRate)];
    cLeftView.alpha = 0.4;
    cLeftView.backgroundColor = [UIColor blackColor];
    [reader addSubview:cLeftView];
    
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(DeviceMaxWidth-wid, heih, wid, 200*widthRate)];
    rightView.backgroundColor = [UIColor blackColor];
    rightView.alpha = 0.4;
    [reader addSubview:rightView];
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, heih+200*widthRate, DeviceMaxWidth, DeviceMaxHeight - heih-200*widthRate)];
    downView.backgroundColor = [UIColor blackColor];
    downView.alpha = 0.4;
    [reader addSubview:downView];
    
//    //用于说明的label
//    UILabel * labIntroudction= [[UILabel alloc] init];
//    labIntroudction.backgroundColor = [UIColor clearColor];
//    labIntroudction.frame=CGRectMake(0, (heih-64-50*widthRate)/2-10, DeviceMaxWidth, 50*widthRate);
//    labIntroudction.textAlignment = NSTextAlignmentCenter;
//    labIntroudction.textColor=[UIColor whiteColor];
//    labIntroudction.text=@"请将二维码/条形码放入框内,即可自动扫描";
//    labIntroudction.font = [UIFont boldSystemFontOfSize:14];
//    labIntroudction.textColor = FZColor(110, 185, 43);
//    [downView addSubview:labIntroudction];
    
    //    //开关灯button
    //    UIButton * turnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    turnBtn.backgroundColor = [UIColor clearColor];
    //    [turnBtn setBackgroundImage:[UIImage imageNamed:@"lightSelect"] forState:UIControlStateNormal];
    //    [turnBtn setBackgroundImage:[UIImage imageNamed:@"lightNormal"] forState:UIControlStateSelected];
    //    turnBtn.frame=CGRectMake((DeviceMaxWidth-50*widthRate)/2, (CGRectGetHeight(downView.frame)-50*widthRate)/2, 50*widthRate, 50*widthRate);
    //    [turnBtn addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    //    [downView addSubview:turnBtn];
    self.FillinButton = [[UIButton alloc]initWithFrame:CGRectMake(W/2 - 70, 20, 140, 40)];
    [_FillinButton setBackgroundImage:[UIImage imageNamed:@"fktx_2x02"] forState:UIControlStateNormal];
    _FillinButton.backgroundColor = [UIColor clearColor];
    [_FillinButton setTitle:@"填写访客通行码" forState:UIControlStateNormal];
    [_FillinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_FillinButton addTarget:self action:@selector(fillinButton) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:_FillinButton];
    
    
    
    
    
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if (IS_IPAD) {
        [self.btn setFrame:CGRectMake(W/2 -70+140+20 , 20, 40, 40)];
    }else{
    [self.btn setFrame:CGRectMake(W/2 -20 , H-60, 40, 40)];
    }
    
    self.btn.backgroundColor = [UIColor clearColor];

    [self.btn setBackgroundImage:[UIImage imageNamed:@"zxing_scan_flashlight_on"] forState:UIControlStateNormal];
    self.btn.tag =1000;
    [self.btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];

    //AVCaptureDevice代表抽象的硬件设备
    // 找到一个合适的AVCaptureDevice
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {//判断是否有闪光灯
        [GJSVProgressHUD showErrorWithStatus:@"当前设备没有闪光灯"];
    }else{
        if (IS_IPAD) {
            [downView addSubview:self.btn];
        }else{
        
        [reader addSubview:self.btn];
        }
    }
    isLightOn = NO;

}

-(void) turnOnLed:(bool)update
{
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device unlockForConfiguration];
}

//关闭手电筒
-(void) turnOffLed:(bool)update
{
    [device lockForConfiguration:nil];
    [device setTorchMode: AVCaptureTorchModeOff];
    [device unlockForConfiguration];
}

-(void)btnClicked
{
    isLightOn = 1-isLightOn;
    
    if (isLightOn) {
        [self turnOnLed:YES];
        [self.btn setBackgroundImage:[UIImage imageNamed:@"zxing_scan_flashlight_off"] forState:UIControlStateNormal];
        
    }else{
        [self turnOffLed:YES];
        [self.btn setBackgroundImage:[UIImage imageNamed:@"zxing_scan_flashlight_on"] forState:UIControlStateNormal];
    }
}




- (void)turnBtnEvent:(UIButton *)button_
{
    button_.selected = !button_.selected;
    if (button_.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
    
}

- (void)turnTorchOn:(bool)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);
}

- (void)start
{
    [session startRunning];
}

- (void)stop
{
    [session stopRunning];
}

#pragma mark - 扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects && metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        if (_delegate && [_delegate respondsToSelector:@selector(readerScanResult:)]) {
            [_delegate readerScanResult:metadataObject.stringValue];
        }
    }
}
#pragma mark - 颜色
//获取颜色
- (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}
-(void)fillinButton
{
    self.coverButton = [[UIButton alloc]initWithFrame:self.mainWindow.frame];
    [self.coverButton setBackgroundColor:[UIColor clearColor]];
    [self.coverButton addTarget:self action:@selector(ismissCoverButton:) forControlEvents:UIControlEventTouchUpInside];
    self.fillinView = [[UIView alloc]initWithFrame:CGRectMake(40, 150, W - 80, 140)];
    self.fillinView.layer.masksToBounds = YES;
    self.fillinView.layer.cornerRadius = 6.0;
    _fillinView.backgroundColor = gycoloers;
    fillinTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 20, _fillinView.size.width - 30, 50)];
    fillinTextField.backgroundColor = [UIColor whiteColor];
    fillinTextField.textAlignment = NSTextAlignmentCenter;
    fillinTextField.placeholder = @"填写访客通行码";
    fillinTextField.textColor = gycolor;
    fillinTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [_fillinView addSubview:fillinTextField];
    UIButton *fillinButton = [[UIButton alloc]initWithFrame:CGRectMake(_fillinView.size.width/2 - 50, 90, 100, 30)];
    [fillinButton setBackgroundImage:[UIImage imageNamed:@"dl_2x14"] forState:UIControlStateNormal];
    [fillinButton setTitle:@"确定" forState:UIControlStateNormal];
    [fillinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_fillinView addSubview:fillinButton];
    [self.coverButton addSubview:_fillinView];
    [fillinButton addTarget:self action:@selector(fillinButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.mainWindow addSubview:self.coverButton];
}
-(void)ismissCoverButton:(UIButton *)sender
{
    [self.coverButton removeFromSuperview];
}
-(void)fillinButtonDidClicked
{
    if (fillinTextField.text.length == 0) {
        [GJSVProgressHUD showErrorWithStatus:@"请填写访客通行码！"];
    }else{
        //输出扫描字符串
        if (_delegate && [_delegate respondsToSelector:@selector(WriteWechatStr:)]) {
            [_delegate WriteWechatStr:fillinTextField.text];
        }
    }
}
@end
