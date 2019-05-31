//
//  PPSubmitOrdersVedio_list.h
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSubmitOrdersVedio_list : NSObject
@property (nonatomic, strong)NSString  *video_path;
@property (nonatomic, strong)NSString  *img_path;
@property (nonatomic, strong)NSString  *thumb_path;


//巡查队员设备详情
@property (nonatomic, strong)NSString  *thumb_url;
@property (nonatomic, strong)NSString  *video_url;
@end
