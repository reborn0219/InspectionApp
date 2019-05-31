//
//  PatrolUrgentTasksCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListModel.h"


@interface PatrolUrgentTasksCell : UITableViewCell

@property (nonatomic,copy)TaskCellBlock tasklock;
-(void)assignmentWithModel:(TaskListModel *)model;

@property(nonatomic,assign)OrderType type;

@end
