//
//  PatrolHttpRequest.h
//  物联宝管家
//
//  Created by yang on 2019/3/30.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PatrolHttpRequest : NSObject


//-------------------------------------------------公共接口

/**
 扫描二维码

 @param obj 参数
 @param block 回调
 */
+(void)checkEquipment:(id)obj :(CommandCompleteBlock)block;
/**
 判断是否是组长

 @param obj 暂无
 @param block 返回是否
 */
+(void)checkcaptain:(id)obj :(CommandCompleteBlock)block;

/**
 紧急任务获取需要选择的社区列表

 @param obj 参数
 @param block 回调
 */
+(void)getcommunitybylatlng:(id)obj :(CommandCompleteBlock)block;
/**
 车辆列表
 
 @param obj 参数
 @param block 回调
 */
+(void)carlist:(id)obj :(CommandCompleteBlock)block;
/**
 确定选车
 
 @param obj 参数
 @param block 回调
 */
+(void)carconfirm:(id)obj :(CommandCompleteBlock)block;
/**
 组详情
 
 @param obj 参数
 @param block 回调
 */
+(void)groupinfo:(id)obj :(CommandCompleteBlock)block;
/**
 图片上传
 
 @param obj 参数
 @param block 回调
 */
+(void)picupload:(id)obj :(CommandCompleteBlock)block;
/**
 视频上传
 
 @param obj 参数
 @param block 回调
 */
+(void)videoupload:(id)obj :(CommandCompleteBlock)block;
/**
 音频上传
 
 @param obj 参数
 @param block 回调
 */
+(void)audioupload:(id)obj :(CommandCompleteBlock)block;



+(void)upload:(id)obj :(CommandCompleteBlock)block fileUrl:(NSURL *)fileUrl;

//-------------------------------------------------巡检队长接口

/**
 巡检任务列表

 @param obj 参数
 @param block 回调
 */
+(void)inspecttasklist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务去执行操作
 
 @param obj 参数
 @param block 回调
 */
+(void)inspecttaskexec:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务社区列表
 
 @param obj 参数
 @param block 回调
 */
+(void)inspecttaskdetail:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务提交操作
 
 @param obj 参数
 @param block 回调
 */
+(void)inspecttaskfinish:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务社区里设备组列表
 
 @param obj 参数
 @param block 回调
 */
+(void)inspectdevicelist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检社区里所有设备列表
 
 @param obj 参数
 @param block 回调
 */
+(void)alldevice:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务组内设备列表
 
 @param obj 参数
 @param block 回调
 */
+(void)groupdevicelist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检设备详情
 
 @param obj 参数
 @param block 回调
 */
+(void)inspectdevicedetail:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务位置
 
 @param obj 参数
 @param block 回调
 */
+(void)inspecttaskposition:(id)obj :(CommandCompleteBlock)block;
/**
 巡检社区中所有设备位置（组和单个设备位置）
 
 @param obj 参数
 @param block 回调
 */
+(void)communitydeviceposition:(id)obj :(CommandCompleteBlock)block;
/**
 转保修
 
 @param obj 参数
 @param block 回调
 */
+(void)selectguarantee:(id)obj :(CommandCompleteBlock)block;


//-------------------------------------------------巡检队员接口

/**
 巡检任务列表接口
 
 @param obj 参数
 @param block 回调
 */
+(void)memberinspectiontasklist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务中社区列表
 
 @param obj 参数
 @param block 回调
 */
+(void)memberinspecttaskdetaila:(id)obj :(CommandCompleteBlock)block;
/**
 巡检社区中所有设备组列表
 
 @param obj 参数
 @param block 回调
 */
+(void)memberinspectdevicelist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检任务社区里所有设备列表
 
 @param obj 参数
 @param block 回调
 */
+(void)memberalldevice:(id)obj :(CommandCompleteBlock)block;
/**
 巡检设备组中设备列表
 
 @param obj 参数
 @param block 回调
 */
+(void)membergroupdevicelist:(id)obj :(CommandCompleteBlock)block;
/**
 巡检巡检队员工单详情接口
 
 @param obj 参数
 @param block 回调
 */
+(void)memberinspectdevicedetail:(id)obj :(CommandCompleteBlock)block;
/**
 巡检队员工单提交接口
 
 @param obj 参数
 @param block 回调
 */
+(void)memberinspectdevicecommit:(id)obj :(CommandCompleteBlock)block;


//-------------------------------------------------巡查队长接口

/**
 巡查任务列表接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patroltasklist:(id)obj :(CommandCompleteBlock)block;

/**
 执行工单操作

 @param obj 参数
 @param block 回调
 */
+(void)patroltaskexe:(id)obj :(CommandCompleteBlock)block;
/**
 巡查任务提交接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolinspecttaskfinish:(id)obj :(CommandCompleteBlock)block;

/**
 巡查任务社区列表接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patroltaskdetail:(id)obj :(CommandCompleteBlock)block;

/**
 巡查任务详情接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolworkdetail:(id)obj :(CommandCompleteBlock)block;

/**
 巡查任务位置接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patroltaskposition:(id)obj :(CommandCompleteBlock)block;

//-------------------------------------------------巡查队员接口

/**
 巡查队员任务列表接口
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolmembertasklist:(id)obj :(CommandCompleteBlock)block;

/**
 巡查队员社区列表
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolworklist:(id)obj :(CommandCompleteBlock)block;
/**
 巡查队员工单详情
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolmemberworkdetail:(id)obj :(CommandCompleteBlock)block;
/**
 巡查队员工单提交
 
 @param obj 参数
 @param block 回调
 */
+(void)patrolworkcommit:(id)obj :(CommandCompleteBlock)block;

//-------------------------------------------------公共接口
/**
 紧急任务列表
 
 @param obj 参数
 @param block 回调
 */
+(void)urgenttasklist:(id)obj :(CommandCompleteBlock)block;

/**
 紧急任务去执行
 
 @param obj 参数
 @param block 回调
 */
+(void)execute:(id)obj :(CommandCompleteBlock)block;

/**
 紧急任务详情
 
 @param obj 参数
 @param block 回调
 */
+(void)urgenttaskdetail:(id)obj :(CommandCompleteBlock)block;

/**
 紧急任务提交
 
 @param obj 参数
 @param block 回调
 */
+(void)urgentworkcommit:(id)obj :(CommandCompleteBlock)block;

//-------------------------------------------------公共接口
/**
 在线报事
 
 @param obj 参数
 @param block 回调
 */
+(void)reporteventcommit:(id)obj :(CommandCompleteBlock)block;


/**
 报修提交

 @param obj 参数
 @param block 回调
 */
+(void)memberrepair:(id)obj :(CommandCompleteBlock)block;

////视频通话
+(void)hasCall:(id)obj :(CommandCompleteBlock)block;
+(void)isBusy:(id)obj :(CommandCompleteBlock)block;
+(void)hangUp:(id)obj :(CommandCompleteBlock)block;
+(void)applyCall:(id)obj :(CommandCompleteBlock)block;

@end

NS_ASSUME_NONNULL_END
