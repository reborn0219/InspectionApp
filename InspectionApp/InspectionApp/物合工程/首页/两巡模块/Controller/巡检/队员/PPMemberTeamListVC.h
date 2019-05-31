//
//  PPMemberTeamListVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTaskMapVC.h"
#import "PPTaskDetailModelCommunity_list.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPMemberTeamListVC : PatrolTaskMapVC
@property (nonatomic, strong)NSString *community_id;
@property (nonatomic, strong)NSString *work_id;
@property (nonatomic, strong)PPTaskDetailModelCommunity_list  *controllerModel;
@end

NS_ASSUME_NONNULL_END
