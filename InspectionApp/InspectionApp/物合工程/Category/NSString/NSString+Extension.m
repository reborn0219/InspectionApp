//
//  NSString+Extension.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
+(NSString *)stringWithModule:(NSString *)m Filename:(NSString *)f Action:(NSString *)a 
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *appsecrets = APP_SECRET;
    NSString *accesstoken = [NSString stringWithFormat:@"%@%@%@%@%@",m,dateTime,f,appsecrets,a];
    NSString *URL = [NSString md5HexDigest:accesstoken];
    return URL;
}

+ (NSString *)md5HexDigest:(NSString*)input//MD5
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(NSString *)md5StringNB:( NSString *)str
{
    const char *myPasswd = [str UTF8String];
    unsigned char mdc[CC_MD5_DIGEST_LENGTH];
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    [md5String appendFormat:@"%02x",mdc[ CC_MD5_DIGEST_LENGTH ]];
    for ( int i = 0 ; i< CC_MD5_DIGEST_LENGTH;i++) {
        [md5String appendFormat : @"%02x" ,mdc[i]];
    }
    return md5String;
}
@end
