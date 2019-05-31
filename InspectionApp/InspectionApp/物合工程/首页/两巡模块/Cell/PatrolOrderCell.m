//
//  PatrolOrderCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolOrderCell.h"
#import "LSCircularProgressView.h"
#import "ColorDefinition.h"

@interface PatrolOrderCell()

@property (weak, nonatomic) IBOutlet UIButton *possionBtn;
@property (weak, nonatomic) IBOutlet UILabel *communityNameLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong)LSCircularProgressView*  gradientArcChart;
@property (weak, nonatomic) IBOutlet UILabel *abnormalLb;
@property (weak, nonatomic) IBOutlet UILabel *inspectedLb;
@property (nonatomic ,retain)PPTaskDetailModelCommunity_list *cellModel;
@property (nonatomic ,retain)PPDeviceGroupModel *cellGroupModel;

@property (nonatomic,assign)NSInteger noStr;
@end

@implementation PatrolOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
    
    _gradientArcChart = [[LSCircularProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-35-80,48,80,80)];
    [self addSubview:_gradientArcChart];
    
}
-(void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model{
    if (_isPositionHidden) {
        [_possionBtn setHidden:YES];
    }
    _cellModel = model;
        [_gradientArcChart setProgress:model.device_number Inspection:model.inspected_number Abnormal:model.abnormal_number];
//    [_gradientArcChart setProgress:@"20" Inspection:@"5" Abnormal:@"17"];
    
    self.communityNameLb.text= model.community_name;
    self.abnormalLb.text = [NSString stringWithFormat:@"已巡检设备%@/%@",model.inspected_number,model.device_number];
    self.inspectedLb.text = [NSString stringWithFormat:@"%@个异常设备",model.abnormal_number];
    self.addressLb.text = model.community_position;
    
}
-(void)assignmentWithGroupModel:(PPDeviceGroupModel *)model{
    [_possionBtn setHidden:YES];
    _cellGroupModel = model;
    [_gradientArcChart setProgress:model.device_number Inspection:model.inspected_number Abnormal:model.abnormal_number];
    //    [_gradientArcChart setProgress:@"20" Inspection:@"5" Abnormal:@"17"];
    
    self.communityNameLb.text= model.group_name;
    self.abnormalLb.text = [NSString stringWithFormat:@"已巡组内设备%@/%@",model.inspected_number,model.device_number];
    self.inspectedLb.text = [NSString stringWithFormat:@"%@个异常设备",model.abnormal_number];
    self.addressLb.text = model.group_no;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)positionMapAction:(id)sender {
    //跳转地图定位
    if (_block) {
        _block(_cellModel,nil,nil);
    }
}

@end
