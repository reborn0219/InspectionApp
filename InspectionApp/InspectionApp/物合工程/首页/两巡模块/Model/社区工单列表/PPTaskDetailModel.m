//
//PPTaskDetailModel.m 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "PPTaskDetailModel.h"
@implementation PPTaskDetailModel

-(instancetype)init{
	self = [super init];
	if(self){

	}
	return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"member_list" : [PPTaskDetailModelMember_list class],
             @"community_list" : [PPTaskDetailModelCommunity_list class],
             };
    
}

@end
