//
//PPInspectDetailsModel.h 
//
//
//Create by yang on 19/4/26 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPInspectDetailsModelPicture_list.h"

@interface PPInspectDetailsModel:NSObject
@property (nonatomic,copy) NSString *community_position;
@property (nonatomic,copy) NSString *patrol_count;
@property (nonatomic,copy) NSArray *video_list;
@property (nonatomic,copy) NSString *patrol_user_phone;
@property (nonatomic,copy) NSString *work_sheet_status;
@property (nonatomic,copy) NSString *audio_url;
@property (nonatomic,copy) NSString *audio_length;
@property (nonatomic,copy) NSArray<PPInspectDetailsModelPicture_list *> *picture_list;
@property (nonatomic,copy) NSString *patrol_result;
@property (nonatomic,copy) NSString *community_name;
@property (nonatomic,copy) NSString *community_id;
@property (nonatomic,copy) NSString *patrol_user_name;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *work_sheet_id;
@property (nonatomic,copy) NSString *patrolled_count;

@end
