//
//  PPOrderHeaderView.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPOrderHeaderView.h"
#import "PPViewTool.h"
#import "ColorDefinition.h"
#import "CATCurveProgressView.h"
#import "LSCircularProgressView.h"

@interface PPOrderHeaderView()<CATCurveProgressViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeLb;//时间
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statueView_w;
@property (weak, nonatomic) IBOutlet UILabel *statueLb;
@property (weak, nonatomic) IBOutlet UILabel *equipmentNoLb;//设备数
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *taskNoLb;
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UIView *taskLocationView;
@property (weak, nonatomic) IBOutlet UIButton *teamBtn;
@property (weak, nonatomic) IBOutlet UILabel *abnormalLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *state_view_w;

@property (nonatomic,strong)PPTaskDetailModel * viewModel;
@property (nonatomic,strong)LSCircularProgressView*  gradientArcChart;
@property (nonatomic,assign)NSInteger noStr;
@end

@implementation PPOrderHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];

    
    _taskLocationView.clipsToBounds = YES;
    _taskLocationView.layer.cornerRadius = 20;
    [_taskLocationView.layer insertSublayer:[PPViewTool setGradualChangingColor:_taskLocationView] atIndex:0];
    
    _teamBtn.clipsToBounds = YES;
    _teamBtn.layer.cornerRadius = 20;
    
    _stateView.clipsToBounds = YES;
    _stateView.layer.cornerRadius = 10;
    _cycleView.clipsToBounds = YES;
    _cycleView.layer.cornerRadius = 7.5;
    
    self.layer.cornerRadius = 10;
    self.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2;
    
    _gradientArcChart = [[LSCircularProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-90,30,90,90)];
    [self addSubview:_gradientArcChart];

    
}

-(void)assignmentWithModel:(PPTaskDetailModel *)model Type:(NSInteger)type{

    _viewModel = model;
//    [_gradientArcChart setProgress:@"20" Inspection:@"5" Abnormal:@"17"];

    if ([model.task_cycle isEqualToString:@"1"]) {
        _cycleLb.text = @"每日";
    }else if ([model.task_cycle isEqualToString:@"2"]) {
        _cycleLb.text = @"每周";
    }else if ([model.task_cycle isEqualToString:@"3"]) {
        _cycleLb.text = @"每月";
    }else if ([model.task_cycle isEqualToString:@"4"]) {
        _cycleLb.text = @"每年";
    }
    if (type == 2) {
        self.abnormalLabel.hidden = YES;
    }else{
     self.abnormalLabel.text = [NSString stringWithFormat:@"%@个设备异常",model.abnormal_number];
    }
    self.titleLb.text= model.task_name;
    self.taskNoLb.text = model.task_no;
    if (type==1) {
        self.equipmentNoLb.text = [NSString stringWithFormat:@"共有%@个设备",model.device_number];
        [_gradientArcChart setProgress:model.device_number Inspection:model.inspected_number Abnormal:model.abnormal_number];

    }else{
        self.equipmentNoLb.text = [NSString stringWithFormat:@"%@个社区",model.community_number];
        [_gradientArcChart setProgress:model.community_number Inspection:model.patrolled_number Abnormal:@"0"];

    }

//    self.timeLb.text =[model.task_date substringToIndex:10];
    self.timeLb.text = [PPDateTool stringFormat:model.task_date];
    
    switch (model.task_status.integerValue) {
            
        case OrderTypeUnStart:
        {
            _state_view_w.constant = 80;
            _statueLb.text = @"未到执行时间";
            self.stateView.backgroundColor = UN_START_COLOR;
        }
            break;
        case OrderTypeUnOption:
        {
            _state_view_w.constant = 70;
            _statueLb.text = @"未开始执行";
            
            self.stateView.backgroundColor = UN_OPTION_COLOR;
        }
            break;
        case OrderTypeOptioning:
        {
            _state_view_w.constant = 46;
            if (type == 2) {
              _statueLb.text = @"巡查中";
            }else{
              _statueLb.text = @"巡检中";
            }
           
            
            self.stateView.backgroundColor = OPTIONING_COLOR;
            
        }
            break;
        case OrderTypeOver:
        {
            _state_view_w.constant = 46;
            _statueLb.text = @"已结束";
            self.stateView.backgroundColor = OVER_COLOR;
            
        }
            break;
            
        default:
            break;
    }
}
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        _taskLocationView.clipsToBounds = YES;
//        _taskLocationView.layer.cornerRadius = 20;
//        [_taskLocationView.layer insertSublayer:[PPViewTool setGradualChangingColor:_taskLocationView] atIndex:0];
//        
//        _teamBtn.clipsToBounds = YES;
//        _teamBtn.layer.cornerRadius = 20;
//        
//        _stateView.clipsToBounds = YES;
//        _stateView.layer.cornerRadius = 10;
//        _cycleView.clipsToBounds = YES;
//        _cycleView.layer.cornerRadius = 7.5;
//        
//        self.layer.cornerRadius = 10;
//        self.layer.shadowColor = SHADOW_COLOR.CGColor;
//        self.layer.shadowOffset = CGSizeMake(0,0);
//        self.layer.shadowOpacity = 0.2;
//        self.layer.shadowRadius = 2;
//    }
//    return self;
//}

- (IBAction)teamDetailAction:(id)sender {
    ///小组详情
    if (_block) {
        _block(1);
    }
}

- (IBAction)TaskLocationAction:(id)sender {
    ///任务位置
    if (_block) {
        _block(2);
    }
}

@end
