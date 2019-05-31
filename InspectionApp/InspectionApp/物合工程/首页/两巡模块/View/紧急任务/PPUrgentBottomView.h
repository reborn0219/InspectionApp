//
//  PPUrgentBottomView.h
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPUrgentBottomView : UIView

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property(nonatomic,copy)AlertBlock block;
-(void)assignmentWithModel:(TaskListModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
