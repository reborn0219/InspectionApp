//
//  UserManager.h
//  物联宝管家
//
//  Created by yang on 2019/4/17.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserManagerModel.h"
#import "AboutModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject
+(void)saveUserInfo:(UserManagerModel *)userModel;
+(UserManagerModel*)getUserInfo;

+(void)saveAboutModel:(AboutModel *)aboutModel;
+(AboutModel*)getAboutModel;

+(NSString *)user_id;
+(NSString *)token;
+(NSString *)nick_name;
+(NSString *)iscaptain;
+(NSString *)mobile_phone;
+(NSString *)ture_name;
+(NSString *)menber_id;
+(NSString *)security_id;


+(BOOL)order_starts;



@end

NS_ASSUME_NONNULL_END
