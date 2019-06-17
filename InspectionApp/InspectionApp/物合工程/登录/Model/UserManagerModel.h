//
//UserManagerModel.h 
//
//
//Create by yang on 19/5/29 
//Copyright (c) 2019年 yang. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserManagerModel:NSObject
@property (nonatomic,assign) NSInteger pro_code;
@property (nonatomic,assign) NSInteger security_id;
@property (nonatomic,copy) NSString *ture_name;
@property (nonatomic,copy) NSString *security_name;
@property (nonatomic,copy) NSString *iscaptain;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *role_name;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *property_name;
@property (nonatomic,copy) NSString *mobile_phone;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *jpush_tag;
@property (nonatomic,copy) NSString *role;
@property (nonatomic,copy) NSString *app_avatar_url;
@property (nonatomic,assign) NSInteger last_login_time;
@property (nonatomic,assign) NSInteger property_id;
@property (nonatomic,assign) NSInteger member_id;

@end