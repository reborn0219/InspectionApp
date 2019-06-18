//
//  PSWODetailsHeaderCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsHeaderCell.h"
@interface PSWODetailsHeaderCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@end
@implementation PSWODetailsHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel{
    _nameLabel.text = cellModel.member_name;
    _addressLab.text = cellModel.position;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
