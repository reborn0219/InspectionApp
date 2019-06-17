//
//  PSWOHeaderVideoCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/11.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOHeaderVideoCell.h"
#import "NewOrderModelIvv_json.h"

@interface PSWOHeaderVideoCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *memberLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomeViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageV;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong)NSArray  *videoArr;
@end
@implementation PSWOHeaderVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
    
    //    _memberLab.hidden =YES;
    //    _timeLabel.hidden = YES;
    //    _grabBtn.hidden = YES;
    //    _markBtn.hidden = YES;
}
- (NSArray *)videoArr
{
    if (!_videoArr) {
        _videoArr = [NSArray array];
    }
    return _videoArr;
}
-(void)assignmentWithModel:(WorkOrderListModel *)cellModel
{
    [super assignmentWithModel:cellModel];
    _orderNoLab.text = cellModel.repair_no;
    _stateLab.text =cellModel.repair_time;
    _memberLab.text =cellModel.repair_master_name;
    _timeLab.text = cellModel.post_time;
    NewOrderModelIvv_json *json = cellModel.ivv_json;
    NSDictionary *dict = [json.video objectAtIndex:0];
    [_videoImageV sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"video_img_ico"]]];
    if ([cellModel.repair_status isEqualToString:@"未处理"]) {
        //3视频，2语音，1图片，0文字
        self.memberLab.hidden = YES;
        self.timeLab.hidden = YES;
        if ([UserManager iscaptain].integerValue == 1) {
            //队长
            [self.grabBtn setTitle:@"分配工单" forState:(UIControlStateNormal)];
        }else{
            self.markBtn.hidden = YES;
            [self.grabBtn setTitle:@"抢单" forState:(UIControlStateNormal)];
        }
    }else if ([cellModel.repair_status isEqualToString:@"待处理"]){
        self.memberLab.hidden = YES;
        self.timeLab.hidden = YES;
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
        self.timeLab.hidden = NO;
        self.memberLab.hidden = NO;
    }else{
        //已处理/已完成
        self.bottomView.hidden = YES;
        self.bottomeViewHeight.constant = 0;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)markInvalidAction:(id)sender {
    if (super.block) {
        super.block(super.cellModel,WorkOrderAlertMarkInvalid);
    }
}
- (IBAction)grabOrderAction:(id)sender {
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
- (IBAction)playVideoAction:(id)sender {
    if (super.block) {
        super.block(super.cellModel,WorkOrderAlertPlayVedio);
    }
    
}

@end
