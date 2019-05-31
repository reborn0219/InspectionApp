//
//  NSURL+SCSaveToCameraRoll.m
//  GJSCRecorder
//
//  Created by Simon Corsin on 10/10/15.
//  Copyright © 2015 rFlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJNSURL+SCSaveToCameraRoll.h"
#import "GJSCSaveToCameraRollOperation.h"

@implementation NSURL (SCSaveToCameraRoll)

- (void)saveToCameraRollWithCompletion:(void (^)(NSString * _Nullable path, NSError * _Nullable error))completion {
    GJSCSaveToCameraRollOperation *saveToCameraRoll = [GJSCSaveToCameraRollOperation new];
    [saveToCameraRoll saveVideoURL:self completion:completion];
}

@end
