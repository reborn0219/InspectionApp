//
//  PatrolMembersCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGroupInfoModel.h"

@interface PatrolMembersCell : UITableViewCell
-(void)setTeamOwner:(BOOL)isOwner;
-(void)assignmentWithModel:(PPGroupInfoModelMember_list *)model;
@end
