//
//PPInspectDeviceModel.h 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPInspectDeviceModelPicture_list.h"
#import "PPInspectDeviceModelVideo_list.h"
#import "PPInspectDeviceModelProject_list.h"

@interface PPInspectDeviceModel:NSObject
@property (nonatomic,copy) NSArray<PPInspectDeviceModelVideo_list*> *video_list;
@property (nonatomic,copy) NSArray<PPInspectDeviceModelProject_list*> *project_list;
@property (nonatomic,copy) NSString *work_sheet_status;
@property (nonatomic,copy) NSString *device_no;
@property (nonatomic,copy) NSString *inspect_user_phone;
@property (nonatomic,copy) NSString *audio_rul;
@property (nonatomic,copy) NSString *inspect_count;
@property (nonatomic,copy) NSString *inspected_count;
@property (nonatomic,copy) NSArray<PPInspectDeviceModelPicture_list*> *picture_list;
@property (nonatomic,copy) NSString *inspect_user_name;
@property (nonatomic,copy) NSString *device_position;
@property (nonatomic,copy) NSString *device_name;
@property (nonatomic,copy) NSString *work_sheet_id;
@property (nonatomic,copy) NSString *device_id;
@property (nonatomic,copy) NSString *audio_second;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *inspect_time;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
//@property (nonatomic,copy) NSString *location_description;
@property (nonatomic,copy) NSString *community_name;
@end
