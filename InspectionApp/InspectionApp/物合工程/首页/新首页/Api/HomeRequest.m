//
//  HomeRequest.m
//  InspectionApp
//
//  Created by yang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "HomeRequest.h"

@implementation HomeRequest
+(void)companyinfo:(CommandCompleteBlock)block{
    
    [BaseRequest getRequestData:@"companyinfo" parameters:@{} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
@end
