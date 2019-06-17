//
//  PPViewTool.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPViewTool : NSObject

/**
 view渐变效果

 @param view 需要渐变色的View
 @return 返回layer层
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view;
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view withFrame:(CGRect)rect withCornerRadius:(CGFloat)radius;
+(CAGradientLayer *)setGradualChangingToRed:(UIView *)view withFrame:(CGRect)rect;
+(void)setGradient:(UIView *)view;
+(void)setGradient:(UIView *)view withCornerRadius:(CGFloat)radius;
/**
 根据目标图片制作一个盖水印的图片
 
 @param originalImage 源图片
 @param title 水印文字
 @param markFont 水印文字font(如果不传默认为23)
 @param markColor 水印文字颜色(如果不传递默认为源图片的对比色)
 @return 返回盖水印的图片
 */
+ (UIImage *)getWaterMarkImage: (UIImage *)originalImage andTitle: (NSString *)title andMarkFont: (UIFont *)markFont andMarkColor: (UIColor *)markColor;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (UIViewController *)getCurrentViewController;
+(NSString *)orderTypeToString:(NSInteger)index;
@end
