//
//  PatrolHttpRequest.m
//  物联宝管家
//
//  Created by yang on 2019/3/30.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolHttpRequest.h"

@implementation PatrolHttpRequest

#pragma mark - 公共接口
+(void)checkEquipment:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest getRequestData:@"checkEquipment" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)checkcaptain:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest getRequestData:@"checkcaptain" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)getcommunitybylatlng:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"getcommunitybylatlng" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)carlist:(id)obj :(CommandCompleteBlock)block{
    
    //    [BaseRequest postRequestData:@"inspecttasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
    //
    //        block(data,resultCode,Error);
    //
    //    }];
    
    [BaseRequest getRequestData:@"carlist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
    
}
+(void)carconfirm:(id)obj :(CommandCompleteBlock)block{
    
        [BaseRequest postRequestData:@"carconfirm" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
    
            block(data,resultCode,Error);
    
        }];
    
//    [BaseRequest getRequestData:@"carconfirm" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
    
}
+(void)groupinfo:(id)obj :(CommandCompleteBlock)block{
    
    //    [BaseRequest postRequestData:@"inspecttasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
    //
    //        block(data,resultCode,Error);
    //
    //    }];
    
    [BaseRequest getRequestData:@"groupinfo" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
    
}
+(void)picupload:(id)obj :(CommandCompleteBlock)block{
    
//    [BaseRequest postRequestData:@"picupload" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
    
}
+(void)videoupload:(id)obj :(CommandCompleteBlock)block{
    
//    [BaseRequest postRequestData:@"videoupload" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
}
+(void)audioupload:(id)obj :(CommandCompleteBlock)block{
    
//    [BaseRequest postRequestData:@"audioupload" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
}
+(void)upload:(id)obj :(CommandCompleteBlock)block fileUrl:(NSURL *)fileUrl{
    
    
}
#pragma mark - 巡检队长
+(void)inspecttasklist:(id)obj :(CommandCompleteBlock)block{
    
//    [BaseRequest postRequestData:@"inspecttasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
    
    [BaseRequest getRequestData:@"inspecttasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
    
}
+(void)inspecttaskexec:(id)obj :(CommandCompleteBlock)block{
//    [BaseRequest getRequestData:@"inspecttaskexec" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//        
//        block(data,resultCode,Error);
//        
//    }];
    [BaseRequest postRequestData:@"inspecttaskexec" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
                block(data,resultCode,Error);
        
    }];
    
}
+(void)inspecttaskdetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"inspecttaskdetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)inspecttaskfinish:(id)obj :(CommandCompleteBlock)block{
//    [BaseRequest getRequestData:@"inspecttaskfinish" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//        
//        block(data,resultCode,Error);
//        
//    }];
    [BaseRequest postRequestData:@"inspecttaskfinish" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)inspectdevicelist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"inspectdevicelist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)alldevice:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"alldevice" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)groupdevicelist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"groupdevicelist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)inspectdevicedetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"inspectdevicedetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)inspecttaskposition:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"inspecttaskposition" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)communitydeviceposition:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"communitydeviceposition" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)selectguarantee:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"selectguarantee" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
#pragma mark - 巡检队员

+(void)memberinspectiontasklist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"memberinspectiontasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)memberinspecttaskdetaila:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"memberinspecttaskdetaila" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
#pragma mark =====  巡检任务社区设备组列表 ======
+(void)memberinspectdevicelist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"memberinspectdevicelist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
#pragma mark ======巡检任务社区所有设备列表 ======
+(void)memberalldevice:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"memberalldevice" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)membergroupdevicelist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"membergroupdevicelist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)memberinspectdevicedetail:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest getRequestData:@"memberinspectdevicedetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)memberinspectdevicecommit:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest postRequestData:@"memberinspectdevicecommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}

#pragma mark - 巡查队长

+(void)patroltasklist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patroltasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patrolinspecttaskfinish:(id)obj :(CommandCompleteBlock)block
{
    [BaseRequest postRequestData:@"patrolinspecttaskfinish" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patroltaskexe:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest postRequestData:@"patroltaskexe" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
    
}
+(void)patroltaskdetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patroltaskdetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patrolworkdetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patrolworkdetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patroltaskposition:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patroltaskposition" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}

#pragma mark - 巡查队员

+(void)patrolmembertasklist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patrolmembertasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patrolworklist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patrolworklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patrolmemberworkdetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"patrolmemberworkdetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)patrolworkcommit:(id)obj :(CommandCompleteBlock)block{
//    [BaseRequest getRequestData:@"patrolworkcommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//        
//        block(data,resultCode,Error);
//        
//    }];
    [BaseRequest postRequestData:@"patrolworkcommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}


#pragma mark - 紧急任务
+(void)urgenttasklist:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"urgenttasklist" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)execute:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest postRequestData:@"execute" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}

+(void)urgenttaskdetail:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getRequestData:@"urgenttaskdetail" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)urgentworkcommit:(id)obj :(CommandCompleteBlock)block{
//    [BaseRequest getRequestData:@"urgentworkcommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//
//        block(data,resultCode,Error);
//
//    }];
    [BaseRequest postRequestData:@"urgentworkcommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}

#pragma mark - 在线报事
+(void)reporteventcommit:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest postRequestData:@"reporteventcommit" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
}
+(void)memberrepair:(id)obj :(CommandCompleteBlock)block{
    
    [BaseRequest postRequestData:@"memberrepair" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        block(data,resultCode,Error);
        
    }];
    
}

+(void)hasCall:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getChatRequestData:@"hasCall.php" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        block(data,resultCode,Error);

    }];
}
+(void)isBusy:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getChatRequestData:@"isBusy.php" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        block(data,resultCode,Error);

    }];
}
+(void)hangUp:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getChatRequestData:@"hangUp.php" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        block(data,resultCode,Error);

    }];
}
+(void)applyCall:(id)obj :(CommandCompleteBlock)block{
    [BaseRequest getChatRequestData:@"applyCall.php" parameters:obj :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        block(data,resultCode,Error);

    }];
}

@end
