//
//  PSWOMemberImageCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOMemberImageCell.h"
@interface PSWOMemberImageCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageV;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation PSWOMemberImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(6, 0);
    self.backView.layer.shadowOpacity = 0.09;

}
- (IBAction)graoWorkOrderAction:(id)sender {
    if (_block) {
        _block(nil);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
