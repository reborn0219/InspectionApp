//
//  PSWODetailsListCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsListCell.h"
@interface PSWODetailsListCell()


@end
@implementation PSWODetailsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(NSArray *)cellModel
{
    NSString * title = cellModel.firstObject;
    NSString * content = cellModel.lastObject;
    _leftLab.text = title;
    _rightLab.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
