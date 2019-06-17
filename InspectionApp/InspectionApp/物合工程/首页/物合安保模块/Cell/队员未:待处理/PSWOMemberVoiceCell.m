//
//  PSWOMemberVoiceCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOMemberVoiceCell.h"

@interface PSWOMemberVoiceCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@property (weak, nonatomic) IBOutlet UILabel *noVoiceLab;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *voiceTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *voiceBottomImage;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation PSWOMemberVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(6, 0);
    self.backView.layer.shadowOpacity = 0.09;

}
- (IBAction)grabWorkOrderAction:(id)sender {
    if (_block) {
        _block(nil,nil,1);
    }
}
- (IBAction)playVoiceAction:(id)sender {
    if (_block) {
        _block(nil,nil,2);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
