//
//  PSBasicWorkOrderVC.h
//  InspectionApp
//
//  Created by guokang on 2019/5/31.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNoDataView.h"


NS_ASSUME_NONNULL_BEGIN

@interface PSBasicWorkOrderVC : UIViewController
@property (nonatomic, strong)PPNoDataView  *noDataView;
@property (nonatomic, assign)NSInteger orderType;
- (void)requestDataWithOrderType:(NSInteger)orderType;
@end

NS_ASSUME_NONNULL_END
