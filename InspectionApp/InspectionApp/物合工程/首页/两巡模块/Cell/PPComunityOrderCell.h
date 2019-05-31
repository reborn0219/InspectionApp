//
//  PPComunityOrderCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/29.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPComunityOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UILabel *cycleLb;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
-(void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model;

@end

NS_ASSUME_NONNULL_END
