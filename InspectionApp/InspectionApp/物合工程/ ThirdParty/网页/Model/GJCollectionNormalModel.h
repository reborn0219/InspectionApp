//
//  GJCollectionNormalModel.h
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJCollectionNormalModel : NSObject
@property (nonatomic,copy) NSString *imageName;  //图片名称
@property (nonatomic,copy) NSString *titleName;  //标题
+ (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
