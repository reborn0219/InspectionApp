//
//  UIImage+Extension.h
//  FZWeibo
//
//  Created by 付智鹏 on 15/12/23.
//  Copyright © 2015年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//根据图片名自动加载iOS6和7
+(UIImage *)imageWithName:(NSString *)name;
//根据图片名返回一张自由拉伸的图片
+(UIImage *)resizedImage:(NSString *)name;
//根据图片名返回一张高亮状态的button图片
+(UIImage *)imagewithColor:(UIColor *)color;

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
@end
