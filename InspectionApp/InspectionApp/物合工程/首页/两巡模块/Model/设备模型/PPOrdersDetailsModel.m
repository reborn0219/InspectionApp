//
//  PPOrdersDetailsModel.m
//  物联宝管家
//
//  Created by guokang on 2019/4/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPOrdersDetailsModel.h"

@implementation PPOrdersDetailsModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"picture_list" : [PPSubmitOrdersPicture_list class],
             @"video_list" : [PPSubmitOrdersVedio_list class],
             };
    
}

@end
