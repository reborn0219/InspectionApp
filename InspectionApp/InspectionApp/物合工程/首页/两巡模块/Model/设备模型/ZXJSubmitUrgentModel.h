//
//  ZXJSubmitUrgentModel.h
//  物联宝管家
//
//  Created by guokang on 2019/4/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPSubmitOrdersVedio_list.h"
#import "PPSubmitOrdersPicture_list.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXJSubmitUrgentModel : NSObject
@property (nonatomic, strong) NSString *exec_result;
@property (nonatomic, strong) NSString *task_no;
@property (nonatomic, strong) NSString *audio_path;
@property (nonatomic, strong) NSString *audio_second;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic,copy) NSArray *picture_list;
@property (nonatomic,copy) NSArray *video_list;
@end

NS_ASSUME_NONNULL_END
