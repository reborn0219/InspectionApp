//
//  PPMemberHeaderView.h
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"

@interface PPMemberHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLb;
@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet UILabel *titlelb;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (nonatomic,assign)NSInteger type;
@property(nonatomic,strong)PPTaskDetailModel *viewModel;
-(void)assignmentWithModel:(PPTaskDetailModel *)model withType:(int)type;
@end
