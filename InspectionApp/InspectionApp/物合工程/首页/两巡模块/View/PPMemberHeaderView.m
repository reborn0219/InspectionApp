//
//  PPMemberHeaderView.m
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPMemberHeaderView.h"
#import "PPViewTool.h"
#import "LSCircularProgressView.h"

@interface PPMemberHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (nonatomic,strong)LSCircularProgressView*  gradientArcChart;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *abnormalLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *state_view_w;

@end
@implementation PPMemberHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2;
    _locationView.layer.cornerRadius = 20;
    [_locationView.layer insertSublayer:[PPViewTool setGradualChangingColor:_locationView withFrame:CGRectMake(0, 0, 120, 40) withCornerRadius:20] atIndex:0];
    self.stateView.layer.cornerRadius = 10;
    self.cycleView.layer.cornerRadius = 7.5;
    
//    _gradientArcChart = [[LSCircularProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-90,30,90,90)];
//    [self addSubview:_gradientArcChart];
}
-(void)assignmentWithModel:(PPTaskDetailModel *)model withType:(int)type{
    _viewModel = model;
    self.titlelb.text = model.task_name;
    self.orderNoLb.text = model.task_no;
//    [_gradientArcChart setProgress:@"20" Inspection:@"5" Abnormal:@"17"];
    self.abnormalLab.text = [NSString stringWithFormat:@"%@个异常设备",model.abnormal_number];
    if ([model.task_cycle isEqualToString:@"1"]) {
        _cycleLb.text = @"每日";
    }else if ([model.task_cycle isEqualToString:@"2"]) {
        _cycleLb.text = @"每周";
    }else if ([model.task_cycle isEqualToString:@"3"]) {
        _cycleLb.text = @"每月";
    }else if ([model.task_cycle isEqualToString:@"4"]) {
        _cycleLb.text = @"每年";
    }
   
    if (_type==1) {
        self.numberLb.text = [NSString stringWithFormat:@"%lu个巡查任务",(unsigned long)(long)model.community_list.count];
    }else{
        self.numberLb.text = [NSString stringWithFormat:@"%ld个社区",(long)model.community_list.count];
        
    }
    
    self.timeLb.text =[PPDateTool stringFormat:model.task_date];
    
    switch (model.task_status.integerValue) {
            
        case OrderTypeUnStart:
        {
            _state_view_w.constant = 80;
            _stateLb.text = @"未到执行时间";
            self.stateView.backgroundColor = UN_START_COLOR;
        }
            break;
        case OrderTypeUnOption:
        {
            _state_view_w.constant = 70;
            _stateLb.text = @"未开始执行";
            
            self.stateView.backgroundColor = UN_OPTION_COLOR;
        }
            break;
        case OrderTypeOptioning:
        {
            _state_view_w.constant = 46;
            if (type == 2) {
                _stateLb.text = @"巡逻中";
            }else{
                _stateLb.text = @"巡查中";
            }
         
            
            self.stateView.backgroundColor = OPTIONING_COLOR;
            
        }
            break;
        case OrderTypeOver:
        {
            _state_view_w.constant = 46;
            _stateLb.text = @"已结束";
            self.stateView.backgroundColor = OVER_COLOR;
            
        }
            break;
            
        default:
            break;
    }
}
@end
