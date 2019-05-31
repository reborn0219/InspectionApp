//
//  GJJZLocationConverter.h
//  物联宝管家
//
//  Created by ovov on 2017/5/27.
//  Copyright © 2017年 付智鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
 #import <CoreLocation/CoreLocation.h>

@interface GJJZLocationConverter : NSObject
+ (CLLocationCoordinate2D)wgs84ToGcj02:(CLLocationCoordinate2D)location;
/**
    26  *    @brief    中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
    27  *
    28  *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
    29  *
    30  *    @param     location     中国国测局地理坐标（GCJ-02）
    31  *
    32  *    @return    世界标准地理坐标（WGS-84）
    33  */
 + (CLLocationCoordinate2D)gcj02ToWgs84:(CLLocationCoordinate2D)location;
 /**
    38  *    @brief    世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
    39  *
    40  *    @param     location     世界标准地理坐标(WGS-84)
    41  *
    42  *    @return    百度地理坐标（BD-09)
    43  */
 + (CLLocationCoordinate2D)wgs84ToBd09:(CLLocationCoordinate2D)location;
 /**
    48  *    @brief    中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
    49  *
    50  *    @param     location     中国国测局地理坐标（GCJ-02）<火星坐标>
    51  *
    52  *    @return    百度地理坐标（BD-09)
    53  */
 + (CLLocationCoordinate2D)gcj02ToBd09:(CLLocationCoordinate2D)location;
 /**
    58  *    @brief    百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
    59  *
    60  *    @param     location     百度地理坐标（BD-09)
    61  *
    62  *    @return    中国国测局地理坐标（GCJ-02）<火星坐标>
    63  */
 + (CLLocationCoordinate2D)bd09ToGcj02:(CLLocationCoordinate2D)location;
 /**
    68  *    @brief    百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
    69  *
    70  *  ####此接口有1－2米左右的误差，需要精确定位情景慎用
    71  *
    72  *    @param     location     百度地理坐标（BD-09)
    73  *
    74  *    @return    世界标准地理坐标（WGS-84）
    75  */
 + (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location;
@end
