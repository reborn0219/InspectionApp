//
//UrgenttaskDetailModel.m 
//
//
//Create by yang on 19/4/11 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import "UrgenttaskDetailModel.h"
@implementation UrgenttaskDetailModel

-(instancetype)init{
	self = [super init];
	if(self){

	}
	return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             @"picture_list" : [UrgenttaskDetailModelPicture_list class],
             @"video_list" : [UrgenttaskDetailModelVideo_list class],
             };
    
}
@end
