//
//  PtrolMemberHeaderView.h
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"

@interface PtrolMemberHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UIView *v_3;
@property (weak, nonatomic) IBOutlet UIView *v_1;
@property (weak, nonatomic) IBOutlet UIView *v_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_3;
@property (nonatomic,copy) ViewsEventBlock block;

-(void)assignmentWithModel:(PPTaskDetailModel *)viewModel;
@end
