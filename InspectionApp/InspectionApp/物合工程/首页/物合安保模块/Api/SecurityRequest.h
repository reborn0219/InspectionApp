//
//  SecurityRequest.h
//  InspectionApp
//
//  Created by yang on 2019/6/6.
//  Copyright © 2019 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecurityRequest : NSObject
+(void)get_news_order2:(CommandCompleteBlock)block;

+(void)security_list:(NSString*)repair_status Page:(NSString *)start_num :(CommandCompleteBlock)block;
+(void)repair_whoPage:(NSString *)start_num Nums:(NSString *)per_pager_nums :(CommandCompleteBlock)block;
+(void)fen_pei:(CommandCompleteBlock)block;
+(void)edit_invalid:(CommandCompleteBlock)block;
+(void)change_state:(CommandCompleteBlock)block;
+(void)security_info:(NSString *)repair_id :(CommandCompleteBlock)block;
+(void)grab:(NSString *)repair_id :(CommandCompleteBlock)block;
+(void)fen_pei:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id :(CommandCompleteBlock)block;
+(void)edit_invalid:(NSString *)repair_id Work_remarks:(NSString *)work_remarks :(CommandCompleteBlock)block;
+(void)repair_transfer:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id  :(CommandCompleteBlock)block;
+(void)edit_finished:(NSDictionary *)dict :(CommandCompleteBlock)block;
+(void)receive:(NSString *)repair_id :(CommandCompleteBlock)block;
+(void)confirm_grab:(NSString *)repair_id :(CommandCompleteBlock)block;
+(void)security_info:(NSString *)repair_id Repair_status:(NSString *)repair_status Start_num:(NSString *)start_num Per_pager_nums:(NSString *)per_pager_nums :(CommandCompleteBlock)block;
@end

NS_ASSUME_NONNULL_END
