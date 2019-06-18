//
//OrderDetailModel.h 
//
//
//Create by yang on 19/6/11 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OrderDetailModelRepaird.h"
#import "NewOrderModelIvv_json.h"
@interface OrderDetailModel:NSObject
@property (nonatomic,copy) NSString *paid_fee;
@property (nonatomic,copy) NSString *serving_time;
@property (nonatomic,copy) NSString *allot_type;
@property (nonatomic,copy) NSString *position;
@property (nonatomic,copy) NSString *paid_time;
@property (nonatomic,copy) NSString *member_id;
@property (nonatomic,copy) NSString *repair_qrcode;
@property (nonatomic,copy) NSString *post_time;
@property (nonatomic,strong) OrderDetailModelRepaird *repaird;
@property (nonatomic,copy) NSString *pay_type;
@property (nonatomic,copy) NSString *contact;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *community_id;
@property (nonatomic,copy) NSString *repair_no;
@property (nonatomic,copy) NSString *sort_class;
@property (nonatomic,copy) NSString *repair_time;
@property (nonatomic,copy) NSString *is_paid;
@property (nonatomic,strong) NewOrderModelIvv_json *ivv_json;
@property (nonatomic,copy) NSString *parent_class;
@property (nonatomic,copy) NSString *repair_id;
@property (nonatomic,copy) NSString *repair_status;
@property (nonatomic,copy) NSString *cancel_reason;
@property (nonatomic,copy) NSString *is_help;
@property (nonatomic,copy) NSString *remarks;
@property (nonatomic,copy) NSString *is_op;
@property (nonatomic,copy) NSString *is_self;
@property (nonatomic,copy) NSString *room_id;
@property (nonatomic,copy) NSString *repair_description;
@property (nonatomic,copy) NSString *service_quality;
@property (nonatomic,copy) NSString *satisfied;
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSString *repair_after;
@property (nonatomic,copy) NSString *member_name;

@end
