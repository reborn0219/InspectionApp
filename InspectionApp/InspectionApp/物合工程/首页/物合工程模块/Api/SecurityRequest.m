//
//  SecurityRequest.m
//  InspectionApp
//
//  Created by yang on 2019/6/6.
//  Copyright © 2019 yang. All rights reserved.
//

#import "SecurityRequest.h"

@implementation SecurityRequest
+(void)security_info:(NSString *)repair_id :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"security_info" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];

    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
            
        }
    }];
}
+(void)get_news_order2:(CommandCompleteBlock)block{
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"get_news_order2" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
            
        }
    }];
}
+(void)security_list:(NSString*)repair_status Page:(NSString *)start_num :(CommandCompleteBlock)block{
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"security_list" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:[UserManager security_id] forKey:@"security_id"];

    [mutableDic setObject:repair_status forKey:@"repair_status"];
    [mutableDic setObject:start_num forKey:@"start_num"];
    [mutableDic setObject:Page_Size forKey:@"per_pager_nums"];

    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            block(data,resultCode,nil);
    }];
}
+(void)repair_whoPage:(NSString *)start_num Nums:(NSString *)per_pager_nums :(CommandCompleteBlock)block;{
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"repair_who" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:[UserManager security_id] forKey:@"security_id"];
    [mutableDic setObject:start_num forKey:@"start_num"];
    [mutableDic setObject:per_pager_nums forKey:@"per_pager_nums"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
        }
    }];
}


+(void)change_state:(CommandCompleteBlock)block{
    
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"change_state" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
            
        }
    }];
}
+(void)grab:(NSString *)repair_id :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"grab" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
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
+(void)edit_invalid:(NSString *)repair_id Work_remarks:(NSString *)work_remarks :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"edit_invalid" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
    [mutableDic setObject:work_remarks forKey:@"work_remarks"];
    [mutableDic setObject:[UserManager security_id] forKey:@"security_id"];
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
+(void)fen_pei:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"fen_pei" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
    [mutableDic setObject:remarks forKey:@"remarks"];
    [mutableDic setObject:repair_user_id forKey:@"repair_user_id"];
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
+(void)repair_transfer:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id  :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"repair_transfer" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
    [mutableDic setObject:remarks forKey:@"remarks"];
    [mutableDic setObject:repair_user_id forKey:@"repair_user_id"];
    [mutableDic setObject:[UserManager security_id] forKey:@"security_id"];
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
+(void)edit_finished:(NSDictionary *)dict :(CommandCompleteBlock)block
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mutableDic setObject:@"edit_finished" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];

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
+(void)receive:(NSString *)repair_id :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"receive" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
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
+(void)confirm_grab:(NSString *)repair_id :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"confirm_grab" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
            
        }
    }];
}
+(void)security_info:(NSString *)repair_id Repair_status:(NSString *)repair_status Start_num:(NSString *)start_num Per_pager_nums:(NSString *)per_pager_nums :(CommandCompleteBlock)block{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    [mutableDic setObject:@"repair_transfer" forKey:@"a"];
    [mutableDic setObject:[UserManager user_id] forKey:@"user_id"];
    [mutableDic setObject:[UserManager token] forKey:@"token"];
    [mutableDic setObject:@"security" forKey:@"f"];
    [mutableDic setObject:repair_id forKey:@"repair_id"];
    [mutableDic setObject:repair_status forKey:@"repair_status"];
    [mutableDic setObject:start_num forKey:@"start_num"];
    [mutableDic setObject:per_pager_nums forKey:@"per_pager_nums"];
    [BaseRequest postRequestDataParameters:mutableDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            block(data,resultCode,nil);
        }
    }];
}
@end
