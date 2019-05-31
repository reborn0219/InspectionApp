//
//  GJCollectionNormalModel.m
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJCollectionNormalModel.h"
#import "YYModel.h"

@implementation GJCollectionNormalModel
+ (instancetype)initWithDictionary:(NSDictionary *)dict{
    return [GJCollectionNormalModel yy_modelWithJSON:dict];
}
@end
