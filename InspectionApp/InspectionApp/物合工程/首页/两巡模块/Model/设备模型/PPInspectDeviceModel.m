//
//PPInspectDeviceModel.m 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "PPInspectDeviceModel.h"
@implementation PPInspectDeviceModel

-(instancetype)init{
	self = [super init];
	if(self){

	}
	return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"picture_list" : [PPInspectDeviceModelPicture_list class],
             @"project_list" : [PPInspectDeviceModelProject_list class],
             @"video_list" : [PPInspectDeviceModelVideo_list class],
             };
    
}
@end
