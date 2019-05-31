//
//  PatrolDeviceCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewTool.h"
#import "PPDeviceListModel.h"

@interface PatrolDeviceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *state_btn_w;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceNoLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceAdressLb;
@property (weak, nonatomic) IBOutlet UILabel *deviceCycleLb;
-(void)assignmentWithModel:(PPDeviceListModel*)cellModel;
@end
