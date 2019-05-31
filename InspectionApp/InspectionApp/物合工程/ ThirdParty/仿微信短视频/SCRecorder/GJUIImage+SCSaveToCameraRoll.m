//
//  UIImage+SCSaveToCameraRoll.m
//  GJSCRecorder
//
//  Created by Simon Corsin on 10/12/15.
//  Copyright © 2015 rFlex. All rights reserved.
//

#import "GJUIImage+SCSaveToCameraRoll.h"
#import "GJSCSaveToCameraRollOperation.h"

@implementation UIImage (SCSaveToCameraRoll)

- (void)saveToCameraRollWithCompletion:(void (^)(NSError * _Nullable))completion {
    GJSCSaveToCameraRollOperation *saveToCameraRoll = [GJSCSaveToCameraRollOperation new];
    [saveToCameraRoll saveImage:self completion:completion];
}

@end
