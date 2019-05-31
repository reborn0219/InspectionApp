//
//  PPSubmitOrdersModel.m
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPSubmitOrdersModel.h"

@implementation PPSubmitOrdersModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"project_list" : [PPSubmitOrdersProject_list class],
             @"video_list" : [PPSubmitOrdersVedio_list class],
             };
    
}
@end
