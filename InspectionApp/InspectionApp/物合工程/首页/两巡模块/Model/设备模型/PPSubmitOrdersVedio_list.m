//
//  PPSubmitOrdersVedio_list.m
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPSubmitOrdersVedio_list.h"

@implementation PPSubmitOrdersVedio_list
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"video_path" :@"video_url",
             @"img_path" :@"img_url",
             };
    
}
@end
