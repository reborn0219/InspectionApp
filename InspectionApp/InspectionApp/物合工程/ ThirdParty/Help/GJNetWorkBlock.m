//
//  GJNetWorkBlock.m
//  Block
//
//  Created by llz on 14-12-25.
//  Copyright (c) 2014年 llz. All rights reserved.
//

#import "GJNetWorkBlock.h"


@implementation GJNetWorkBlock
- (void)requestNetWithUrl:(NSString *)urlStr andInterface:(NSString*)interface andBodyOfRequestForKeyArr:(NSArray*)keyArr andValueArr:(NSArray*)valueArr andBlock:(BLOCK)bl andType:(BOOL)isGet
{
    self.bl = bl;
    
    NSString *interfaceStr = interface;
    NSArray *keyArrHere = keyArr;
    NSArray *valueArrHere = valueArr;
    
    NSMutableString *reqStr = [NSMutableString stringWithCapacity:0];
    NSMutableString *objectStr = [NSMutableString stringWithCapacity:0];
    
    if(isGet)
    {
        [reqStr appendFormat:@"%@%@?",urlStr,interfaceStr];
        
        for(int i = 0;i<keyArrHere.count;i++)
        {
            [reqStr appendFormat:@"%@=%@",keyArrHere[i],valueArrHere[i]];
            if(i<keyArr.count-1)
            {
                [reqStr appendString:@"&"];
            }
        }
        
    }else
    {//post
        [reqStr appendFormat:@"%@%@",urlStr,interfaceStr];
        for(int i = 0;i<keyArr.count;i++)
        {
            [objectStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if(i<keyArr.count-1)
            {
                [objectStr appendString:@"&"];
            }
        }
    }
//    NSLog(@"--------参数打印：%@",objectStr);
    NSString * objecgtStr_output = [objectStr stringByReplacingOccurrencesOfString:@"&" withString:@"\n"];
    NSLog(@"--------参数打印：%@",objecgtStr_output);

    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    if(!isGet)
    {
        [req setHTTPMethod:@"POST"];

        NSString *bStr =CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                               (CFStringRef)objectStr,
                                                               NULL,
                                                               CFSTR(":/?#[]@!$’()*+,;"),
                                                               kCFStringEncodingUTF8));

        NSLog(@"%@",objectStr);
        [req setHTTPBody:[bStr dataUsingEncoding:NSUTF8StringEncoding]];
        
//      [req setHTTPBody:[objectStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
        
    }

    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError)
        {
            self.bl(@{@"ppqq":connectionError.localizedDescription});
        }
        else
        {
            id dic = [NSJSONSerialization JSONObjectWithData:data options :NSJSONReadingMutableContainers error:nil];
            self.bl(dic);
        }
    }];
    
}
//_bytes    char *    "MemCache: add 49a129848bd2edaf086b609db07af707 => AGCZl9ekQLdqt9v4GMXrxA== (STORED)\nstring(35) \"郭49a129848bd2edaf086b609db07af707\"\n{\"state\":1,\"data_ver\":0,\"ico\":\"success\",\"return_data\":{\"save_token\":\"49a129848bd2edaf086b609db07af707\"}}"    0x00006040001fb100

//_bytes    char *    "MemCache: sock Resource id #49 got 043c1d28f0daa4154a91f2b123942e73 => AGCZl9ekQLdqt9v4GMXrxA==\r\nMemCache: delete 043c1d28f0daa4154a91f2b123942e73 (DELETED)\n{\"state\":1,\"data_ver\":0,\"ico\":\"success\",\"return_data\":{\"total_nums\":0,\"total_cost\":0}}"    0x000060c0001f0300
@end
