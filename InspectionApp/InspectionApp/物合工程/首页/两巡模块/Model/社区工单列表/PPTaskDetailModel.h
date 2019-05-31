//
//PPTaskDetailModel.h 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPTaskDetailModelCommunity_list.h"
#import "PPTaskDetailModelMember_list.h"

@interface PPTaskDetailModel:NSObject

@property (nonatomic,copy) NSString *task_date;

@property (nonatomic,copy) NSString *community_number;
@property (nonatomic,copy) NSString *patrolled_number;


@property (nonatomic,copy) NSString *device_number;
@property (nonatomic,copy) NSString *inspected_number;
@property (nonatomic,copy) NSString *car_id;
@property (nonatomic,copy) NSString *task_no;
@property (nonatomic,copy) NSString *task_name;
@property (nonatomic,copy) NSString *task_cycle;
@property (nonatomic,copy) NSString *task_id;
@property (nonatomic,copy) NSString *abnormal_number;
@property (nonatomic,copy) NSString *work_id;
@property (nonatomic,copy) NSArray<PPTaskDetailModelMember_list*> *member_list;
@property (nonatomic,copy) NSArray<PPTaskDetailModelCommunity_list*> *community_list;
@property (nonatomic,copy) NSString *team_id;
@property (nonatomic,copy) NSString *task_status;
@end
