//
//  GJLCLNetWork.h
//  Gouwoai
//
//  Created by bjovov on 15/4/21.
//  Copyright (c) 2015年 bjovov. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UIViewController"
//#import "Header.h"
//#import "MyMbd.h"

typedef void(^BLOCK)(id dictionary);
@interface GJLCLNetWork : NSObject

@property (nonatomic, copy) BLOCK bl;



//网络请求如下方法：
//interface：URL后PHP文件名


//获取数据接口
-(void)noRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//没有账号密码

-(void)requestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//有账号密码

//上传数据接口(上传数据需先获取到后台的数据令牌save_token)
-(void)submitNoRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//没有账号密码

-(void)submitRequestNetWithInterface:(NSString *)interface andM:(NSString *)m andF:(NSString *)f andA:(NSString *)a andBodyOfRequestForKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andBlock:(BLOCK)bl;//有账号密码

//转换格林尼治时间
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
@end
