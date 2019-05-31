//
//  GJSCSampleBufferHolder.h
//  GJSCRecorder
//
//  Created by Simon CORSIN on 10/09/14.
//  Copyright (c) 2014 rFlex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GJSCSampleBufferHolder : NSObject

@property (assign, nonatomic) CMSampleBufferRef sampleBuffer;

+ (GJSCSampleBufferHolder *)sampleBufferHolderWithSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
