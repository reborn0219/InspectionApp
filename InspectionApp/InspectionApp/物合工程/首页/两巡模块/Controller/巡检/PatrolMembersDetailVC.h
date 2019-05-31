//
//  PatrolMembersDetailVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPBaseViewController.h"
#import "PPGroupInfoModel.h"

@interface PatrolMembersDetailVC : PPBaseViewController
-(void)requestData:(PPGroupInfoModelMember_list *)memberModel;
@end
