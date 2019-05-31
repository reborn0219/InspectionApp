//
//  UserManager.h
//  物联宝管家
//
//  Created by yang on 2019/4/17.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManagerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject
+(void)saveUserInfo:(UserManagerModel *)userModel;
+(UserManagerModel*)getUserInfo;

+(NSString *)user_id;
+(NSString *)token;
+(NSString *)nick_name;
+(NSString *)iscaptain;
+(NSString *)mobile_phone;
+(NSString *)ture_name;
+(NSString *)menber_id;



@end

NS_ASSUME_NONNULL_END
