//
//  PPGuaranteeModel.m
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPGuaranteeModel.h"

@implementation PPGuaranteeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"guarantee_list" : [GuaranteeListModel class],
             };
    
}
@end
