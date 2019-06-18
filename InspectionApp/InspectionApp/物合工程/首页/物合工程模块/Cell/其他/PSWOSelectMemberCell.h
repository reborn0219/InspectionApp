//
//  PSWOSelectMemberCell.h
//  InspectionApp
//
//  Created by guokang on 2019/6/2.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPCarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PSWOSelectMemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, copy)WorkAlertBlock block;
-(void)assignmentWithModel:(PPCarModel *)cellModel;
@end

NS_ASSUME_NONNULL_END
