//
//  PPDateTool.h
//  物联宝管家
//
//  Created by yang on 2019/4/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPDateTool : NSObject

+(NSDate *)stringConversionNSDate:(NSString *)dateStr;
+(NSString *)dateConversionNSString:(NSDate *)date;
+(NSString*)stringFormat:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
