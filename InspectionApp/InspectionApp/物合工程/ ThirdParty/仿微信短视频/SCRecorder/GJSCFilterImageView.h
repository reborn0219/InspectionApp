//
//  GJSCFilterImageView.h
//  GJSCRecorder
//
//  Created by Simon Corsin on 10/8/15.
//  Copyright © 2015 rFlex. All rights reserved.
//

#import "GJSCImageView.h"
#import "GJSCFilter.h"

@interface GJSCFilterImageView : GJSCImageView

/**
 The filter to apply when rendering. If nil is set, no filter will be applied
 */
@property (strong, nonatomic) GJSCFilter *__nullable filter;

@end
