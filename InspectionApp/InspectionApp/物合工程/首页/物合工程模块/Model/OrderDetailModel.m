//
//OrderDetailModel.m 
//
//
//Create by yang on 19/6/11 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "OrderDetailModel.h"
@implementation OrderDetailModel

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
             @"repaird" : [OrderDetailModelRepaird class],
             @"ivv_json" : [NewOrderModelIvv_json class],
             };
    
}
@end
