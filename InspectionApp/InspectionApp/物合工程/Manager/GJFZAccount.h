//
//  GJFZAccount.h
//  FZWeibo
//
//  Created by 付智鹏 on 16/2/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJFZAccount : NSObject <NSCoding>

@property(nonatomic,copy)NSString *data_ver;
+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
