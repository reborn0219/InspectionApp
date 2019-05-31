//
//  GJSCRecordSessionManager.h
//  SCRecorderExamples
//
//  Created by Simon CORSIN on 15/08/14.
//
//

#import <Foundation/Foundation.h>
#import "GJSCRecorder.h"

@interface GJSCRecordSessionManager : NSObject

- (void)saveRecordSession:(GJSCRecordSession *)recordSession;

- (void)removeRecordSession:(GJSCRecordSession *)recordSession;

- (BOOL)isSaved:(GJSCRecordSession *)recordSession;

- (void)removeRecordSessionAtIndex:(NSInteger)index;

- (NSArray *)savedRecordSessions;

+ (GJSCRecordSessionManager *)sharedInstance;

@end
