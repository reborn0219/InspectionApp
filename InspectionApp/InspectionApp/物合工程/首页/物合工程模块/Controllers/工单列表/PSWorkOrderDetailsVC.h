//
//  PSWorkOrderDetailsVC.h
//  InspectionApp
//
//  Created by guokang on 2019/6/9.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PSWorkOrderDetailsVC : PPBaseViewController
@property (nonatomic,copy) NSString *repair_id;
@property (nonatomic, assign)WorkOrderType  type;
@end

NS_ASSUME_NONNULL_END
