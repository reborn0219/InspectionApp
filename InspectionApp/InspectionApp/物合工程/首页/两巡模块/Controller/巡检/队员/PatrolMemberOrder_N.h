//
//  PatrolMemberOrder_N.h
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTaskMapVC.h"
#import "Masonry.h"
#import "PPDeviceGroupModel.h"

@interface PatrolMemberOrder_N : PatrolTaskMapVC
@property (nonatomic, strong)NSString  *work_id;
@property (nonatomic, strong)NSString  *group_id;
@property (nonatomic, strong)PPDeviceGroupModel  *controllerModel;

@end
