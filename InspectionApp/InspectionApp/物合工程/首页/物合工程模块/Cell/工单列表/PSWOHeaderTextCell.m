//
//  PSWOHeaderTextCell.m
//  InspectionApp
//
//  Created by guokang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHeaderTextCell.h"
@interface PSWOHeaderTextCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;


@property (weak, nonatomic) IBOutlet UILabel *memberLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@end
@implementation PSWOHeaderTextCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
    _bottomView.userInteractionEnabled = YES;
    _backView.userInteractionEnabled = YES;

}
-(void)assignmentWithModel:(WorkOrderListModel *)cellModel
{
    [super assignmentWithModel:cellModel];
    _orderNoLab.text = cellModel.repair_no;
    _stateLab.text =cellModel.repair_time;
   _detailsLab.text =cellModel.repair_description;
    
    _memberLab.text =[NSString stringWithFormat:@"维修人员：%@",cellModel.repair_master_name];

    _timeLabel.text = cellModel.post_time;
    if ([cellModel.repair_status isEqualToString:@"未处理"]) {
      
        self.memberLab.hidden = YES;
        self.timeLabel.hidden = YES;
        if ([UserManager iscaptain].integerValue == 1) {
            //队长
            [self.grabBtn setTitle:@"分配工单" forState:(UIControlStateNormal)];
        }else{
            self.markBtn.hidden = YES;
             [self.grabBtn setTitle:@"抢单" forState:(UIControlStateNormal)];
        }
    }else if ([cellModel.repair_status isEqualToString:@"待处理"]){
        self.memberLab.hidden = YES;
        self.timeLabel.hidden = YES;
        if ([UserManager iscaptain].integerValue == 1) {
            //队长
            [self.grabBtn setTitle:@"转移工单" forState:(UIControlStateNormal)];
        }else{
            //队员
            [self.grabBtn setTitle:@"处理工单" forState:(UIControlStateNormal)];
        }
    }else if ([cellModel.repair_status isEqualToString:@"处理中"]){
        //处理中
        self.markBtn.hidden = YES;
        self.grabBtn.hidden = YES;
        self.stateLab.hidden = YES;
        self.timeLabel.hidden = NO;
        self.memberLab.hidden = NO;
    }else{
        //已处理/已完成
        self.bottomView.hidden = YES;
        self.bottomViewHeight.constant = 0;
    }

}
- (IBAction)markInvalidAction:(id)sender {
    if (super.block) {
        super.block(super.cellModel,WorkOrderAlertMarkInvalid);
    }
}

- (IBAction)distributeWorkOrderAction:(id)sender {
    
    WorkOrderListModel *model = (WorkOrderListModel *)super.cellModel;
    if (super.block) {
        if ([model.repair_status isEqualToString:@"未处理"]) {
            if ([UserManager iscaptain].integerValue == 1) {
                super.block(super.cellModel,WorkOrderAlertDistribute);
            }else{
                super.block(super.cellModel,WorkOrderAlertGrab);
                 self.markBtn.hidden = YES;
            }
        }else if ([model.repair_status isEqualToString:@"待处理"]) {
            if ([UserManager iscaptain].integerValue == 1) {
                super.block(super.cellModel,WorkOrderAlertTranform);
            }else{
                //处理工单
                super.block(super.cellModel,WorkOrderAlertHandle);
            }
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
