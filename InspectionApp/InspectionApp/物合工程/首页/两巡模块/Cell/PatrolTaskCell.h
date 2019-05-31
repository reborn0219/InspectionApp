//
//  PatrolTaskCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockDefinition.h"
#import "TaskListModel.h"
@interface PatrolTaskCell : UITableViewCell

@property (nonatomic,copy)AlertBlock block;
@property (nonatomic,copy)TaskCellBlock tasklock;
@property(nonatomic,assign)PageOneType  pageType;

-(void)assignmentWithModel:(TaskListModel *)model withType:(int)type;
@end
