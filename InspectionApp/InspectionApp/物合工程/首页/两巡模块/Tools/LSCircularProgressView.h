//
//  LSCircularProgressView.h
//  物联宝管家
//
//  Created by yang on 2019/4/4.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSCircularProgressView : UIView

/**
 设置动画进程

 @param allDevice 所有设备
 @param inspectionDevice 已巡检设备
 @param abnormalDevice 异常设备
 */
-(void)setProgress:(NSString *)allDevice
        Inspection:(NSString *)inspectionDevice
          Abnormal:(NSString *)abnormalDevice;

@end

NS_ASSUME_NONNULL_END
