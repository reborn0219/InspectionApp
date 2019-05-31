//
//  PatrolFormCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPInspectDeviceModel.h"

@interface PatrolFormCell : UITableViewCell

-(void)assignmentWithModel:(PPInspectDeviceModelProject_list*)cellModel isSubmit:(BOOL)isSubmit;

@end
