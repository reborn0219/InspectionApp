//
//PPGroupInfoModel.m 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "PPGroupInfoModel.h"
@implementation PPGroupInfoModel

-(instancetype)init{
	self = [super init];
	if(self){

	}
	return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"member_list" : [PPGroupInfoModelMember_list class],
             @"tool_list" : [PPGroupInfoModelTool_list class],
             };
    
}
@end
