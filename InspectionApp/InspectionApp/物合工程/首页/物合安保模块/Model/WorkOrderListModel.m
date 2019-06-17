//
//  WorkOrderListModel.m
//  InspectionApp
//
//  Created by guokang on 2019/6/10.
//  Copyright © 2019 yang. All rights reserved.
//

#import "WorkOrderListModel.h"

@implementation WorkOrderListModel
-(instancetype)init{
    self = [super init];
    if(self){
    }
    return self;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"repair_description":@"description"};
    
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"ivv_json" : [NewOrderModelIvv_json class],
             };
    
}
@end
