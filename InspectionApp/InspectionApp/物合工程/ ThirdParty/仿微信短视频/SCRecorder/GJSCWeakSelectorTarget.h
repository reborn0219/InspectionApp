//
//  GJSCWeakSelectorTarget.h
//  GJSCRecorder
//
//  Created by Simon CORSIN on 04/04/15.
//  Copyright (c) 2015 rFlex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJSCWeakSelectorTarget : NSObject

@property (readonly, nonatomic, weak) id target;
@property (readonly, nonatomic) SEL targetSelector;
@property (readonly, nonatomic) SEL handleSelector;

- (instancetype)initWithTarget:(id)target targetSelector:(SEL)targetSelector;

- (BOOL)sendMessageToTarget:(id)param;

@end
