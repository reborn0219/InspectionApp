//
//  PPOrderDetailView.h
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPOrdersDetailsModel.h"
@interface PPOrderDetailView : UIView
@property (nonatomic, copy)ViewsEventBlock  block;

-(void)assignmentWithModel:(PPOrdersDetailsModel *)model;

@end
