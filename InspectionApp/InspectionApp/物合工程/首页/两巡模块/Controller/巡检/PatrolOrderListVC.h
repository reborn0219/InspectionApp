//
//  PatrolOrderListVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPBaseViewController.h"
#import "PPTaskDetailModel.h"

@interface PatrolOrderListVC : PPBaseViewController
@property(nonatomic,copy)NSString *type;// 1巡检 2 巡查
@property(nonatomic,copy)NSString *work_id;
@property (nonatomic, strong)NSString  *task_id;
@property (nonatomic, strong)NSString *task_status;
@property (nonatomic, strong)PPTaskDetailModel  *controlerModel;
@end
