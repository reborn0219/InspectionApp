//
//  GJSCFilter+UIImage.m
//  GJSCRecorder
//
//  Created by Simon Corsin on 10/18/15.
//  Copyright © 2015 rFlex. All rights reserved.
//

#import "GJSCContext.h"
#import "GJSCFilter+UIImage.h"

@implementation GJSCFilter (UIImage)

- (UIImage *)UIImageByProcessingUIImage:(UIImage *)image {
    return [self UIImageByProcessingUIImage:image atTime:0];
}

- (UIImage *)UIImageByProcessingUIImage:(UIImage *)uiImage atTime:(CFTimeInterval)time {
    static GJSCContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [GJSCContext contextWithType:SCContextTypeDefault options:nil];
    });

    CIImage *image = nil;

    if (uiImage != nil) {
        if (uiImage.CIImage != nil) {
            image = uiImage.CIImage;
        } else {
            image = [CIImage imageWithCGImage:uiImage.CGImage];
        }
    }

    image = [self imageByProcessingImage:image atTime:time];

    if (image != nil) {
        CGImageRef cgImage = [context.CIContext createCGImage:image fromRect:image.extent];

        UIImage *outputImage = [UIImage imageWithCGImage:cgImage];

        CGImageRelease(cgImage);

        return outputImage;
    } else {
        return nil;
    }
}

@end
