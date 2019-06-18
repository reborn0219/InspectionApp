//
//  PSWorkOrderDetailsCell.h
//  InspectionApp
//
//  Created by guokang on 2019/6/2.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSWorkOrderDetailsCell : WorkOrderBaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailsLab;

@end

NS_ASSUME_NONNULL_END
