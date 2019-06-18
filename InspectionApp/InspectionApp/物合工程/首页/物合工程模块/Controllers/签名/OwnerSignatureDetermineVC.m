//
//  OwnerSignatureDetermineVC.m
//  InspectionApp
//
//  Created by yang on 2019/6/13.
//  Copyright © 2019 yang. All rights reserved.
//

#import "OwnerSignatureDetermineVC.h"
#import "SecurityRequest.h"
@interface OwnerSignatureDetermineVC ()
@property (weak, nonatomic) IBOutlet UIImageView *signImageV;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation OwnerSignatureDetermineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _backView.layer.cornerRadius = 8;
    [self showNaBar:2];
    [self setBarTitle:@"签名确认"];
}
- (IBAction)bottomBtnAction:(id)sender {
    UIButton * btn = sender;
    if (btn.tag) {
        [self uploadImgFile];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_signImageV setImage:_signatureImg];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark - 上传媒体文件
-(void)uploadImgFile{
    MJWeakSelf
    NSData* imgData;
    
    if (UIImagePNGRepresentation(_signatureImg) == nil) {
        
        imgData = UIImageJPEGRepresentation(_signatureImg, 1);
        
    } else {
        
        imgData = UIImagePNGRepresentation(_signatureImg);
    }
    [BaseRequest postRequestData:@"upload" parameters:@{} dataUrl:[NSURL new] fileName:@"" imgData:imgData fileType:0 :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSString * file_path = [dic objectForKey:@"file_path"];
            weakSelf.controllerModel.repaird.autograph = file_path;
            [weakSelf markFinished];
            
        }else{
            
        }
    }];
}
-(void)markFinished{
    NSDictionary *dic = @{
                          @"service_charge":_controllerModel.repaird.service_charge,
                          @"paid_type":_controllerModel.repaird.paid_type,
                          @"come_in_time":_controllerModel.repaird.come_in_time,
                          @"come_out_time":_controllerModel.repaird.come_out_time,
                          @"repair_id":_controllerModel.repair_id,
                          @"work_remarks":_controllerModel.repaird.work_remarks,
                          @"autograph":_controllerModel.repaird.autograph,

                          };
    MJWeakSelf
    [SecurityRequest edit_finished:dic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode==SucceedCode) {
            NSLog(@"%@",data);
            [weakSelf popControllerReverse:5];
            [GJMBProgressHUD showSuccess:@"操作成功!"];

        }
    }];
}
@end
