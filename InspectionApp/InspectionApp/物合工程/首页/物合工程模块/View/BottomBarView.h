//
//  BottomBarView.h
//  InspectionApp
//
//  Created by yang on 2019/6/13.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomBarView : UIView
@property (nonatomic,copy)WorkAlertBlock block;
@property (nonatomic, assign)WorkOrderType type;
- (void)assginmentWithType:(WorkOrderType)type;
@end

NS_ASSUME_NONNULL_END
