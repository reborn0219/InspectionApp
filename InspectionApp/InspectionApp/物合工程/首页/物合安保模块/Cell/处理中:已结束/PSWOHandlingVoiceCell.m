//
//  PSWOHandlingVoiceCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHandlingVoiceCell.h"
@interface PSWOHandlingVoiceCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *noVoiceLab;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIImageView *voiceTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *voiceBottomImage;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation PSWOHandlingVoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(6, 0);
    self.backView.layer.shadowOpacity = 0.09;

}
- (IBAction)playVoiceAction:(id)sender {
}
- (void)setIsHidden:(BOOL)isHidden
{
    self.dateLab.hidden = isHidden;
    self.nameLabel.hidden = isHidden;
    if (isHidden == YES) {
    self.bottomHeight.constant = 16;
    }else{
      self.bottomHeight.constant = 50;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
