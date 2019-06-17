//
//  OwnerSignatureDetermineVC.h
//  InspectionApp
//
//  Created by yang on 2019/6/13.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PPBaseViewController.h"
#import "OrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OwnerSignatureDetermineVC : PPBaseViewController

@property (nonatomic,strong) UIImage *signatureImg;
@property (nonatomic,strong) OrderDetailModel *controllerModel;


@end

NS_ASSUME_NONNULL_END
