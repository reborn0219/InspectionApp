//
//  PSWODetailsDescriptionCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsDescriptionCell.h"
@interface PSWODetailsDescriptionCell()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLab;
@end
@implementation PSWODetailsDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel{
    _descriptionLab.text = cellModel.repair_description?:@"暂无";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
