//
//  LoginRequest.m
//  InspectionApp
//
//  Created by yang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest
+(void)do_lgoin:(id)obj :(CommandCompleteBlock)block{
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:obj];
    [mutableDic setObject:@"do_lgoin" forKey:@"a"];
    [mutableDic setObject:@"login" forKey:@"f"];

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
+(void)getpwd_vercode:(NSString *)mobile_phone :(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"getpwd_vercode" forKey:@"a"];
    [mutableDic setObject:@"sendsms" forKey:@"f"];
    [mutableDic setObject:mobile_phone forKey:@"mobile_phone"];
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
+(void)get_userpwd:(NSDictionary *)dict :(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mutableDic setObject:@"get_userpwd" forKey:@"a"];
    [mutableDic setObject:@"sendsms" forKey:@"f"];
    [mutableDic setObject:[dict objectForKey:@"mobile_phone"] forKey:@"mobile_phone"];
    [mutableDic setObject:[dict objectForKey:@"verification_code"] forKey:@"verification_code"];
    [mutableDic setObject:[dict objectForKey:@"password_new"] forKey:@"password_new"];
    [mutableDic setObject:[dict objectForKey:@"password_new_confirm"] forKey:@"password_new_confirm"];
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
//没有用修改密码的接口
+(void)change_password:(NSDictionary *)dict :(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mutableDic setObject:@"change_password" forKey:@"a"];
    [mutableDic setObject:@"user" forKey:@"f"];
    [mutableDic setObject:[dict objectForKey:@"password_old"] forKey:@"password_old"];
    [mutableDic setObject:[dict objectForKey:@"password_new"] forKey:@"password_new"];
    [mutableDic setObject:[dict objectForKey:@"password_new_confirm"] forKey:@"password_new_confirm"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
            
        }
    }];
    
}
@end
