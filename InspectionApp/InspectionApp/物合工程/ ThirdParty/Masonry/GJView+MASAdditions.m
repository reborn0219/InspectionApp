//
//  UIView+MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GJView+MASAdditions.h"
#import <objc/runtime.h>

@implementation MAS_VIEW (MASAdditions)

- (NSArray *)mas_makeConstraints:(void(^)(GJMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GJMASConstraintMaker *constraintMaker = [[GJMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(^)(GJMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GJMASConstraintMaker *constraintMaker = [[GJMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(^)(GJMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GJMASConstraintMaker *constraintMaker = [[GJMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (GJMASViewAttribute *)mas_left {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (GJMASViewAttribute *)mas_top {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (GJMASViewAttribute *)mas_right {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (GJMASViewAttribute *)mas_bottom {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (GJMASViewAttribute *)mas_leading {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (GJMASViewAttribute *)mas_trailing {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (GJMASViewAttribute *)mas_width {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (GJMASViewAttribute *)mas_height {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (GJMASViewAttribute *)mas_centerX {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (GJMASViewAttribute *)mas_centerY {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (GJMASViewAttribute *)mas_baseline {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (GJMASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if TARGET_OS_IPHONE

- (GJMASViewAttribute *)mas_leftMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (GJMASViewAttribute *)mas_rightMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (GJMASViewAttribute *)mas_topMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (GJMASViewAttribute *)mas_bottomMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (GJMASViewAttribute *)mas_leadingMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (GJMASViewAttribute *)mas_trailingMargin {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (GJMASViewAttribute *)mas_centerXWithinMargins {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (GJMASViewAttribute *)mas_centerYWithinMargins {
    return [[GJMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
