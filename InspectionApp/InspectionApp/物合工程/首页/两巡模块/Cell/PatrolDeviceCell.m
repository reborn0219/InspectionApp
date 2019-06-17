//
//  PatrolDeviceCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolDeviceCell.h"
@interface PatrolDeviceCell()
@property (nonatomic,strong) PPDeviceListModel *cellModel;

@end

@implementation PatrolDeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _stateBtn.layer.cornerRadius = 8;
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)assignmentWithModel:(PPDeviceListModel*)cellModel{
    _cellModel = cellModel;
    _deviceNameLb.text = cellModel.device_name;
    _deviceNoLb.text = cellModel.device_no;
    _deviceAdressLb.text = cellModel.device_position;
    
    _deviceCycleLb.text = [NSString stringWithFormat:@"%@/%@次巡查",cellModel.inspected_count,cellModel.inspect_count];

    if (cellModel.work_sheet_status.integerValue==2) {
        [_stateBtn setTitle:@"正常" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:OPTIONING_COLOR];
        _state_btn_w.constant = 32;

    }else  if (cellModel.work_sheet_status.integerValue == 3 || cellModel.work_sheet_status.integerValue == 4) {
        [_stateBtn setTitle:@"异常" forState:UIControlStateNormal];
        [_stateBtn setBackgroundColor:UN_START_COLOR];
        _state_btn_w.constant = 32;

    }else  if (cellModel.work_sheet_status.integerValue==1) {
        [_stateBtn setTitle:@"未巡查" forState:UIControlStateNormal];
        _state_btn_w.constant = 40;
        [_stateBtn setBackgroundColor:UN_OPTION_COLOR];
    }
}
@end
