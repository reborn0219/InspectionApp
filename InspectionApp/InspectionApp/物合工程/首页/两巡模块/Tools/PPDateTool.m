//
//  PPDateTool.m
//  物联宝管家
//
//  Created by yang on 2019/4/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPDateTool.h"

@implementation PPDateTool
+(NSDate *)stringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

+(NSString *)dateConversionNSString:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"M月dd日";
    return  [formatter stringFromDate:date];
    
}
+(NSString*)stringFormat:(NSString *)string{
  return [PPDateTool dateConversionNSString:[PPDateTool stringConversionNSDate:string]];
}

@end

