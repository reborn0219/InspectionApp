//
//  ImageProcessing.m
//  物联宝管家
//
//  Created by yang on 2019/4/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "ImageProcessing.h"

@implementation ImageProcessing
//压缩图片
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth//图片压缩
{
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImages = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImages;
    
}
@end
