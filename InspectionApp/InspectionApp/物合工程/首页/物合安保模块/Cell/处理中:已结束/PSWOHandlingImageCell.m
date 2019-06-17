//
//  PSWOHandlingImageCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHandlingImageCell.h"
@interface PSWOHandlingImageCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomHeight;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
@implementation PSWOHandlingImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(6, 0);
    self.backView.layer.shadowOpacity = 0.09;

}
- (void)setIsHidden:(BOOL)isHidden
{
    self.nameLabel.hidden = isHidden;
    self.dateLabel.hidden = isHidden;
    if (isHidden == YES) {
        self.imageBottomHeight.constant = 18;
    }else{
          self.imageBottomHeight.constant = 50;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
