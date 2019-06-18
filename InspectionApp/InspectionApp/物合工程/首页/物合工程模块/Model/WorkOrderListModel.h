//
//  WorkOrderListModel.h
//  InspectionApp
//
//  Created by guokang on 2019/6/10.
//  Copyright © 2019 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewOrderModelIvv_json.h"

@interface WorkOrderListModel : NSObject
@property (nonatomic,copy) NSString *repair_time;
@property (nonatomic,copy) NSString *repair_no;
@property (nonatomic,copy) NSString *repair_description;
@property (nonatomic,strong) NewOrderModelIvv_json *ivv_json;
@property (nonatomic, copy)NSString  *post_time;
@property (nonatomic, copy)NSString  *repair_master_name;
@property (nonatomic, copy)NSString  *ivv_type;
@property (nonatomic, copy)NSString  *repair_status;
@property (nonatomic, copy)NSString  *repair_id;
@property (nonatomic, copy)NSString  *work_remarks;
@property (nonatomic, copy)NSString  *security_id;
@end

