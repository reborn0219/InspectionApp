//
//  GJSCProcessingQueue.h
//  GJSCRecorder
//
//  Created by Simon CORSIN on 02/07/15.
//  Copyright (c) 2015 rFlex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJSCProcessingQueue : NSObject

@property (assign, nonatomic) NSUInteger maxQueueSize;

- (void)startProcessingWithBlock:(id(^)())processingBlock;

- (void)stopProcessing;

- (id)dequeue;

@end
