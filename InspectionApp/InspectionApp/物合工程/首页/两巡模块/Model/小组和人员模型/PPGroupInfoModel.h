//
//PPGroupInfoModel.h 
//
//
//Create by yang on 19/4/2 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPGroupInfoModelMember_list.h"
#import "PPGroupInfoModelTool_list.h"

@interface PPGroupInfoModel:NSObject
@property (nonatomic,copy) NSString *car_id;
@property (nonatomic,copy) NSArray<PPGroupInfoModelMember_list*> *member_list;
@property (nonatomic,copy) NSString *people_number;
@property (nonatomic,copy) NSArray<PPGroupInfoModelTool_list*> *tool_list;
@property (nonatomic,copy) NSString *car_type;
@property (nonatomic,copy) NSString *car_name;
@property (nonatomic,copy) NSString *car_carid;

@end
