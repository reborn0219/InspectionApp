//
//  GJSCSampleBufferHolder.m
//  GJSCRecorder
//
//  Created by Simon CORSIN on 10/09/14.
//  Copyright (c) 2014 rFlex. All rights reserved.
//

#import "GJSCSampleBufferHolder.h"

@implementation GJSCSampleBufferHolder

- (void)dealloc {
    if (_sampleBuffer != nil) {
        CFRelease(_sampleBuffer);
    }
}

- (void)setSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    if (_sampleBuffer != nil) {
        CFRelease(_sampleBuffer);
        _sampleBuffer = nil;
    }
    
    _sampleBuffer = sampleBuffer;
    
    if (sampleBuffer != nil) {
        CFRetain(sampleBuffer);
    }
}

+ (GJSCSampleBufferHolder *)sampleBufferHolderWithSampleBuffer:(CMSampleBufferRef)sampleBuffer {
    GJSCSampleBufferHolder *sampleBufferHolder = [GJSCSampleBufferHolder new];
    
    sampleBufferHolder.sampleBuffer = sampleBuffer;
    
    return sampleBufferHolder;
}

@end
