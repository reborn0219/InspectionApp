//
//  PSWODetailsQrCodeCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsQrCodeCell.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+Extension.h"
@interface PSWODetailsQrCodeCell()
@property (weak, nonatomic) IBOutlet UIImageView *QrCodeImage;

@end
@implementation PSWODetailsQrCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel{
    // 1.创建过滤器 -- 苹果没有将这个字符封装成常量
    
    if (cellModel==nil) {
        return;
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.过滤器恢复默认设置
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
    NSString *dataString = cellModel.repair_qrcode?:@"";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    self.QrCodeImage.image = [UIImage imageWithCIImage:outputImage];
    UIImage * img = [self.QrCodeImage.image createNonInterpolatedUIImageFormCIImage:outputImage withSize:SCREEN_WIDTH-120];
    self.QrCodeImage.image = img;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
