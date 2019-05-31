//
//  PPSubmitOrdersModel.h
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPSubmitOrdersVedio_list.h"
#import "PPSubmitOrdersPicture_list.h"
#import "PPSubmitOrdersProject_list.h"

@interface PPSubmitOrdersModel : NSObject
@property (nonatomic, strong)NSString *audio_path;
@property (nonatomic, strong)NSString  *audio_second;
@property (nonatomic, strong)NSString  *remark;
@property (nonatomic, strong)NSString  *work_sheet_id;
@property (nonatomic, strong)NSString  *is_normal;
@property (nonatomic, strong)NSString  *end_result;
@property (nonatomic,copy) NSArray<PPSubmitOrdersProject_list*>  *project_list;
@property (nonatomic,copy) NSArray*picture_list;
@property (nonatomic,copy) NSArray<PPSubmitOrdersVedio_list*>  *video_list;
//@property (nonatomic, strong)NSString  *thumb_path;
//@property (nonatomic, strong)NSString  *video_path;
@end
