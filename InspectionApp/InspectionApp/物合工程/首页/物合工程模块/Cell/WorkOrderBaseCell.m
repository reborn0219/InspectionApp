//
//  WorkOrderBaseCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/10.
//  Copyright © 2019 yang. All rights reserved.
//

#import "WorkOrderBaseCell.h"
@interface WorkOrderBaseCell ()
@end

@implementation WorkOrderBaseCell

-(void)assignmentWithModel:(NSObject*)cellModel
{
    _cellModel = cellModel;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
