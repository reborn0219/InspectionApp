//
//  NSString+Extension.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
+(NSString *)stringWithModule:(NSString *)m Filename:(NSString *)f Action:(NSString *)a;
+ (NSString *)md5HexDigest:(NSString*)input;//MD5
+(NSString *)md5StringNB:( NSString *)str;

@end
