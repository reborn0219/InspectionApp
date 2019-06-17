//
//  HomeRequest.h
//  InspectionApp
//
//  Created by yang on 2019/5/30.
//  Copyright © 2019 yang. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeRequest : BaseRequest

/**
 首页接口

 @param block 回调
 */
+(void)companyinfo:(CommandCompleteBlock)block;



@end

NS_ASSUME_NONNULL_END
