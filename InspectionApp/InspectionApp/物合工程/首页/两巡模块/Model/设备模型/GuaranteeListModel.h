//
//  GuaranteeListModel.h
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GuaranteeListModel : NSObject
@property (nonatomic, strong)NSString  *installation_location;//服务位置
@property (nonatomic, strong)NSString  *item_name;//保修项目
@property (nonatomic, strong)NSString  *true_name;//预约人

@property (nonatomic, strong)NSString  *mobile_phone;//电话号码
@property (nonatomic, strong)NSString  *create_date;//保修时间
@property (nonatomic, strong)NSString  *work_type;//工单类型
@property (nonatomic, strong)NSString  *agent;//代理商
@property (nonatomic, strong)NSString  *time_of_appointment;//预约时间

@property (nonatomic, strong)NSString  *repair_location;//服务位置
@property (nonatomic, strong)NSString  *repair_datetime;//报修时间
@property (nonatomic, strong)NSString  *work_sheet_type;//工单类型
@property (nonatomic, strong)NSString  *ture_name;//预约人

@end
