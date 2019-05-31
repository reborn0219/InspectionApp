//
//  SCVideoBuffer.m
//  GJSCRecorder
//
//  Created by Simon CORSIN on 02/07/15.
//  Copyright (c) 2015 rFlex. All rights reserved.
//

#import "GJSCIOPixelBuffers.h"

@implementation GJSCIOPixelBuffers

- (instancetype)initWithInputPixelBuffer:(CVPixelBufferRef)inputPixelBuffer outputPixelBuffer:(CVPixelBufferRef)outputPixelBuffer time:(CMTime)time {
    self = [super init];
    
    if (self) {
        _inputPixelBuffer = inputPixelBuffer;
        _outputPixelBuffer = outputPixelBuffer;
        _time = time;
        
        CVPixelBufferRetain(inputPixelBuffer);
        CVPixelBufferRetain(outputPixelBuffer);
    }
    
    return self;
}

- (void)dealloc {
    CVPixelBufferRelease(_inputPixelBuffer);
    CVPixelBufferRelease(_outputPixelBuffer);
}

+ (GJSCIOPixelBuffers *)IOPixelBuffersWithInputPixelBuffer:(CVPixelBufferRef)inputPixelBuffer outputPixelBuffer:(CVPixelBufferRef)outputPixelBuffer time:(CMTime)time {
    return [[GJSCIOPixelBuffers alloc] initWithInputPixelBuffer:inputPixelBuffer outputPixelBuffer:outputPixelBuffer time:time];
}

@end
