//
//NewOrderModel.h 
//
//
//Create by yang on 19/6/10 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewOrderModelIvv_json.h"
@interface NewOrderModel:NSObject

@property (nonatomic,copy) NSString *allot_type;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *remarks;
@property (nonatomic,copy) NSString *type_name;
@property (nonatomic,strong) NewOrderModelIvv_json *ivv_json;
@property (nonatomic,copy) NSString *voice_type;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *voice_txt;
@property (nonatomic,copy) NSString *add;
@property (nonatomic,copy) NSString *name;

@end
