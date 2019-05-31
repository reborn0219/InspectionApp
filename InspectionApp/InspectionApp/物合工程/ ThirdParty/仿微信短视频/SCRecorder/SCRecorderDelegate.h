//
//  SCRecorderDelegate.h
//  GJSCRecorder
//
//  Created by Simon CORSIN on 18/03/15.
//  Copyright (c) 2015 rFlex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "GJSCRecorder.h"

typedef NS_ENUM(NSInteger, SCFlashMode) {
    SCFlashModeOff  = AVCaptureFlashModeOff,
    SCFlashModeOn   = AVCaptureFlashModeOn,
    SCFlashModeAuto = AVCaptureFlashModeAuto,
    SCFlashModeLight
};

@class GJSCRecorder;

@protocol SCRecorderDelegate <NSObject>

@optional

/**
 Called when the recorder has reconfigured the videoInput
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didReconfigureVideoInput:(NSError *__nullable)videoInputError;

/**
 Called when the recorder has reconfigured the audioInput
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didReconfigureAudioInput:(NSError *__nullable)audioInputError;

/**
 Called when the flashMode has changed
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didChangeFlashMode:(SCFlashMode)flashMode error:(NSError *__nullable)error;

/**
 Called when the recorder has lost the focus. Returning true will make the recorder
 automatically refocus at the center.
 */
- (BOOL)recorderShouldAutomaticallyRefocus:(GJSCRecorder *__nonnull)recorder;

/**
 Called before the recorder will start focusing
 */
- (void)recorderWillStartFocus:(GJSCRecorder *__nonnull)recorder;

/**
 Called when the recorder has started focusing
 */
- (void)recorderDidStartFocus:(GJSCRecorder *__nonnull)recorder;

/**
 Called when the recorder has finished focusing
 */
- (void)recorderDidEndFocus:(GJSCRecorder *__nonnull)recorder;

/**
 Called before the recorder will start adjusting exposure
 */
- (void)recorderWillStartAdjustingExposure:(GJSCRecorder *__nonnull)recorder;

/**
 Called when the recorder has started adjusting exposure
 */
- (void)recorderDidStartAdjustingExposure:(GJSCRecorder *__nonnull)recorder;

/**
 Called when the recorder has finished adjusting exposure
 */
- (void)recorderDidEndAdjustingExposure:(GJSCRecorder *__nonnull)recorder;

/**
 Called when the recorder has initialized the audio in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didInitializeAudioInSession:(GJSCRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has initialized the video in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didInitializeVideoInSession:(GJSCRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has started a segment in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didBeginSegmentInSession:(GJSCRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has completed a segment in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didCompleteSegment:(GJSCRecordSessionSegment *__nullable)segment inSession:(GJSCRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has appended a video buffer in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didAppendVideoSampleBufferInSession:(GJSCRecordSession *__nonnull)session;

/**
 Called when the recorder has appended an audio buffer in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didAppendAudioSampleBufferInSession:(GJSCRecordSession *__nonnull)session;

/**
 Called when the recorder has skipped an audio buffer in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didSkipAudioSampleBufferInSession:(GJSCRecordSession *__nonnull)session;

/**
 Called when the recorder has skipped a video buffer in a session
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didSkipVideoSampleBufferInSession:(GJSCRecordSession *__nonnull)session;

/**
 Called when a session has reached the maxRecordDuration
 */
- (void)recorder:(GJSCRecorder *__nonnull)recorder didCompleteSession:(GJSCRecordSession *__nonnull)session;

/**
 Gives an opportunity to the delegate to create an info dictionary for a record segment.
 */
- (NSDictionary *__nullable)createSegmentInfoForRecorder:(GJSCRecorder *__nonnull)recorder;

@end
