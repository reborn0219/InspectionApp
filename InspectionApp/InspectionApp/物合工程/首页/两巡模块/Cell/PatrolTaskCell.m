//
//  PatrolTaskCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTaskCell.h"
#import "PPViewTool.h"
#import "ColorDefinition.h"
@interface PatrolTaskCell()
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLb;
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *status_label_w;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *communityNoLb;
@property (weak, nonatomic) IBOutlet UILabel *optionLb;
@property (nonatomic,strong)TaskListModel * cellModel;

@end
@implementation PatrolTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];;
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
    _optionView.clipsToBounds = YES;
    _optionView.layer.cornerRadius = 20;
    [_optionView.layer insertSublayer:[PPViewTool setGradualChangingColor:_optionView] atIndex:0];
    
    _stateView.clipsToBounds = YES;
    _stateView.layer.cornerRadius = 10;
    _cycleView.clipsToBounds = YES;
    _cycleView.layer.cornerRadius = 7.5;
    
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
//    _backView.clipsToBounds = NO;

}
-(void)assignmentWithModel:(TaskListModel *)model withType:(int)type{
    
    
    _cellModel = model;
    if ([model.task_cycle isEqualToString:@"1"]) {
        _cycleLb.text = @"每日";
    }else if ([model.task_cycle isEqualToString:@"2"]) {
        _cycleLb.text = @"每周";
    }else if ([model.task_cycle isEqualToString:@"3"]) {
        _cycleLb.text = @"每月";
    }else if ([model.task_cycle isEqualToString:@"4"]) {
        _cycleLb.text = @"每年";
    }
    
    if(self.pageType == PageOneTypeXunJian){
        _communityNoLb.text = [NSString stringWithFormat:@"%@个社区",model.community_number];

    }else{
        _communityNoLb.text = [NSString stringWithFormat:@"%@个社区",model.community_number];
    }
    
//    self.timeLb.text =[model.task_date substringToIndex:10] ;
    self.timeLb.text =[PPDateTool stringFormat:model.task_date];
    self.orderNoLb.text = model.task_no;
    self.titleLb.text = model.task_name;
    [_optionView setHidden:NO];
    switch (model.task_status.integerValue) {
            
        case OrderTypeUnStart:
        {
            _status_label_w.constant = 80;
            _statusLb.text = @"未到执行时间";
            self.stateView.backgroundColor = UN_START_COLOR;
            _optionLb.text = @"查看";
//            [_optionView setHidden:YES];
        }
            break;
        case OrderTypeUnOption:
        {
            _status_label_w.constant = 70;
            _statusLb.text = @"未开始执行";

            self.stateView.backgroundColor = UN_OPTION_COLOR;
            _optionLb.text = @"执行任务";
        }
            break;
        case OrderTypeOptioning:
        {
            _status_label_w.constant = 46;
            
            if (type == 2) {
            _statusLb.text = @"巡逻中";
            }else{
            _statusLb.text = @"巡查中";
            }
            self.stateView.backgroundColor = OPTIONING_COLOR;
            _optionLb.text = @"继续执行";

        }
            break;
        case OrderTypeOver:
        {
            _status_label_w.constant = 46;
            _statusLb.text = @"已结束";
            self.stateView.backgroundColor = OVER_COLOR;
            _optionLb.text = @"查看";

        }
            break;
            
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)optionAction:(id)sender {

    if (_tasklock) {
        _tasklock(_cellModel);
    }
}

@end
