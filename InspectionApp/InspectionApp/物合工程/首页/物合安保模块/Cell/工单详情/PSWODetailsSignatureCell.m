//
//  PSWODetailsSignatureCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsSignatureCell.h"
@interface PSWODetailsSignatureCell()
@property (weak, nonatomic) IBOutlet UIImageView *signatureImage;


@end
@implementation PSWODetailsSignatureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel
{
    if (cellModel) {
        NSString * autograph = cellModel.repaird.autograph;
//        autograph = [NSString stringWithFormat:@"%@%@",URL_PIC,autograph];
        [_signatureImage sd_setImageWithURL:[NSURL URLWithString:autograph]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
