//
//  HomeModel.h
//  InspectionApp
//
//  Created by yang on 2019/6/15.
//  Copyright © 2019 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
@property (nonatomic,copy) NSString *company_id;
@property (nonatomic,copy) NSString *company_name;
@property (nonatomic,copy) NSString *finished_num;
@property (nonatomic,copy) NSString *iscaptain;
@property (nonatomic,copy) NSString *unfinished_num;

@end

NS_ASSUME_NONNULL_END
