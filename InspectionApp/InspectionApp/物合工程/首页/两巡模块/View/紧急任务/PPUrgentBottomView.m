//
//  PPUrgentBottomView.m
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPUrgentBottomView.h"
#import "PPViewTool.h"

@interface PPUrgentBottomView()
@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIButton *teamBtn;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *taskTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *urgentNameLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *markLb;

@end
@implementation PPUrgentBottomView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    _topLineView.layer.cornerRadius = 2;
    _stateView.layer.cornerRadius = 10;
    _teamBtn.layer.cornerRadius = 4;
    _topView.layer.cornerRadius = 10;
    _topView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _topView.layer.shadowOffset = CGSizeMake(0,0);
    _topView.layer.shadowOpacity = 0.2;
    _topView.layer.shadowRadius = 2;
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.topView addGestureRecognizer:recognizer];

}

- (void)handleSwipe:(UIPanGestureRecognizer *)swipe {
    if (swipe.state == UIGestureRecognizerStateChanged) {
        [self commitTranslation:[swipe translationInView:self]];
    
    }
}
- (void)commitTranslation:(CGPoint)translation {
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y); // 设置滑动有效距离
    if (MAX(absX, absY) < 10)
        return;
    if (absX > absY ) {
        if (translation.x<0) {
            //向左滑动
            
        }
        else{
            //向右滑动
            
        }
        
    } else if (absY > absX) {
        if (translation.y<0) {
            //向上滑动
            if (_block) {
                _block(0);
            }
            
            
        }
        else{
            //向下滑动
            if (_block) {
                
                _block(1);
            }
        }
        
    }
    
}
-(void)assignmentWithModel:(TaskListModel *)viewModel{
    
    _titleLb.text = viewModel.task_name;
//    _timeLb.text = viewModel.task_date;
    _timeLb.hidden = YES;
    _orderNo.text = viewModel.task_no;
    if (viewModel.task_object.integerValue==1) {
        [_teamBtn setTitle:@"组" forState:UIControlStateNormal];
    }else{
        [_teamBtn setTitle:@"人" forState:UIControlStateNormal];
    }
    _taskTimeLb.text = viewModel.task_date;
    _urgentNameLb.text = viewModel.dispatch_user_name;
    _addressLb.text = viewModel.dispatch_position;
    _markLb.text = viewModel.dispatch_remark;
    
    if (viewModel.task_status.integerValue == 0) {
        
    }else if (viewModel.task_status.integerValue == 1) {
        [_stateView setBackgroundColor:UN_OPTION_COLOR];
        _stateLb.text = @"未执行";
    }else if (viewModel.task_status.integerValue == 2) {
        [_stateView setBackgroundColor:OPTIONING_COLOR];
        _stateLb.text = @"执行中";
    }else if (viewModel.task_status.integerValue == 3) {
        [_stateView setBackgroundColor:OVER_COLOR];
        _stateLb.text = @"已结束";
    }
}
@end
