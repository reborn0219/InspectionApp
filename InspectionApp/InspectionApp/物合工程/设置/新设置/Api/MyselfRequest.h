//
//  MyselfRequest.h
//  InspectionApp
//
//  Created by guokang on 2019/6/15.
//  Copyright © 2019 yang. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyselfRequest : BaseRequest
+(void)disclaimer:(CommandCompleteBlock)block;
+(void)feedback:(NSString *)feedback_content contact:(NSString*)feedback_contact :(CommandCompleteBlock)block;
+(void)companyinfo:(CommandCompleteBlock)block;
@end

NS_ASSUME_NONNULL_END
