//
//  AboutModel.h
//  InspectionApp
//
//  Created by yang on 2019/6/6.
//  Copyright © 2019 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutModel : NSObject
@property (nonatomic,copy) NSString *app_name;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *ver;
@property (nonatomic,copy) NSString *wechat;
@property (nonatomic,copy) NSString *wechat_qrc;

@end

NS_ASSUME_NONNULL_END
