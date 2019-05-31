//
//  PatrolUrgentTasksCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolUrgentTasksCell.h"
@interface PatrolUrgentTasksCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLb;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet UILabel *communityNoLb;
@property (nonatomic,strong)TaskListModel * cellModel;

@end
@implementation PatrolUrgentTasksCell

- (void)awakeFromNib {
    [super awakeFromNib];;
    self.backgroundColor = [UIColor clearColor];
    _stateView.clipsToBounds = YES;
    _stateView.layer.cornerRadius = 10;
    _backView.layer.cornerRadius = 10;
    _backView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backView.layer.shadowOffset = CGSizeMake(0,0);
    _backView.layer.shadowOpacity = 0.2;
    _backView.layer.shadowRadius = 2;
}
//
//-(void)setType:(OrderType)type{
//    _type = type;
//    _stateLb.text = @"未执行";
//
//    switch (_type) {
//        case OrderTypeAll:
//            {
//
//            }
//            break;
//        case OrderTypeUnStart:
//        {
//
//        }
//            break;
//        case OrderTypeUnOption:
//        {
//            _stateView.backgroundColor = UN_OPTION_COLOR;
//            _stateLb.text = @"未执行";
//        }
//            break;
//        case OrderTypeOptioning:
//        {
//            _stateView.backgroundColor = OPTIONING_COLOR;
//            _stateLb.text = @"执行中";
//
//        }
//            break;
//        case OrderTypeOver:
//        {
//            _stateView.backgroundColor = OVER_COLOR;
//            _stateLb.text = @"已结束";
//
//        }
//            break;
//        default:
//            break;
//    }
//   
//}
-(void)assignmentWithModel:(TaskListModel *)model{
    _cellModel = model;
 
    _communityNoLb.text = model.dispatch_user_name;
//    self.timeLb.text = model.task_date;
    self.timeLb.text = [PPDateTool stringFormat:model.task_date];
    self.orderNoLb.text = model.task_no;
    self.titleLb.text = model.task_name;
    
    
    if (model.task_status.integerValue == 1) {
        [_stateView setBackgroundColor:UN_OPTION_COLOR];
        _stateLb.text = @"未执行";
    }else if (model.task_status.integerValue == 2) {
        [_stateView setBackgroundColor:OPTIONING_COLOR];
        _stateLb.text = @"执行中";
    }else if (model.task_status.integerValue == 3) {
        [_stateView setBackgroundColor:OVER_COLOR];
        _stateLb.text = @"已结束";
    }
//    switch (model.task_status.integerValue) {
//
//        case OrderTypeUnStart:
//        {
//            _stateLb.text = @"未到执行时间";
//            self.stateView.backgroundColor = UN_START_COLOR;
//        }
//            break;
//        case OrderTypeUnOption:
//        {
//            _stateLb.text = @"未开始执行";
//            self.stateView.backgroundColor = UN_OPTION_COLOR;
//
//        }
//            break;
//        case OrderTypeOptioning:
//        {
//            _stateLb.text = @"执行中";
//
//            self.stateView.backgroundColor = OPTIONING_COLOR;
//
//
//        }
//            break;
//        case OrderTypeOver:
//        {
//            _stateLb.text = @"已结束";
//            self.stateView.backgroundColor = OVER_COLOR;
//
//        }
//            break;
//
//        default:
//            break;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
