//
//  ImageProcessing.h
//  物联宝管家
//
//  Created by yang on 2019/4/11.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageProcessing : NSObject
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end

NS_ASSUME_NONNULL_END
