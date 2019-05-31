//
//  PatrolOrderCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"
#import "PPDeviceGroupModel.h"

@interface PatrolOrderCell : UITableViewCell
@property (nonatomic,copy) CellEventBlock block;
@property (nonatomic, assign)BOOL isPositionHidden;
-(void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model;
-(void)assignmentWithGroupModel:(PPDeviceGroupModel *)model;

@end
