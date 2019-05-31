 //
//  GJFZAccount.m
//  FZWeibo
//
//  Created by 付智鹏 on 16/2/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZAccount.h"

@implementation GJFZAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    GJFZAccount *account = [[self alloc]init];
    account.data_ver = dict[@"data_ver"];
    return account;
}
/**
 *  当一个对象要归档进沙盒,就会调用这个方法
 *目的:在这个方法中说明这个对象的哪些属性要存进沙盒
 */
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.data_ver forKey:@"data_ver"];

}
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.data_ver = [decoder decodeObjectForKey:@"dat_aver"];
    }
    return self;
}

@end
