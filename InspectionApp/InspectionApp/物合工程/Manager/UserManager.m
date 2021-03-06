//
//  UserManager.m
//  物联宝管家
//
//  Created by yang on 2019/4/17.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+(AboutModel*)getAboutModel{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"about_model"];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return  [AboutModel yy_modelWithJSON:dict];
}

+(void)saveAboutModel:(AboutModel *)aboutModel{
    
    NSDictionary *productDic = [aboutModel yy_modelToJSONObject];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:productDic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"about_model"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(void)saveUserInfo:(UserManagerModel *)userModel{
    
    NSDictionary *productDic = [userModel yy_modelToJSONObject];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:productDic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user_info"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(UserManagerModel*)getUserInfo{
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_info"];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return  [UserManagerModel yy_modelWithJSON:dict];
    
}
+(NSString *)user_id{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.user_id;
}
+(NSString *)token{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.token;
   
}
+(NSString *)nick_name{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.nick_name;
    
}
+(NSString *)iscaptain{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.iscaptain;
}
+(NSString *)mobile_phone{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.mobile_phone;
}
+(NSString *)ture_name{
    UserManagerModel *model = [UserManager getUserInfo];
    return model.ture_name;
}
+(NSString *)menber_id{
    UserManagerModel *model = [UserManager getUserInfo];
    return [NSString stringWithFormat:@"%ld",(long)model.member_id];
}

+(BOOL)order_starts{
    NSNumber *start = [[NSUserDefaults standardUserDefaults]objectForKey:Order_Starts];
    if (!start) {
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:Order_Starts];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    return start.boolValue;
}
+(NSString *)security_id{
    UserManagerModel *model = [UserManager getUserInfo];
    return [NSString stringWithFormat:@"%ld",(long)model.security_id];
}
@end
