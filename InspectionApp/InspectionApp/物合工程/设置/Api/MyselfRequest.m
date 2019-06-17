//
//  MyselfRequest.m
//  InspectionApp
//
//  Created by guokang on 2019/6/15.
//  Copyright © 2019 yang. All rights reserved.
//

#import "MyselfRequest.h"

@implementation MyselfRequest
+(void)disclaimer:(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"disclaimer" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"service" forKey:@"f"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
        }else{
            block(data,resultCode,nil);
            NSString *error = data;
            [GJMBProgressHUD showError:error];
        }
    }];
    
}
+(void)feedback:(NSString *)feedback_content contact:(NSString*)feedback_contact :(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"feedback" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"user" forKey:@"f"];
      [mutableDic setObject:feedback_contact forKey:@"feedback_contact"];
      [mutableDic setObject:feedback_content forKey:@"feedback_content"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
        }else{
            block(data,resultCode,nil);
            NSString *error = data;
            [GJMBProgressHUD showError:error];
        }
    }];
    
}
+(void)companyinfo:(CommandCompleteBlock)block{
    
    [BaseRequest getRequestData:@"companyinfo" parameters:@{} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);

    }];
}
@end
