//
//  GJSCFilterImageView.m
//  GJSCRecorder
//
//  Created by Simon Corsin on 10/8/15.
//  Copyright © 2015 rFlex. All rights reserved.
//

#import "GJSCFilterImageView.h"

@implementation GJSCFilterImageView

- (CIImage *)renderedCIImageInRect:(CGRect)rect {
    CIImage *image = [super renderedCIImageInRect:rect];

    if (image != nil) {
        if (_filter != nil) {
            image = [_filter imageByProcessingImage:image atTime:self.CIImageTime];
        }
    }

    return image;
}

- (void)setFilter:(GJSCFilter *)filter {
    _filter = filter;

    [self setNeedsDisplay];
}

@end
