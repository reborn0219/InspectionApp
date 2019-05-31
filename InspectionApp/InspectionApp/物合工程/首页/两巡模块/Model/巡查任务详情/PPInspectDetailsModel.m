//
//PPInspectDetailsModel.m 
//
//
//Create by yang on 19/4/26 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "PPInspectDetailsModel.h"
@implementation PPInspectDetailsModel

-(instancetype)init{
	self = [super init];
	if(self){
	}
	return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"picture_list" : [PPInspectDetailsModelPicture_list class],
             };
    
}
@end
