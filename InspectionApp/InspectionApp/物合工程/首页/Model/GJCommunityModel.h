//
//  GJCommunityModel.h
//  物联宝管家
//
//  Created by 曹学亮 on 2016/11/5.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 小区model
 */
@interface GJCommunityModel : NSObject
@property (nonatomic,copy) NSString *community_id;          //小区id
@property (nonatomic,copy) NSString *community_name;        //小区名称
@property (nonatomic,copy) NSString *department_id;         //部门ID
@property (nonatomic,copy) NSString *department_name;       //部门名称
@property (nonatomic,copy) NSString *department_parent_id;  //父级部门id
@property (nonatomic,copy) NSString *department_parent_name;//父级部门名称
@property (nonatomic,copy) NSString *is_default;            //是否是默认小区
@property (nonatomic,copy) NSString *property_full_name;    //物业公司名称
@property (nonatomic,copy) NSString *property_id;           //物业公司id
@property (nonatomic,copy) NSString *city_id;           //城市id
//@property (nonatomic,copy) NSString *start;             //巡查起点
//@property (nonatomic,copy) NSString *end;               //巡查终点
//@property (nonatomic,copy) NSString *type;              //巡查任务类型
//@property (nonatomic,copy) NSString *it_id;             //巡查任务id



@end
