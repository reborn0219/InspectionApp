//
//  PPComunityOrderCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/29.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPComunityOrderCell.h"
@interface PPComunityOrderCell()
@property(nonatomic,strong)PPTaskDetailModelCommunity_list *cellModel;

@end
@implementation PPComunityOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.stateBtn.layer.cornerRadius = 8;
    _shadowView.layer.cornerRadius = 10;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
    
}
-(void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model{
//    _cellModel = model;
    if (model.work_sheet_status.integerValue == 6) {
        [_stateBtn setTitle:@"未巡查" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:UN_OPTION_COLOR];
    }else{
        [_stateBtn setTitle:@"已巡查" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:OVER_COLOR];
    }
    _titleLb.text = model.community_name;
    _contentLb.text = model.community_position;
    _cycleLb.text = [NSString stringWithFormat:@"%@/%@次巡查",model.patrolled_count?:@"0",model.patrol_count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
