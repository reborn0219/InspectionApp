//
//  PPmemberScanHeaderView.h
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModelCommunity_list.h"
#import "PPDeviceGroupModel.h"

@interface PPmemberScanHeaderView : UIView
@property (nonatomic, copy)ViewsEventBlock eventBlock;
-(void)isTeam;
-(void)hiddenBottomView:(BOOL)hidden;
- (void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model;
- (void)assignmentWithGroupModel:(PPDeviceGroupModel *)model;
@end
