//
//  GJSingleTon.h
//  Baci
//
//  Created by bjovov on 15/5/9.
//  Copyright (c) 2015年 LCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJSingleTon : NSObject

@property (nonatomic, copy) NSDictionary *dict1;
@property (nonatomic,assign)NSInteger ImageTag;
//声明一个类方法用于获取单例对象
+ (GJSingleTon *)defaultSingleTon; //传值
@end
