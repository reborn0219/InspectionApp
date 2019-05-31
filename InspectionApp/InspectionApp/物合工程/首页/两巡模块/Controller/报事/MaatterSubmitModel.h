//
//  MaatterSubmitModel.h
//  物联宝管家
//
//  Created by yang on 2019/4/17.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaatterSubmitModel : NSObject

@property (nonatomic,copy) NSString *report_user_name;
@property (nonatomic,copy) NSString *report_user_id;
@property (nonatomic,copy) NSString *report_user_phone;
@property (nonatomic,copy) NSString *report_content;
@property (nonatomic,copy) NSString *community_id;
@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *accident_position;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSArray  *picture_list;
@property (nonatomic,copy) NSArray  *video_list;
@property (nonatomic,copy) NSString *audio_path;
@property (nonatomic,copy) NSString *audio_length;
@property (nonatomic,copy) NSString *audio_second;

@property (nonatomic,copy) NSString *video_path;
@property (nonatomic,copy) NSString *thumb_path;
@end

NS_ASSUME_NONNULL_END
