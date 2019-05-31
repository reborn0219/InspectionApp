//
//  GJSingleTon.m
//  Baci
//
//  Created by bjovov on 15/5/9.
//  Copyright (c) 2015年 LCL. All rights reserved.
//

#import "GJSingleTon.h"


static GJSingleTon *st = nil;
@implementation GJSingleTon
//实现类方法
+ (GJSingleTon *)defaultSingleTon
{
    //GCD语法  Block块中的代码只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //判断st对象是否为空，为空就创建
        if (st == nil) {
            st = [[self alloc] init];
        }
    });
    return st;
}
@end

