//
//  OwnerSignatureVC.m
//  InspectionApp
//
//  Created by yang on 2019/6/13.
//  Copyright © 2019 yang. All rights reserved.
//

#import "OwnerSignatureVC.h"
#import "GJsignatureView.h"
#import "OwnerSignatureDetermineVC.h"
@interface OwnerSignatureVC ()<GetSignatureImageDele>
@property (weak, nonatomic) IBOutlet GJsignatureView *signatureView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation OwnerSignatureVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.signatureView.delegate = self;
    _backView.layer.cornerRadius = 8;
    [self showNaBar:2];
    [self setBarTitle:@"签名"];


}
- (IBAction)comfirmAction:(id)sender {
    [self.signatureView sure];

}
- (IBAction)cacelAction:(id)sender {
    [self.signatureView clear];
}

#pragma mark - 得到图片
-(void)getSignatureImg:(UIImage*)image
{
    NSLog(@"%@",image);
    if (image.size.width>0) {
    
        OwnerSignatureDetermineVC *qr=[[OwnerSignatureDetermineVC alloc]init];
        qr.signatureImg = image;
        qr.controllerModel = _controllerModel;
        [self.navigationController pushViewController:qr animated:YES];
        
    }else{
        [GJSVProgressHUD showErrorWithStatus:@"请签名"];
    }
}


@end
