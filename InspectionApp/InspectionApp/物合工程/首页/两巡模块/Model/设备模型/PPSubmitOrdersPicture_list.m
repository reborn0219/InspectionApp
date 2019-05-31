//
//  PPSubmitOrdersPicture_list.m
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPSubmitOrdersPicture_list.h"

@implementation PPSubmitOrdersPicture_list
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"picture_path" :@"picture_url",
              @"pic_path" :@"picture_url",
             };
    
}
@end
