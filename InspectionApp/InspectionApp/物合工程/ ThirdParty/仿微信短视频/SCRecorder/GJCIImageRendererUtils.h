//
//  GJCIImageRendererUtils.h
//  GJSCRecorder
//
//  Created by Simon CORSIN on 13/09/14.
//  Copyright (c) 2014 rFlex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GJSCSampleBufferHolder.h"
#import "CIImageRenderer.h"

@interface GJCIImageRendererUtils : NSObject

+ (CGRect)processRect:(CGRect)rect withImageSize:(CGSize)imageSize contentScale:(CGFloat)contentScale contentMode:(UIViewContentMode)mode;

+ (CIImage *)generateImageFromSampleBufferHolder:(GJSCSampleBufferHolder *)sampleBufferHolder;

+ (CGAffineTransform)preferredCIImageTransformFromUIImage:(UIImage *)image;

+ (void)putUIImage:(UIImage *)image toRenderer:(id<CIImageRenderer>)renderer;

@end
