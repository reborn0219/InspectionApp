//
//  GJLCLNetWork.m
//  Gouwoai
//
//  Created by bjovov on 15/4/21.
//  Copyright (c) 2015年 bjovov. All rights reserved.
//

#import "GJLCLNetWork.h"
#import "GJNetWorkBlock.h"

#import <CommonCrypto/CommonDigest.h>

@implementation GJLCLNetWork
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
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {     //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或GMT     //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];     //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];     //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];     //得到时间偏移量的差值
    NSTimeInterval interval = -destinationGMTOffset + sourceGMTOffset;     //转为得到格林时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

-(void)noRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl//无账号获取数据
{
    self.bl = bl;
    GJNetWorkBlock *net=[[GJNetWorkBlock alloc] init];
    NSDate *date0 = [NSDate date];
    NSDate *date=[self getNowDateFromatAnDate:date0];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSString *md5Str = [NSString stringWithFormat:@"%@%@%@%@%@",m,dateStr,f,APP_SECRET,a];
    NSString *last = [GJLCLNetWork md5HexDigest:md5Str];
    NSArray *key=[keyArr arrayByAddingObjectsFromArray:@[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token"]];
    NSArray *value=[valueArr arrayByAddingObjectsFromArray:@[m,f,a,APP_ID,APP_SECRET,last]];

    [net requestNetWithUrl:URL_LOCAL andInterface:interface andBodyOfRequestForKeyArr:key andValueArr:value andBlock:^(id result) {
        if([result objectForKey:@"ppqq"])
        {
            self.bl(@{@"state":@"-1"});
        }
        else
        {
            self.bl(result);
        }
    } andType:NO];
}
-(void)requestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl//有账号获取数据
{
    self.bl = bl;
    GJNetWorkBlock *net=[[GJNetWorkBlock alloc] init];
    NSString *session_key;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"session_key"]) {
        session_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_key"];
    }
    else
    {
        session_key = @"";
    }
    NSString *user_id;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        user_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    }
    else
    {
        user_id = @"";
    }
    
    NSDate *date0 = [NSDate date];
    NSDate *date=[self getNowDateFromatAnDate:date0];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSString *md5Str = [NSString stringWithFormat:@"%@%@%@%@%@",m,dateStr,f,APP_SECRET,a];
    
    NSString *last = [GJLCLNetWork md5HexDigest:md5Str];
    NSArray *key = [keyArr arrayByAddingObjectsFromArray:@[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token",@"user_id",@"session_key"]];
    NSArray *value=[valueArr arrayByAddingObjectsFromArray:@[m,f,a,APP_ID,APP_SECRET,last,user_id,session_key]];
 



    [net requestNetWithUrl:URL_LOCAL andInterface:interface andBodyOfRequestForKeyArr:key andValueArr:value andBlock:^(id result) {
        if([result objectForKey:@"ppqq"])
        {
            self.bl(@{@"state":@"-1"});
        }
        else
        {
            self.bl(result);
        }
    } andType:NO];
    
    
}

-(void)submitNoRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//没有账号密码上传数据
{
    self.bl = bl;
    GJNetWorkBlock *net=[[GJNetWorkBlock alloc] init];
    //准备获取save_token的请求参数
    NSDate *date0 = [NSDate date];
    NSDate *date = [self getNowDateFromatAnDate:date0];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSString *md5Str = [NSString stringWithFormat:@"%@%@%@%@%@",@"mlgj_api",dateStr,@"app_config",APP_SECRET,@"get_save_token"];
    
    NSString *last=[GJLCLNetWork md5HexDigest:md5Str];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *timeStap = [dateFormatter stringFromDate:[NSDate date]];
    NSString *randomStr = @"";
    
    for (int i = 0; i < 12; i++) {
        int index = arc4random() % 10;
        randomStr = [randomStr stringByAppendingFormat:@"%i",index];
    }
    NSString  *saveId = [NSString stringWithFormat:@"%@%@",timeStap,randomStr];
    


    
    NSArray *saveKey=@[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token",@"save_id"];
    NSArray *saveValue=@[@"mlgj_api",@"app_config",@"get_save_token",APP_ID,APP_SECRET,last,saveId];
    
    
    NSLog(@"%@",saveKey);
    NSLog(@"%@",saveValue);

    
    
    [net requestNetWithUrl:URL_LOCAL andInterface:@"" andBodyOfRequestForKeyArr:saveKey andValueArr:saveValue andBlock:^(id result) {
        if([result objectForKey:@"ppqq"])
        {
            self.bl(@{@"state":@"-1"});
            
        }
        else
        {
            NSLog(@"%@",result);
            
            NSDictionary *dic=result[@"return_data"];
            NSString *save_token=dic[@"save_token"];
            
            NSLog(@"save_token-%@",save_token);
            
            NSDate *date0 = [NSDate date];
            NSDate *date = [self getNowDateFromatAnDate:date0];
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc]init];
            [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
            NSString *dateStr1 = [dateformatter1 stringFromDate:date];
            NSString *md5Str1 = [NSString stringWithFormat:@"%@%@%@%@%@",m,dateStr1,f,APP_SECRET,a];
            
            NSString *last1=[GJLCLNetWork md5HexDigest:md5Str1];
            
            NSArray *key=[keyArr arrayByAddingObjectsFromArray:@[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token",@"save_token"]];
            NSArray *value=[valueArr arrayByAddingObjectsFromArray:@[m,f,a,APP_ID,APP_SECRET,last1,save_token]];
            
            NSLog(@"%@",key);
            NSLog(@"%@",value);
            
            
            GJNetWorkBlock *net1=[[GJNetWorkBlock alloc] init];
            [net1 requestNetWithUrl:URL_LOCAL andInterface:@"" andBodyOfRequestForKeyArr:key andValueArr:value andBlock:^(id result) {
                if([result objectForKey:@"ppqq"])
                {
                    self.bl(@{@"state":@"-1"});
                }
                else
                {
                    self.bl(result);
                }
            } andType:NO];
            
        }
    } andType:NO];
}
-(void)submitRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//有账号密码上传数据
{
    self.bl = bl;
    GJNetWorkBlock *net=[[GJNetWorkBlock alloc] init];
    //准备获取save_token的请求参数
    NSDate *date0 = [NSDate date];
    NSDate *date = [self getNowDateFromatAnDate:date0];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSString *md5Str = [NSString stringWithFormat:@"%@%@%@%@%@",@"mlgj_api",dateStr,@"app_config",APP_SECRET,@"get_save_token"];
    
    NSString *last=[GJLCLNetWork md5HexDigest:md5Str];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *session_key;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"session_key"]) {
        session_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"session_key"];
    }
    else
    {
        session_key = @"";
    }
    NSString *user_id;
    NSString  *saveId;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]) {
        user_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        saveId = user_id;
    }
    else
    {
        user_id = @"";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
        NSString *timeStap = [dateFormatter stringFromDate:[NSDate date]];
        NSString *randomStr = @"";
        
        for (int i = 0; i < 12; i++) {
            int index = arc4random() % 10;
            randomStr = [randomStr stringByAppendingFormat:@"%i",index];
        }
        saveId = [NSString stringWithFormat:@"%@%@",timeStap,randomStr];
        
    }

    
    NSArray *saveKey = @[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token",@"save_id"];
    NSArray *saveValue=@[@"mlgj_api",@"app_config",@"get_save_token",APP_ID,APP_SECRET,last,saveId];
    [net requestNetWithUrl:URL_LOCAL andInterface:@"" andBodyOfRequestForKeyArr:saveKey andValueArr:saveValue andBlock:^(id result) {
        if([result objectForKey:@"ppqq"])
        {
            self.bl(@{@"state":@"-1"});
        }
        else
        {
            NSLog(@"%@",result[@"return_data"]);
            NSDictionary *dic= result [@"return_data"];
            NSString *save_token = dic[@"save_token"]?:@"";
            NSLog(@"save_token-%@",save_token);
            NSDate *date1 = [NSDate date];
            NSDateFormatter *dateformatter1 = [[NSDateFormatter alloc]init];
            [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
            NSString *dateStr1 = [dateformatter1 stringFromDate:date1];
            NSString *md5Str1 = [NSString stringWithFormat:@"%@%@%@%@%@",m,dateStr1,f,APP_SECRET,a];
            NSString *last1=[GJLCLNetWork md5HexDigest:md5Str1];
            NSArray *key=[keyArr arrayByAddingObjectsFromArray:@[@"m",@"f",@"a",@"app_id",@"app_secret",@"access_token",@"save_token",@"user_id",@"session_key"]];
            NSArray *value=[valueArr arrayByAddingObjectsFromArray:@[m,f,a,APP_ID,APP_SECRET,last1,save_token,user_id,session_key]];
            GJNetWorkBlock *net1=[[GJNetWorkBlock alloc] init];
            [net1 requestNetWithUrl:URL_LOCAL andInterface:@"" andBodyOfRequestForKeyArr:key andValueArr:value andBlock:^(id result) {
                if([result objectForKey:@"ppqq"])
                {
                    self.bl(@{@"state":@"-1"});
                }
                else
                {
                    self.bl(result);
                }
            } andType:NO];
            
        }
    } andType:NO];
}



@end
