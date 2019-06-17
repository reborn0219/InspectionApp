//
//  EnumerationDefinition.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#ifndef EnumerationDefinition_h
#define EnumerationDefinition_h

//处理事件返回码
typedef NS_ENUM(NSInteger,ResultCode)
{
    SucceedCode=0,      ///事件处理成功
    FailureCode,        ///事件处理失败
    NONetWorkCode,      ///无网络环境
    TOKENInvalid,       ///登录失效
    CustomCode,         ///自定义
};

typedef NS_ENUM(NSInteger,OrderType)
{
   OrderTypeAll = 0,///全部
   OrderTypeUnStart = 1,///未到开始时间
   OrderTypeUnOption = 2,///未执行
   OrderTypeOptioning = 3,///未执行
   OrderTypeOver = 4,///未执行
};

typedef NS_ENUM(NSInteger,PageOneType)
{
    PageOneTypeXunJian = 0,///巡检队长
    PageOneTypeXunJianMember = 1,///巡检队员

    PageOneTypeXunCha ,///巡查队长
    PageOneTypeXunChaMember ,///巡查队员
    
    PageOneTypeJiJi ,///紧急任务
};

typedef NS_ENUM(NSInteger,EquipmentType)
{
    EquipmentTypeNotPatrol = 0,///未巡查
    EquipmentTypeHasPatrol ,///已巡查
    EquipmentTypeHasNormal ,///正常
    EquipmentTypeHasAbnormal,///异常
    EquipmentTypeHasRepair ,///已报修
};
typedef NS_ENUM(NSInteger, OrderCycle)
{
    OrderCycleAll = 0,//全部
    OrderCycleDate = 1,//日
    OrderCycleWeek = 2 ,//周
    OrderCycleMonth = 3,//月
    OrderCycleYear = 4,//年
    
};
//工单列表
typedef NS_ENUM(NSInteger,WorkOrderType)
{
    WorkOrderUnhandle = 0,//未处理
    WorkOrderWaitingToHandle = 1,//待处理
    WorkOrderHandling = 2,//处理中
    WorkOrderHandled = 3,//已处理
    WorkOrderFinished = 4,//已完成
};
typedef NS_ENUM(NSInteger,WorkOrderDataType)
{
    WorkOrderTextData = 0,
    WorkOrderVoiceData = 1,
    WorkOrderImageData = 2,
};
typedef NS_ENUM(NSInteger,WorkAlertType)
{
    WorkOrderAlertClose = 0,
    WorkOrderAlertQuiet = 1,
    WorkOrderAlertGrab = 2,
    WorkOrderAlertNext = 3,
     WorkOrderAlertConfirm = 4,
    WorkOrderAlertDistribute = 5,
    WorkOrderAlertMarkInvalid = 6,
    WorkOrderAlertTranform = 7,
    WorkOrderAlertPlayVoice = 8,
    WorkOrderAlertPlayVedio= 9,
    WorkOrderAlertHandle= 10,
     WorkOrderAlertSelectMember= 11,
    WorkOrderAlertMarkFinished= 12,
};

#endif /* EnumerationDefinition_h */
