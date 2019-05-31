//
//  PatrolChangeRepairVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPBaseViewController.h"
#import "PPInspectDeviceModel.h"
#import "GuaranteeListModel.h"

@interface PatrolChangeRepairVC : PPBaseViewController

@property (nonatomic,strong) PPInspectDeviceModel *controlerModel;
@property (nonatomic, strong)NSArray *rightArr;
@property (nonatomic, strong)GuaranteeListModel  *guaranteeModel;

@end
