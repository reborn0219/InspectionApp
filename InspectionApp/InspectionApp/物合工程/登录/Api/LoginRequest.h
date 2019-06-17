//
//  LoginRequest.h
//  InspectionApp
//
//  Created by yang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginRequest : BaseRequest
+(void)do_lgoin:(id)obj :(CommandCompleteBlock)block;
+(void)getpwd_vercode:(NSString *)mobile_phone :(CommandCompleteBlock)block;
+(void)get_userpwd:(NSDictionary *)dict :(CommandCompleteBlock)block;
+(void)change_password:(NSDictionary *)dict :(CommandCompleteBlock)block;
@end

NS_ASSUME_NONNULL_END
