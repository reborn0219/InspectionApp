//
//UrgenttaskDetailModel.h 
//
//
//Create by yang on 19/4/11 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UrgenttaskDetailModelPicture_list.h"
#import "UrgenttaskDetailModelVideo_list.h"

@interface UrgenttaskDetailModel:NSObject
@property (nonatomic,copy) NSString *task_name;
@property (nonatomic,copy) NSString *audio_url;
@property (nonatomic,copy) NSString *task_id;
@property (nonatomic,copy) NSString *task_date;
@property (nonatomic,copy) NSString *work_id;
@property (nonatomic,copy) NSString *work_sheet_id;
@property (nonatomic,copy) NSString *dispatch_position;
@property (nonatomic,copy) NSString *dispatch_user_name;
@property (nonatomic,copy) NSString *exec_finish_date;
@property (nonatomic,copy) NSString *task_object;
@property (nonatomic,copy) NSString *task_start_date;
@property (nonatomic,copy) NSString *task_status;
@property (nonatomic,copy) NSString *dispatch_remark;
@property (nonatomic,copy) NSString *exec_user_name;
@property (nonatomic,copy) NSArray<UrgenttaskDetailModelPicture_list*> *picture_list;
@property (nonatomic,copy) NSString *task_no;
@property (nonatomic,copy) NSString *result;
@property (nonatomic,copy) NSArray<UrgenttaskDetailModelVideo_list *> *video_list;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *audio_second;

@end
