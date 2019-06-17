//
//  PSWOSelectMemberCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/2.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOSelectMemberCell.h"
@interface PSWOSelectMemberCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic, strong)PPCarModel  *cellModel;
@end
@implementation PSWOSelectMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"未选中-圈"] forState:(UIControlStateSelected)];
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"选中-圈"] forState:(UIControlStateNormal)];
   
}
-(void)assignmentWithModel:(PPCarModel *)cellModel
{
    _cellModel = cellModel;
    self.nameLab.text = cellModel.ture_name;
}
- (IBAction)selectMemberAction:(id)sender {
    if (_block) {
        _block(_cellModel.user_id,WorkOrderAlertSelectMember);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
