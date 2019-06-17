//
//  PSWOHandlingTextCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHandlingTextCell.h"
@interface PSWOHandlingTextCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@end
@implementation PSWOHandlingTextCell

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
    self.nameLab.hidden = isHidden;
    self.dateLab.hidden = isHidden;
    if (isHidden == YES) {
        self.bottomHeight.constant = 14;
    }else{
      self.bottomHeight.constant = 56;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
