//
//  PatrolAnnotationModel.h
//  物联宝管家
//
//  Created by yang on 2019/4/9.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PatrolAnnotationModel : MAPointAnnotation

@property(nonatomic,copy)NSString * annotation_status;
@property(nonatomic,copy)NSString * annotation_name;

@end

NS_ASSUME_NONNULL_END
