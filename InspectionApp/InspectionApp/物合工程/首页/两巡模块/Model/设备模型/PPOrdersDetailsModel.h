//
//  PPOrdersDetailsModel.h
//  物联宝管家
//
//  Created by guokang on 2019/4/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPSubmitOrdersPicture_list.h"
#import "PPSubmitOrdersVedio_list.h"
NS_ASSUME_NONNULL_BEGIN

@interface PPOrdersDetailsModel : NSObject
@property (nonatomic, strong) NSString *community_id;
@property (nonatomic, strong) NSString *work_sheet_id;
@property (nonatomic, strong) NSString *community_name;
@property (nonatomic, strong) NSString *community_position;
@property (nonatomic, strong) NSString *patrol_count;
@property (nonatomic, strong) NSString *patrolled_count;
@property (nonatomic, strong) NSString *work_sheet_status;
@property (nonatomic, strong) NSString *patrol_user_name;
@property (nonatomic, strong) NSString *patrol_user_phone;
@property (nonatomic, strong) NSString *patrol_result;
@property (nonatomic, strong) NSString *audio_url;
@property (nonatomic, strong) NSString *audio_length;
@property (nonatomic, strong) NSString *audio_second;

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong)NSString  *patrol_date;
@property (nonatomic,copy)NSArray<PPSubmitOrdersVedio_list *>*video_list;
@property (nonatomic, copy)NSArray<PPSubmitOrdersPicture_list *>*picture_list;
@end

NS_ASSUME_NONNULL_END
