//
//TaskListModel.h 
//
//
//Create by yang on 19/3/27 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TaskListModel:NSObject
@property (nonatomic,copy) NSString *task_status;
@property (nonatomic,copy) NSString *task_id;
@property (nonatomic,copy) NSString *task_cycle;
@property (nonatomic,copy) NSString *community_number;
@property (nonatomic,copy) NSString *task_no;
@property (nonatomic,copy) NSString *task_date;
@property (nonatomic,copy) NSString *task_name;
@property (nonatomic,copy) NSString *dispatch_user_name;

@property (nonatomic,copy) NSString *task_object;
@property (nonatomic,copy) NSString *dispatch_position;
@property (nonatomic,copy) NSString *dispatch_remark;
@property (nonatomic,copy) NSString *task_start_date;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *work_id;

@end
