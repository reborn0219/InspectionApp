//
//  PtrolMemberHeaderView.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PtrolMemberHeaderView.h"
@interface PtrolMemberHeaderView()
@property (nonatomic,strong) PPTaskDetailModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (weak, nonatomic) IBOutlet UILabel *titlelb;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLb;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *state_view_w;
@property (weak, nonatomic) IBOutlet UILabel *stateLb;

@end
@implementation PtrolMemberHeaderView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2;
    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_1 setHidden:NO];
    self.stateView.layer.cornerRadius = 10;
    self.cycleView.layer.cornerRadius = 7.5;
}
-(void)assignmentWithModel:(PPTaskDetailModel *)viewModel{
    _viewModel = viewModel;
    self.titlelb.text = viewModel.task_name;
    self.orderNoLb.text = viewModel.task_no;
    //    [_gradientArcChart setProgress:@"20" Inspection:@"5" Abnormal:@"17"];
    
    if ([viewModel.task_cycle isEqualToString:@"1"]) {
        _cycleLb.text = @"每日";
    }else if ([viewModel.task_cycle isEqualToString:@"2"]) {
        _cycleLb.text = @"每周";
    }else if ([viewModel.task_cycle isEqualToString:@"3"]) {
        _cycleLb.text = @"每月";
    }else if ([viewModel.task_cycle isEqualToString:@"4"]) {
        _cycleLb.text = @"每年";
    }
    self.numberLb.text = [NSString stringWithFormat:@"%ld个社区",(long)viewModel.community_list.count];

    
    self.timeLb.text = [PPDateTool stringFormat:viewModel.task_date];
    switch (viewModel.task_status.integerValue) {
            
        
        case OrderTypeOptioning:
        {
            _state_view_w.constant = 46;
            _stateLb.text = @"执行中";
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
- (IBAction)topBtnAction:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    [_btn_1 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_2 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_3 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    
    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_1 setHidden:YES];
    
    if (btn.tag == 100) {
        [_v_1 setHidden:NO];
        [_btn_1 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_block) {
            _block(nil,nil,0);
        }
        
    }else if (btn.tag == 101) {
        [_v_2 setHidden:NO];
        [_btn_2 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_block) {
            _block(nil,nil,5);
        }
    }else if (btn.tag == 102) {
        [_v_3 setHidden:NO];
        [_btn_3 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_block) {
            _block(nil,nil,6);
        }
    }
}
@end
