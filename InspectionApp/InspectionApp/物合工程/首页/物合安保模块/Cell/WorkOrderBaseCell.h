//
//  WorkOrderBaseCell.h
//  InspectionApp
//
//  Created by guokang on 2019/6/10.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkOrderListModel.h"
#import "OrderDetailModel.h"

@interface WorkOrderBaseCell : UITableViewCell
@property (nonatomic, strong)NSObject *cellModel;
-(void)assignmentWithModel:(NSObject*)cellModel;

@property (nonatomic, copy)WorkAlertBlock block;
@end

