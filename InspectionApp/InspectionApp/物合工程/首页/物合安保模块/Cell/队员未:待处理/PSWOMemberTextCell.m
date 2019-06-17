//
//  PSWOMemberTextCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOMemberTextCell.h"
@interface PSWOMemberTextCell()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;

@end
@implementation PSWOMemberTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(6, 0);
    self.backView.layer.shadowOpacity = 0.09;

}
- (IBAction)grabOrderAction:(id)sender {
    if (_block) {
        _block(nil);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
