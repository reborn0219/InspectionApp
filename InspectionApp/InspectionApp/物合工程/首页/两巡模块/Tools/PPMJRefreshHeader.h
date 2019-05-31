//
//  PPMJRefreshHeader.h
//  物联宝管家
//
//  Created by yang on 2019/4/3.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJMJRefreshStateHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPMJRefreshHeader : GJMJRefreshStateHeader

@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end

NS_ASSUME_NONNULL_END
