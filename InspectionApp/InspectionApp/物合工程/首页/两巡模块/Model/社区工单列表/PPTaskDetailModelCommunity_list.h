//
//PPTaskDetailModelCommunity_list.h 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PPTaskDetailModelCommunity_list:NSObject
@property (nonatomic,copy) NSString *community_name;
@property (nonatomic,copy) NSString *device_number;
@property (nonatomic,copy) NSString *inspected_number;
@property (nonatomic,copy) NSString *abnormal_number;
@property (nonatomic,copy) NSString *community_position;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *community_id;

@property (nonatomic,copy) NSString *patroled_count;//巡查次数
@property (nonatomic,copy) NSString *patrolled_count;//已巡查次数

@property (nonatomic,copy) NSString *patrol_count;//已巡查次数

@property (nonatomic,copy) NSString *work_sheet_status;//工单状态
@property (nonatomic,copy) NSString *work_sheet_id;//工单ID

@end
